with Protected_Shared_Value; use Protected_Shared_Value;
with User_Interface; use User_Interface;
with Ada.Text_IO; use Ada.Text_IO;
with Reactor_Simulation; use Reactor_Simulation;
with Ada.Integer_Text_Io; use Ada.Integer_Text_IO;

procedure Main is
   --sensors go here
   reaction_chamber_temperature : Shared_Integer(0);

   --shared variables
   del : constant := 0.2;
   disp : Integer := 0;

   the_core : Fuel_Rod_Assembly(1000000, 0);--max 2000000000
   the_control : Control_Rod_Assembly(100);
   the_cooler : Cooler(298, 53);
   --initial_fuel : Integer;

   flow_rate : Float := 5.0; --driven by user
   flowing_salt : Float := 0.0;
   reactor_salt : Salt_Retainer(300, 300);
   cooler_salt : Salt_Retainer(300, 300);
   reservoir_salt : Salt_Retainer(300, 300);

   --tasks go here
   task Reaction_Chamber;

   task Core;
   task Control;
   task Cooler;
   task Flow;

   task body Core is
      d : constant := del;
   begin

      while(the_core.Particles > 0) loop
         the_core.React;
         delay(d);
      end loop;

   end Core;

   task body Control is
      d : constant := del;
   begin

      while(the_core.Particles > 0) loop
         the_core.RemoveRadicals(the_control.Absorption);

         delay(d);
      end loop;

   end Control;

   task body Cooler is
      d : constant := del;
   begin

      while(the_core.Particles > 0) loop
         the_cooler.Cool(cooler_salt);

         delay(d);
      end loop;

   end Cooler;

   task body Flow is
      d : constant := del;
   begin

      while(the_core.Particles > 0) loop
         reactor_salt.ChangeTemperature(the_core.Output);

         --reactor -> cooler -> resivoir -> reactor
         reactor_salt.Flow(flow_rate, reservoir_salt.CurrentTemperature, flowing_salt);
         cooler_salt.Flow(flow_rate, reactor_salt.CurrentTemperature, flowing_salt);
         reservoir_salt.Flow(flow_rate, cooler_salt.CurrentTemperature, flowing_salt);

         delay(d);
      end loop;

   end Flow;

   task body Reaction_Chamber is
      i : Integer;
   begin
         Initialise;

      if AuthoriseUser = True then

         the_control.Engage(1.0);

         while(the_core.Particles > 0) loop
            Put("What would you like to do:");

            Ada.Integer_Text_IO.Get(disp); Skip_Line;

            if disp = 0 then
               i := 0;
               while (i < 20) loop
                  Put_Line((the_core.Particles'Img & "," & the_core.Radicals'Img));
                  i := i + 1;
                  delay 0.2;
               end loop;
            elsif disp = 1 then
               the_core.SetRadicals(the_core.Radicals + 500);
            elsif disp = 2 then
               the_control.Engage(the_control.Engagment + 0.1);
            elsif disp = 3 then
               the_control.Engage(the_control.Engagment - 0.1);
            elsif disp = 4 then
               Put_Line("Engaged: " & the_control.Engagment'Img);
            else

               Put("Temperature: Reactor<");
               Put(reactor_salt.CurrentTemperature'Img);
               Put("> Cooler<");
               Put(cooler_salt.CurrentTemperature'Img);
               Put(">  Resivoir<");
               Put(reservoir_salt.CurrentTemperature'Img);
               Put(">");
               New_Line;
            end if;

               delay REACTOR_TIME_STEP;
            end loop;
            end if;
   end Reaction_Chamber;

begin
   null;

end Main;
