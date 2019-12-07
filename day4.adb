with Ada.Text_IO;
with GNAT.String_Split;

procedure Day4 
   with SPARK_Mode => On
is

   type Passcode is mod 1_000_000;
   
   type Pass_Digit is mod 10;

   type Pass_Digits is record
      Pos_1 : Pass_Digit;
      Pos_2 : Pass_Digit;
      Pos_3 : Pass_Digit;
      Pos_4 : Pass_Digit;
      Pos_5 : Pass_Digit;
      Pos_6 : Pass_Digit;
   end record;


   function Test_A (Code : Pass_Digits) return Boolean
   is ((Code.Pos_1 <= Code.Pos_2 and then
      Code.Pos_2 <= Code.Pos_3 and then
      Code.Pos_3 <= Code.Pos_4 and then
      Code.Pos_4 <= Code.Pos_5 and then
      Code.Pos_5 <= Code.Pos_6)
      
      and then

      (Code.Pos_1 = Code.Pos_2 or else
      Code.Pos_2 = Code.Pos_3 or else
      Code.Pos_3 = Code.Pos_4 or else
      Code.Pos_4 = Code.Pos_5 or else
      Code.Pos_5 = Code.Pos_6));


   Input_Split : GNAT.String_Split.Slice_Set;

   Low : Passcode;
   High : Passcode;

   Code : String (1 .. 7);
   Current_Code : Pass_Digits;

   Num_Valid : Natural := 0;

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
            --Ada.Text_IO.Put_Line(I'Image(i'Image'First + 1 .. i'Image'First + 1));
            Code := I'Image;
            Current_Code.Pos_1 := 
               Pass_Digit'Value(Code(Code'First + 1 .. Code'First + 1));
            Current_Code.Pos_2 := 
               Pass_Digit'Value(Code(Code'First + 2 .. Code'First + 2));
            Current_Code.Pos_3 := 
               Pass_Digit'Value(Code(Code'First + 3 .. Code'First + 3));
            Current_Code.Pos_4 := 
               Pass_Digit'Value(Code(Code'First + 4 .. Code'First + 4));
            Current_Code.Pos_5 := 
               Pass_Digit'Value(Code(Code'First + 5 .. Code'First + 5));
            Current_Code.Pos_6 := 
               Pass_Digit'Value(Code(Code'First + 6  ..Code'First + 6));
            if Test_A(Current_Code) then
               Num_Valid := Num_Valid + 1;
            end if;
         end loop;
         Ada.Text_IO.Put_Line("Num Valid:" & Num_Valid'Image);

         exit when Ada.Text_IO.End_Of_File;
      end;
   end loop;

end Day4;
