with Command;
with Ada.Text_Io; use Ada.Text_Io;
package body Command_List is

      procedure Print_All is
      begin
          Put_Line("Command 1");
      end Print_All;

      procedure Run(com_to_run : in Integer) is
      begin
         if com_to_run = 1 then
            com_1.Run;
         end if;

      end Run;

end Command_List;
