
package Reactor_Simulation is


   REACTOR_TIME_STEP : constant := 0.05;
   MAXIMUM_TEMPERATURE : constant := 2500.0;
   
   SALT_EMPTY_EXCEPTION : exception;
   SALT_OVERHEAT_EXCEPTION : exception;
   
  protected type Salt_Retainer(initial_level : Integer; initial_temperature : Integer) is
      procedure Flow(amount_to_flow : in Float; temperature_of_flow : Float; amount_flowing : in out Float);
      function CurrentTemperature return Float;
      procedure ChangeTemperature(amount_by : in Float);
      function EnergyCalc (heat : in Float) return Float;
      
  private
      salt_level : Float := Float(initial_level);
      temperature : Float := Float(initial_temperature);
      new_salt_level : Float;
      
      --using lithium flouride
      specific_heat_capacity : Float := 1604.0;
      
  end Salt_Retainer;

  protected type Fuel_Rod_Assembly (Initial_Particle_Count : Integer; Initial_Radical_Count : Integer) is
      procedure React;
      procedure SetParticles(set_to : in Integer);
      procedure SetRadicals(set_to : in Integer);
      function Particles return Integer;
      function Radicals return Integer;
      procedure RemoveRadicals(amount : in Integer);
      function Output return Float;

   private
      particle_count : Integer := Initial_Particle_Count;
      radical_neutron_count : Integer := Initial_Radical_Count;
      output_energy : Float := 0.0; --in jouels, rounded

      --enviromental constants
      child_creation_rate : Float := 1.0;--number of radical neutrons that will be created from a reaction on average
      ramping_rate : Float := 1.0; --percentage of free radicals which will produce another reaction
      energy_per_reaction : Integer := 550;--jouels output per reaction

      temp_number_reactions : Integer;
   end Fuel_Rod_Assembly;

   protected type Control_Rod_Assembly(absorption_potential : Integer) is
      procedure Engage(percentage : Float);--0 to 1
      procedure SetAbsorptionPotential (amount : Float);
      function Engagment return Float;
      function Absorption return Integer;

   private
      internal_engagment : Float := 0.0;
      maximum_absorption: Float := Float(absorption_potential);--particles per timestep
   end Control_Rod_Assembly;
   
   protected type Cooler(coolant_temp : Integer; transfer_coefficient : Integer) is
      procedure Cool(to_cool : in out Salt_Retainer);
      function EnergyCalc return Float;
      function OutputTemp return Float; 
      
   private
      input_temp : Float := Float(coolant_temp);
      output_temp : Float := Float(coolant_temp);
      heat_transfer_coefficient : Float := Float(transfer_coefficient)/100.0;
      temp_difference : Float;
   end Cooler;

   protected type Reactor_Housing is
      procedure Update;
      function Depletion return Float;
      procedure SetParticles (particles_tc : Integer);
      procedure SetRadicals (radicals_tc : Integer);
      procedure SetEngagment(percentage : in Float);
      procedure SetAbsorptionPotential(set_to : in Float);
      
      function FlowRate return Float;
      procedure SetFlowRate(set_to : Float);
      
      function ReservoirTemperature return Float;
      function ReactorTemperature return Float;
      function CoolerTemperature return Float;

   private      
      the_core : Fuel_Rod_Assembly(0, 0);
      the_control : Control_Rod_Assembly(10);
      the_cooler : Cooler(298, 53);
      initial_fuel : Integer;
      
      flow_rate : Float := 5.0; --driven by user
      flowing_salt : Float := 0.0;
      reactor_salt : Salt_Retainer(300, 300);
      cooler_salt : Salt_Retainer(300, 300);
      reservoir_salt : Salt_Retainer(300, 300);

   end Reactor_Housing;

end Reactor_Simulation;
