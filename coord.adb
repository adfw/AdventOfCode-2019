package body Coord is

   function Dir_To_Point 
      (Dir : Valid_Direction;
       Pos : Coord)
    return Coord
   is
   begin
      case Dir is
         when U => 
            return Coord'
               (X => Pos.X + 1,
                Y => Pos.Y);
         when D => 
            return Coord'
               (X => Pos.X - 1,
                Y => Pos.Y);
         when L => 
            return Coord'
               (X => Pos.X,
                Y => Pos.Y - 1);
         when R => 
            return Coord'
               (X => Pos.X,
                Y => Pos.Y + 1);
               end case;
   end Dir_To_Point;

   procedure Expand_Vec (Vec  : in     Vector;
                         Wire : in out Coord_Points.Vector;
                         Pos  : in out Coord)
   is
   begin
      for I in Positive range 1 .. Vec.Size loop
         Pos := Dir_To_Point(Vec.Direction, Pos);
         Coord_Points.Append(Wire, Pos);
      end loop;
   end Expand_Vec;

end Coord;
