with Ada.Containers.Formal_Vectors;

package Coord
   with SPARK_Mode => On
is
   type Coord is record
      X         : Integer;
      Y         : Integer;
   end record;
   
   package Coord_Points is new Ada.Containers.Formal_Vectors
     (Element_Type => Coord,
      Index_Type   => Natural);

end Coord;
