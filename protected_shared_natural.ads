package Protected_Shared_Natural is

   protected type Shared_Natural(Initial_Value : Natural) is

      procedure Read       (output : out Natural );
      procedure Write     (New_Value : in Natural);
      procedure Increment (By        : in Natural);
      function Reads      return Natural;

   private
      The_Data : Natural := Initial_Value;
      Times_Read : Natural := 0;
   end Shared_Natural;

end Protected_Shared_Natural;
