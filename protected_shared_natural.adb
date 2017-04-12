package body Protected_Shared_Natural is

   protected body Shared_Natural is

      procedure Read (output : out Natural) is

      begin
         output := The_Data;
         Times_Read := Times_Read + 1;
      end Read;

      procedure Write (New_Value : in Natural) is

      begin
         The_Data := New_Value;
      end Write;

      procedure Increment (By : in Natural) is

      begin
         The_Data := The_Data + By;
      end Increment;

      function Reads return Natural is
      begin

         return Times_Read;


      end Reads;



   end Shared_Natural;

end Protected_Shared_Natural;
