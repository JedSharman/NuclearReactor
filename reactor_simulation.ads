with Protected_Shared_Integer; use Protected_Shared_Integer;

package Reactor_Simulation is

   protected type Simulation is
      procedure Set(value : Integer);

   private
      --nothing : Integer := 0;
   end Simulation;

end Reactor_Simulation;
