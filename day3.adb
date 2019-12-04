with Ada.Containers;
with Ada.Text_IO;
with GNAT.String_Split;

with Coord;

procedure Day3
   with SPARK_Mode => On
is


   procedure String_To_Vector
      (Input_Split_1 : GNAT.String_Split.Slice_Set;
       Input_Split_2 : GNAT.String_Split.Slice_Set)
   is
      type Wire_1_Vecs_T is array 
         (Natural range 0 .. Natural
           (GNAT.String_Split.Slice_Count (Input_Split_1)) - 1) of Coord.Vector;

      type Wire_2_Vecs_T is array 
         (Natural range 0 .. Natural
           (GNAT.String_Split.Slice_Count (Input_Split_2)) - 1) of Coord.Vector;

      Wire_1_Vecs : Wire_1_Vecs_T;
      Wire_1_Len  : Natural := 0;
      Wire_2_Vecs : Wire_2_Vecs_T;
      Wire_2_Len  : Natural := 0;

      procedure Manhattan_Wires
        (Wire_1_Vecs : Wire_1_Vecs_T;
         Wire_1_Len  : Natural;
         Wire_2_Vecs : Wire_2_Vecs_T;
         Wire_2_Len  : Natural)
      is
         Wire_1 : Coord.Coord_Points.Vector ;--(Ada.Containers.Count_Type(Wire_1_Len));
         Wire_2 : Coord.Coord_Points.Vector ;--(Ada.Containers.Count_Type(Wire_2_Len));

         Pos : Coord.Coord;
         Distance : Natural;
         Smallest_Distance : Natural := Natural'Last;
      begin
         
         Pos := Coord.Start_Coord;
         Coord.Coord_Points.Append(Wire_1, Pos);
         for Vec of Wire_1_Vecs loop
            Coord.Expand_Vec (Vec, Wire_1, Pos);
         end loop;
         Ada.Text_IO.Put_Line("Wire 1 Created" & Coord.Coord_Points.Length(Wire_1)'Image);

         Pos := Coord.Start_Coord;
         Coord.Coord_Points.Append(Wire_2, Pos);
         Ada.Text_IO.Put_Line("Wire 2 Append" & Coord.Coord_Points.Length(Wire_1)'Image);
         for Vec of Wire_2_Vecs loop
            Coord.Expand_Vec (Vec, Wire_2, Pos);
         end loop;

         Ada.Text_IO.Put_Line("Wire 1 Created" & Coord.Coord_Points.Length(Wire_1)'Image);
         Ada.Text_IO.Put_Line("Wire 2 Created" & Coord.Coord_Points.Length(Wire_2)'Image);

         for J in Coord.Coord_Points.First_Index (Wire_1) .. 
            Coord.Coord_Points.Last_Index (Wire_1) loop
            --Ada.Text_IO.Put_Line("W1" & J'Image & Coord.Coord_Points.Element(Wire_1, J).Y'Image);
            if Coord.Coord_Points.Contains(Wire_2, Coord.Coord_Points.Element(Wire_1, J))
            then
                Distance := abs(Coord.Coord_Points.Element(Wire_1, J).X) + abs(Coord.Coord_Points.Element(Wire_1, J).Y);
                Ada.Text_IO.Put_Line("FOUND" & Distance'Image);
                if Distance > 0 and then Distance < Smallest_Distance then
                   Smallest_Distance := Distance;
                end if;
            end if;
         end loop;

         for J in Coord.Coord_Points.First_Index (Wire_2) .. 
            Coord.Coord_Points.Last_Index (Wire_2) loop
            null;--  Ada.Text_IO.Put_Line("W2" & J'Image & Coord.Coord_Points.Element(Wire_2, J).Y'Image);
         end loop;

         Ada.Text_IO.Put_Line("Fin:" & Coord.Coord_Points.Length(Wire_1)'Image);
         Ada.Text_IO.Put_Line("Smallest Distance:" & Smallest_Distance'Image);

      end Manhattan_Wires;


   begin
      -- TODO: Go through each item in the slice, and extrapolate all the
      --       'points' on the vector. Then, we can do Vector comparisons,
      --       but I can't be bothered doing anything fancy like min/max
      --       checking.

      -- This is bloody messy. Could be made into a generic.
      for I in Wire_1_Vecs'Range loop
         declare
            String_Vector : constant String := (GNAT.String_Split.Slice 
                 (Input_Split_1, GNAT.String_Split.Slice_Number(I + 1)));
         begin
            Wire_1_Vecs (I) := Coord.Vector'
              (Direction => Coord.Direction_T'Value
                 (String_Vector (String_Vector'First .. String_Vector'First)),
               Size      => Natural'Value
                 (String_Vector (String_Vector'First + 1 .. String_Vector'Last)));
            Wire_1_Len := Wire_1_Len + Wire_1_Vecs (I).Size;
         end;
      end loop;

      for I in Wire_2_Vecs'Range loop
         declare
            String_Vector : constant String := (GNAT.String_Split.Slice 
                 (Input_Split_2, GNAT.String_Split.Slice_Number(I + 1)));
         begin
            Wire_2_Vecs (I) := Coord.Vector'
              (Direction => Coord.Direction_T'Value
                 (String_Vector (String_Vector'First .. String_Vector'First)),
               Size      => Natural'Value
                 (String_Vector (String_Vector'First + 1 .. String_Vector'Last)));
            Wire_2_Len := Wire_2_Len + Wire_2_Vecs (I).Size;
         end;
      end loop;
      Ada.Text_IO.Put_Line(Wire_1_Vecs(0).Direction'Image & Wire_1_Vecs(0).Size'Image);
      Ada.Text_IO.Put_Line(Wire_2_Vecs(0).Direction'Image & Wire_2_Vecs(0).Size'Image);

      Manhattan_Wires(Wire_1_Vecs, Wire_1_Len, Wire_2_Vecs, Wire_2_Len);

   end String_To_Vector;

   Input_Split_1 : GNAT.String_Split.Slice_Set;
   Input_Split_2 : GNAT.String_Split.Slice_Set;

begin

   loop
      declare
         Line_1 : constant String := Ada.Text_IO.Get_Line;
         Line_2 : constant String := Ada.Text_IO.Get_Line;
      begin
         GNAT.String_Split.Create(From       => Line_1,
                                  Separators => ",",
                                  S          => Input_Split_1);
         GNAT.String_Split.Create(From       => Line_2,
                                  Separators => ",",
                                  S          => Input_Split_2);
         
         String_To_Vector(Input_Split_1, Input_Split_2);

         exit when Ada.Text_IO.End_Of_File;
      end;
   end loop;
  null;
end Day3;
