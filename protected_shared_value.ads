package Protected_Shared_Value is

   protected type Shared_Integer(Initial_Value : Integer) is

      function Read        return Integer;
      procedure Write     (New_Value : in Integer);
      procedure Increment (By        : in Integer);

   private
      The_Data : Integer := Initial_Value;
   end Shared_Integer;

end Protected_Shared_Value;
