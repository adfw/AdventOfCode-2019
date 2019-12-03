with Ada.Text_IO;
with Ada.Strings.Fixed;
with GNAT.Array_Split;
with GNAT.String_Split;

procedure Day2 is
   
   type Opcode is
    (Add,
     Multiply,
     Halt,
     Error);

   function Int_To_Opcode (Int : Integer) return Opcode is
     (case Int is
        when 1 => Add,
        when 2 => Multiply,
        when 99 => Halt,
        when others => Error);

   procedure Split_To_Array (Split : GNAT.String_Split.Slice_Set)
   is
      -- Create type to hold the program. Slice_Count needs - 1 because
      -- we start from position 0, but slice_count starts from 1.
      type Program_T is array 
         (Natural range 0 .. Natural
            (GNAT.String_Split.Slice_Count (Split)) - 1) of Integer;

      Program : Program_T;

      Program_Counter : Natural := 0;
      Current_Opcode : Opcode;
   begin
      for I in Program'Range loop
         -- Slice_Number 0 is the input string (i.e. everything), so skip it.
         Program (I) := Natural'Value
            (GNAT.String_Split.Slice 
               (Split, GNAT.String_Split.Slice_Number(I + 1)));
      end loop;

      -- So we now have Program, which contains our... program?
      -- Let's try to run it.
      Current_Opcode := Int_To_Opcode (Program(Program_Counter));
      Ada.Text_IO.Put_Line(Current_Opcode'Image);
      

   end Split_To_Array;

   Input_Split : GNAT.String_Split.Slice_Set;

begin

   loop
      declare
         Line : String := Ada.Text_IO.Get_Line;
      begin
         GNAT.String_Split.Create(From       => Line,
                                  Separators => ",",
                                  S          => Input_Split);
         
         Ada.Text_IO.Put_Line(GNAT.String_Split.Slice_Count(Input_Split)'Image);
         Split_To_Array(Input_Split);

         exit when Ada.Text_IO.End_Of_File;
      end;
   end loop;

end Day2;
