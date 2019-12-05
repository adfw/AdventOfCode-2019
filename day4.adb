with Ada.Text_IO;
with GNAT.String_Split;

procedure Day4 
   with SPARK_Mode => On
is

   type Passcode is mod 1_000_000;
   
   type Pass_Digit is mod 10;


   function Test (Code : String) return Boolean
   is
      Position_1 : constant Pass_Digit := 
         Pass_Digit'Value(Code(Code'First + 1 .. Code'First + 1));
      Position_2 : constant Pass_Digit := 
         Pass_Digit'Value(Code(Code'First + 2 .. Code'First + 2));
      Position_3 : constant Pass_Digit := 
         Pass_Digit'Value(Code(Code'First + 3 .. Code'First + 3));
      Position_4 : constant Pass_Digit := 
         Pass_Digit'Value(Code(Code'First + 4 .. Code'First + 4));
      Position_5 : constant Pass_Digit := 
         Pass_Digit'Value(Code(Code'First + 5 .. Code'First + 5));
      Position_6 : constant Pass_Digit := 
         Pass_Digit'Value(Code(Code'First + 6  ..Code'First + 6));

   begin
      return (Position_1 <= Position_2 and then
      Position_2 <= Position_3 and then
      Position_3 <= Position_4 and then
      Position_4 <= Position_5 and then
      Position_5 <= Position_6)
      
      and then

      (Position_1 = Position_2 or else
      Position_2 = Position_3 or else
      Position_3 = Position_4 or else
      Position_4 = Position_5 or else
      Position_5 = Position_6);
   end Test;


   Input_Split : GNAT.String_Split.Slice_Set;

   Low : Passcode;
   High : Passcode;

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
            if Test(I'Image) then
               Num_Valid := Num_Valid + 1;
            end if;
         end loop;
         Ada.Text_IO.Put_Line("Num Valid:" & Num_Valid'Image);

         exit when Ada.Text_IO.End_Of_File;
      end;
   end loop;

end Day4;
