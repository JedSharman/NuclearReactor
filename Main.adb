with Protected_Shared_Value; use Protected_Shared_Value;
with Ada.Text_IO; use Ada.Text_IO;
with Reactor_Simulation; use Reactor_Simulation;

procedure Main is
   --sensors go here
   reaction_chamber_temperature : Shared_Integer(0);

   fuelt : Fuel_Rod_Assembly(100000, 100);
   cont : Control_Rod_Assembly(10);

   --tasks go here
   task Reaction_Chamber;

   task body Reaction_Chamber is
   begin
      cont.Engage(0.95);
      while(fuelt.Particles > 0) loop
         Put_Line(fuelt.Radicals'Img);
         fuelt.React;
         fuelt.RemoveRadicals(cont.Absorption);
         delay 0.05;
      end loop;
   end Reaction_Chamber;

begin

   null;

end Main;
