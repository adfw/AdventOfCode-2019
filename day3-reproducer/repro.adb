with Ada.Containers.Formal_Vectors;
with Ada.Text_IO;

procedure Repro
   with SPARK_Mode => On
is

   package Points is new Ada.Containers.Formal_Vectors
     (Element_Type => Natural,
      Index_Type   => Natural);

   -- Instantiate Vec_2 to have a Capacity of 200.
   Vec_2 : Points.Vector (200);

   Pos : constant Natural := 12345;

begin
   
   -- Fails SPARK analysis, but we knew that was going to happen...
   for J in Positive range 1 .. 40005 loop
      Points.Append(Vec_2, Pos);
      Ada.Text_IO.Put_Line ("Vector Append" & Points.Length(Vec_2)'Image);
   end loop;

   Ada.Text_IO.Put_Line
     ("Vector Finished" & Points.Length(Vec_2)'Image);

end Repro;
