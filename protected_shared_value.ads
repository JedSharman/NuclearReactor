package Protected_Shared_Value is

   protected type Shared_Integer(Initial_Value : Integer) is

      function Read        return Integer;
      procedure Write     (New_Value : in Integer);
      procedure Increment (By        : in Integer);

   private
      The_Data : Integer := Initial_Value;
   end Shared_Integer;

   protected type Shared_Real(Initial_Value : Real) is

      function Read       return Real;
      procedure Write     (New_Value : in Real);
      procedure Increment (By        : in Real);

   private
      The_Data : Real := Initial_Value;
   end Shared_Real;

end Protected_Shared_Value;
