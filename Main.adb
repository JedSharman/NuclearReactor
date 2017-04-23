with Protected_Shared_Value; use Protected_Shared_Value;
with Ada.Text_IO; use Ada.Text_IO;

procedure Main is
   --sensors go here
   reaction_chamber_temperature : Shared_Integer(0);


   --tasks go here
   task Reaction_Chamber;

   task body Reaction_Chamber is
   begin
      while (true) loop
         --Put_Line("New Line");
         delay 1.0;
      end loop;
   end Reaction_Chamber;

   --Objects go here
   protected type Fuel_Rod_Assembly (Initial_Mass : Integer) is
      procedure React(percentage : Integer);

   private
      mass : Shared_Integer(Initial_Mass);
   end Fuel_Rod_Assembly;


   protected body Fuel_Rod_Assembly is

      procedure React(percentage : Integer)is
      begin
         Put_Line(percentage'Img);
      end React;


   end Fuel_Rod_Assembly;



begin

   null;

end Main;
