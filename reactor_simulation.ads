package Reactor_Simulation is

   REACTOR_TIME_STEP : constant := 0.5;

  protected type Fuel_Rod_Assembly (Initial_Particle_Count : Integer; Initial_Radical_Count : Integer) is
      procedure React;
      function Particles return Integer;
      function Radicals return Integer;
      procedure RemoveRadicals(amount : in Integer);
      function Output return Integer;

   private
      particle_count : Integer := Initial_Particle_Count;
      radical_neutron_count : Integer := Initial_Radical_Count;
      output_energy : Integer := 0; --in jouels, rounded

      --enviromental constants
      child_creation_rate : Float := 2.0;--number of radical neutrons that will be created from a reaction on average
      ramping_rate : Float := 0.55; --percentage of free radicals which will produce another reaction
      energy_per_reaction : Integer := 550;--jouels output per reaction

      temp_number_reactions : Integer;
   end Fuel_Rod_Assembly;

   protected type Control_Rod_Assembly(absorption_potential : Integer) is
      procedure Engage(percentage : Float);--0 to 1
      function Engagment return Float;
      function Absorption return Integer;

   private
      internal_engagment : Float := 0.0;
      maximum_absorption: Float := Float(absorption_potential);--particles per timestep
   end Control_Rod_Assembly;

end Reactor_Simulation;
