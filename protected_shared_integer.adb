package body Protected_Shared_Integer is

   protected body Shared_Integer is

      procedure Read (output : out Integer) is

      begin
         output := The_Data;
      end Read;

      procedure Write (New_Value : in Integer) is

      begin
         The_Data := New_Value;
      end Write;

      procedure Increment (By : in Integer) is

      begin
         The_Data := The_Data + By;
      end Increment;


   end Shared_Integer;

end Protected_Shared_Integer;
