package body Protected_Shared_Value is

   protected body Shared_Integer is

      function Read return Integer is

      begin
         return The_Data;
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

   protected body Shared_Real is

      function Read return Real is

      begin
         return The_Data;
      end Read;

      procedure Write (New_Value : in Real) is

      begin
         The_Data := New_Value;
      end Write;

      procedure Increment (By : in Real) is

      begin
         The_Data := The_Data + By;
      end Increment;


   end Shared_Real;

end Protected_Shared_Value;
