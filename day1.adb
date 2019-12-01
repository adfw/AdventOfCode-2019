with Ada.Text_IO;

procedure Day1 is

   Input_Mass : Natural;
   Fuel       : Natural;

   Accumulator : Natural := 0;

begin

   loop
      declare
         Line : String := Ada.Text_IO.Get_Line;
      begin

         Input_Mass := Natural'Value(Line);
         Fuel := (Input_Mass / 3) - 2; -- TODO: Underflow guard?
         Accumulator := Accumulator + Fuel;

         exit when Ada.Text_IO.End_Of_File;

      end;

   end loop;
   
   Ada.Text_IO.Put_Line("Total: " & Accumulator'Image);

end Day1;
