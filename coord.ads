with Ada.Containers.Formal_Vectors;

package Coord
   with SPARK_Mode => On
is
   type Coord is record
      X         : Integer;
      Y         : Integer;
   end record;

   Start_Coord : constant Coord := (0,0);

   type Direction_T is (U, D, L, R, Error);

   subtype Valid_Direction is Direction_T range U .. R;

  -- function Char_To_Direction (Input : Character) return Direction_T is
  --    (case Input is
  --       when 'U' => Up,
  --       when 'D' => Down,
  --       when 'L' => Left,
  --       when 'R' => Right,
  --       when others => Error);

   type Vector is record
      Direction : Valid_Direction;
      Size      : Natural;
   end record;
   
   package Coord_Points is new Ada.Containers.Formal_Vectors
     (Element_Type => Coord,
      Index_Type   => Natural);

   function Dir_To_Point 
      (Dir : Valid_Direction;
       Pos : Coord)
    return Coord;

   procedure Expand_Vec (Vec  : in     Vector;
                         Wire : in out Coord_Points.Vector;
                         Pos  : in out Coord);

end Coord;
