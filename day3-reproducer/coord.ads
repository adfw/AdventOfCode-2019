with Ada.Containers.Formal_Vectors;

package Coord
   with SPARK_Mode => On
is

   -- Using Natural with Bounded_Vectors produces a compile time warning,
   -- not so with Formal_Vectors.
   subtype Coord_Index is Natural range 0 .. 20_000;

   package Points is new Ada.Containers.Formal_Vectors
     (Element_Type => Natural,
      Index_Type   => Coord_Index);

end Coord;
