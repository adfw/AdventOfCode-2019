with Ada.Containers;
with Ada.Text_IO;
with GNAT.String_Split;

with Coord;

use type Ada.Containers.Count_Type;

procedure Day3
   with SPARK_Mode => On
is

   type Direction_T is (Up, Down, Left, Right, Error);

   subtype Valid_Direction is Direction_T range Up .. Right;

   function Char_To_Direction (Input : Character) return Direction_T is
      (case Input is
         when 'U' => Up,
         when 'D' => Down,
         when 'L' => Left,
         when 'R' => Right,
         when others => Error);

   procedure String_To_Vector
      (Input_Split_1 : GNAT.String_Split.Slice_Set;
       Input_Split_2 : GNAT.String_Split.Slice_Set)
   is
      Wire_1 : Coord.Coord_Points.Vector (Ada.Containers.Count_Type
            (GNAT.String_Split.Slice_Count (Input_Split_1)) - 1);
      Wire_2 : Coord.Coord_Points.Vector (Ada.Containers.Count_Type
            (GNAT.String_Split.Slice_Count (Input_Split_2)) - 1);
   begin
      -- TODO: Go through each item in the slice, and extrapolate all the
      --       'points' on the vector. Then, we can do Vector comparisons,
      --       but I can't be bothered doing anything fancy like min/max
      --       checking.
      null;
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
