with Ada.Text_IO;
with GNAT.String_Split;

procedure Day4 
   with SPARK_Mode => On
is

   type Passcode is mod 1_000_000;
   
   type Pass_Digit is mod 10;

   type Num_Digits is range 1 .. 6;

   type Pass_Digits is array (Num_Digits) of Pass_Digit;

   function Test_A (Code : Pass_Digits) return Boolean
   is ((Code (1) <= Code (2) and then
      Code (2) <= Code (3) and then
      Code (3) <= Code (4) and then
      Code (4) <= Code (5) and then
      Code (5) <= Code (6))
      
      and then

      (Code (1) = Code (2) or else
      Code (2) = Code (3) or else
      Code (3) = Code (4) or else
      Code (4) = Code (5) or else
      Code (5) = Code (6)));

   function Test_B (Code : Pass_Digits) return Boolean 
   is
      Found_Count : Pass_Digit := 0;
   begin

      -- This is pretty messy  :( 
      for I in Num_Digits range Num_Digits'First .. Num_Digits'Last -1
      loop
         if Code(I) = Code(Num_Digits'Succ(I)) then
            Found_Count := Found_Count + 1;
         elsif Found_Count = 1 then
            -- Found what we want - so exit.
            return True;
         else
            Found_Count := 0;
         end if;
      end loop;
      
      -- Handles the pair being right at the end.
      if Found_Count = 1 then
         return True;
      else
         return False;
      end if;

   end Test_B;
       


   Input_Split : GNAT.String_Split.Slice_Set;

   Low : Passcode;
   High : Passcode;

   Code : String (1 .. 7);
   Current_Code : Pass_Digits;

   Num_Valid_1 : Natural := 0;
   Num_Valid_2 : Natural := 0;

begin
   loop
      declare
         Line : constant String := Ada.Text_IO.Get_Line;
      begin
         GNAT.String_Split.Create(From       => Line,
                                  Separators => "-",
                                  S          => Input_Split);
         
         Low := Passcode'Value
            (GNAT.String_Split.Slice 
               (Input_Split, GNAT.String_Split.Slice_Number(1))); 
         High := Passcode'Value
            (GNAT.String_Split.Slice 
               (Input_Split, GNAT.String_Split.Slice_Number(2))); 

         for I in Passcode range Low .. High loop
            Code := I'Image;
            Current_Code (1) := 
               Pass_Digit'Value(Code(Code'First + 1 .. Code'First + 1));
            Current_Code (2) := 
               Pass_Digit'Value(Code(Code'First + 2 .. Code'First + 2));
            Current_Code (3) := 
               Pass_Digit'Value(Code(Code'First + 3 .. Code'First + 3));
            Current_Code (4) := 
               Pass_Digit'Value(Code(Code'First + 4 .. Code'First + 4));
            Current_Code (5) := 
               Pass_Digit'Value(Code(Code'First + 5 .. Code'First + 5));
            Current_Code (6) := 
               Pass_Digit'Value(Code(Code'First + 6  ..Code'First + 6));

            if Test_A(Current_Code) then
               Num_Valid_1 := Num_Valid_1 + 1;
               if Test_B (Current_Code) then
                  Num_Valid_2 := Num_Valid_2 + 1;
               end if;
            end if;

         end loop;
         Ada.Text_IO.Put_Line("Num Valid 1:" & Num_Valid_1'Image);
         Ada.Text_IO.Put_Line("Num Valid 2:" & Num_Valid_2'Image);

         exit when Ada.Text_IO.End_Of_File;
      end;
   end loop;

end Day4;
