with Ada.Text_IO;

procedure Day1
   with SPARK_Mode => On
is

   function Mass_To_Fuel (Mass : Natural) return Natural is
      ((Mass / 3) -2);

   procedure Fuel_Calculation (Fuel : in out Natural)
   is

      Min_Fuel : constant Natural := 6;
      Fuel_Remaining : Natural := Fuel;

   begin

      while Fuel_Remaining > Min_Fuel loop
         Fuel_Remaining := Mass_To_Fuel(Fuel_Remaining);
         Fuel := Fuel + Fuel_Remaining;
      end loop;

   end Fuel_Calculation;

   Input_Mass : Natural;
   Fuel       : Natural;

   Accumulator_1 : Natural := 0;
   Accumulator_2 : Natural := 0;

begin

   loop
      declare
         Line : constant String := Ada.Text_IO.Get_Line;
      begin

         Input_Mass := Natural'Value(Line);
         Fuel := Mass_To_Fuel(Input_Mass);

         Accumulator_1 := Accumulator_1 + Fuel;

         -- Next, deal with the fuel the fuel needs (and etc.)
         Fuel_Calculation(Fuel);

         Accumulator_2 := Accumulator_2 + Fuel;

         exit when Ada.Text_IO.End_Of_File;

      end;

   end loop;
   
   Ada.Text_IO.Put_Line("Total Part 1: " & Accumulator_1'Image);
   Ada.Text_IO.Put_Line("Total Part 2: " & Accumulator_2'Image);

end Day1;
