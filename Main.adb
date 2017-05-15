with Protected_Shared_Value; use Protected_Shared_Value;
with User_Interface; use User_Interface;
with Ada.Text_IO; use Ada.Text_IO;
with Reactor_Simulation; use Reactor_Simulation;

procedure Main is
   --sensors go here
   reaction_chamber_temperature : Shared_Integer(0);

   fuelt : aliased Fuel_Rod_Assembly(2000000000, 100);
   --cont : Control_Rod_Assembly(10);
   cham : Reactor_Housing;

   --tasks go here
   task Reaction_Chamber;

   task body Reaction_Chamber is
      temp_i : Integer;
   begin
      Initialise;
      if AuthoriseUser = True then
      --cont.Engage(0.0);
      cham.SetParticles(1000);
      cham.SetRadicals(1);

      cham.SetAbsorptionPotential(50.0);
      cham.SetEngagment(0.0);

      while(cham.Depletion > 0.0) loop
         temp_i := Integer(cham.Depletion);
         --Put_Line(temp_i'Img & "%");
         Put(Integer(cham.ReservoirTemperature)'Img & "; ");
         Put(Integer(cham.ReactorTemperature)'Img & "; ");
         Put(Integer(cham.CoolerTemperature)'Img & "; ");
         New_Line;

         cham.Update;

         if temp_i <= 90 then
            cham.SetEngagment(1.0);
         end if;

         delay REACTOR_TIME_STEP;
         end loop;
         end if;
   end Reaction_Chamber;

begin
   null;

end Main;
