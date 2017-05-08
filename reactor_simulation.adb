package body Reactor_Simulation is

   protected body Fuel_Rod_Assembly is

      procedure React is
      begin
         if particle_count > 0 then


            temp_number_reactions := Integer(ramping_rate * Float(radical_neutron_count));

            particle_count := particle_count - temp_number_reactions;--remove reacted material

            radical_neutron_count := Integer(Float(temp_number_reactions) * child_creation_rate);

            output_energy := Float(temp_number_reactions * energy_per_reaction);

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

      function Output return Float is
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
   
   protected body Cooler is
      
      procedure Cool(to_cool : in out Salt_Retainer) is
      begin
            temp_difference := ((to_cool.CurrentTemperature - input_temp)/2.0)*heat_transfer_coefficient;
            to_cool.ChangeTemperature( -temp_difference);
            output_temp := input_temp + temp_difference;
      end Cool;
         
      function OutputTemp return Float is
      begin         
            return output_temp;
      end OutputTemp;
         
   end Cooler;
   
    protected body Salt_Retainer is
      
      procedure Flow( amount_to_flow : in Float; temperature_of_flow : Float; amount_flowing : in out Float) is
      begin         
         new_salt_level := amount_flowing + salt_level;
         
         --Tavg = (Ta*Ma + Tb*Mb)/(Ma+Mb)
         temperature := (temperature * salt_level + temperature_of_flow * amount_flowing)/(new_salt_level);   
           
         salt_level := new_salt_level;
         
         if salt_level >= amount_to_flow then
            salt_level := salt_level - amount_to_flow;
            amount_flowing := amount_to_flow;
            
         else
            raise SALT_EMPTY_EXCEPTION;
         end if;
      end Flow;
      
      function CurrentTemperature return Float is
      begin
       
         return temperature;
        
      end CurrentTemperature;
      
      procedure ChangeTemperature(amount_by : in Float) is
      begin
         temperature := temperature + amount_by;
      end ChangeTemperature;
      
   end Salt_Retainer;

    protected body Reactor_Housing is
    
      procedure Update is
      begin
         the_core.React;
         the_core.RemoveRadicals(the_control.Absorption);
         
         reactor_salt.ChangeTemperature(the_core.Output);
         
         the_cooler.Cool(cooler_salt);
         
         --reactor -> cooler -> resivoir -> reactor         
         reactor_salt.Flow(flow_rate, reservoir_salt.CurrentTemperature, flowing_salt);
         cooler_salt.Flow(flow_rate, reactor_salt.CurrentTemperature, flowing_salt);
         reservoir_salt.Flow(flow_rate, cooler_salt.CurrentTemperature, flowing_salt);
         
          
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
      
      function FlowRate return Float is
      begin
         return flow_rate;
      end FlowRate;
      
      procedure SetFlowRate(set_to : Float) is
      begin
         flow_rate := set_to;
      end SetFlowRate;
      
      function ReservoirTemperature return Float is
      begin
         return reservoir_salt.CurrentTemperature;
      end ReservoirTemperature;
      
      function ReactorTemperature return Float is
      begin
         return reactor_salt.CurrentTemperature;
      end ReactorTemperature;
      
      function CoolerTemperature return Float is
      begin
         return cooler_salt.CurrentTemperature;
      end CoolerTemperature;
      

   end Reactor_Housing;

end Reactor_Simulation;
