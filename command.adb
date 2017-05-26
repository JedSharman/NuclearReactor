with Ada.Text_Io; use Ada.Text_Io;
package body Command is

   protected body Command_1 is
      procedure Run is
      begin
         Put_Line("Command 1 is Runnning");
      end run;

   end Command_1;

end Command;
