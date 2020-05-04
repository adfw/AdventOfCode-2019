with Ada.Text_IO;

with Coord;

procedure Repro
   with SPARK_Mode => On
is

   -- Instantiate Vec_2 to have a Capacity of 200.
   Vec_2 : Coord.Points.Vector (200);

   Pos : constant Natural := 12345;

begin
   
   for J in Positive range 1 .. 40005 loop
      Coord.Points.Append(Vec_2, Pos);
      Ada.Text_IO.Put_Line ("Vector Append" & Coord.Points.Length(Vec_2)'Image);
   end loop;

   Ada.Text_IO.Put_Line
     ("Vector Finished" & Coord.Points.Length(Vec_2)'Image);

end Repro;
