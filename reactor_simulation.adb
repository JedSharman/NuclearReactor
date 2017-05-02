package body Reactor_Simulation is

   protected body Fuel_Rod_Assembly is

      procedure React is
      begin
         if particle_count > 0 then


            temp_number_reactions := Integer(ramping_rate * Float(radical_neutron_count));

            particle_count := particle_count - temp_number_reactions;--remove reacted material

            radical_neutron_count := Integer(Float(temp_number_reactions) * child_creation_rate);

            output_energy := temp_number_reactions * energy_per_reaction;

            if(particle_count <= 0) then
               particle_count := 0;
            end if;

         else

            radical_neutron_count := 0;

         end if;

      end React;

      procedure SetParticles(set_to : in Integer) is
      begin
         particle_count := set_to;
      end SetParticles;

      procedure SetRadicals(set_to : in Integer) is
      begin
         radical_neutron_count := set_to;
      end SetRadicals;

      function Particles return Integer is
      begin
         return particle_count;
      end Particles;

      function Radicals return Integer is
      begin
         return radical_neutron_count;
      end Radicals;

      procedure RemoveRadicals(amount : in Integer) is
      begin
         radical_neutron_count := radical_neutron_count - amount;

         if radical_neutron_count < 0 then
            radical_neutron_count := 0;
         end if;
      end RemoveRadicals;

      function Output return Integer is
      begin
         return output_energy;
      end Output;

   end Fuel_Rod_Assembly;

   protected body Control_Rod_Assembly is

      procedure Engage(percentage : Float) is
         temp_percentage : Float;
      begin
         temp_percentage := percentage;

         if(temp_percentage > 1.0) then
            temp_percentage := 1.0;
         end if;

         if(temp_percentage < 0.0) then
            temp_percentage := 0.0;
         end if;

         internal_engagment := temp_percentage;
      end Engage;

      procedure SetAbsorptionPotential (amount : Float) is
      begin
         maximum_absorption := amount;
      end SetAbsorptionPotential;

     function Engagment return Float is
      begin
         return internal_engagment;
      end Engagment;

      function Absorption return Integer is
      begin
         return Integer(internal_engagment*maximum_absorption);
      end Absorption;

   end Control_Rod_Assembly;

    protected body Reactor_Housing is
    
	  Salt_Heated   : Float;
	  Salt_Reactor  : Float;
	  Salt_Reservoir: Float;
      procedure Update is
      begin
          the_core.React;
          the_core.RemoveRadicals(the_control.Absorption);
      end Update;

      function Depletion return Float is
      begin
           return Float(the_core.Particles)*100.0/Float(initial_fuel);
      end Depletion;

      procedure SetParticles (particles_tc : Integer) is
      begin
         the_core.SetParticles(particles_tc);
         initial_fuel := particles_tc;
      end SetParticles;

      procedure SetRadicals (radicals_tc : Integer) is
      begin
         the_core.SetRadicals(radicals_tc);
      end SetRadicals;

      procedure SetEngagment(percentage : in Float) is
      begin
         the_control.Engage(percentage);
      end SetEngagment;

      procedure SetAbsorptionPotential(set_to : in Float) is
      begin
         the_control.SetAbsorptionPotential(set_to);
      end SetAbsorptionPotential;

   end Reactor_Housing;

end Reactor_Simulation;
