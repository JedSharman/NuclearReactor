package Reactor_Simulation is

   REACTOR_TIME_STEP : constant := 0.05;

  protected type Fuel_Rod_Assembly (Initial_Particle_Count : Integer; Initial_Radical_Count : Integer) is
      procedure React;
      procedure SetParticles(set_to : in Integer);
      procedure SetRadicals(set_to : in Integer);
      function Particles return Integer;
      function Radicals return Integer;
      procedure RemoveRadicals(amount : in Integer);
      function Output return Integer;

   private
      particle_count : Integer := Initial_Particle_Count;
      radical_neutron_count : Integer := Initial_Radical_Count;
      output_energy : Integer := 0; --in jouels, rounded

      --enviromental constants
      child_creation_rate : Float := 1.5;--number of radical neutrons that will be created from a reaction on average
      ramping_rate : Float := 0.9; --percentage of free radicals which will produce another reaction
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

   protected type Coolant_Housing is
      
      procedure Cool(Heat : Float);
      
   private
   	  
	  Salt_Reactor  : Float;
	  Reactor_Temp  : Float;
	  
	  Coolant_Volume  : Float;
   	  Coolant_Temp  : Float;
	  
	  Salt_Reservoir: Float;
	  Reservoir_Temp: Float;
	  
	  Flow_Rate     : Float;
	  
	  Water_Temp    : Float;
	  
	  
   end Coolant_Housing;

   protected type Reactor_Housing is
      procedure Update;
      function Depletion return Float;
      procedure SetParticles (particles_tc : Integer);
      procedure SetRadicals (radicals_tc : Integer);
      procedure SetEngagment(percentage : in Float);
      procedure SetAbsorptionPotential(set_to : in Float);

   private
      the_core : Fuel_Rod_Assembly(0, 0);
      the_control : Control_Rod_Assembly(10);
      cooling  : Coolant_Housing;
      initial_fuel : Integer;

   end Reactor_Housing;


end Reactor_Simulation;
