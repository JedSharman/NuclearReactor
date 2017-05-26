with Command;
with User_Interface;
package Command_List is
      procedure Print_All;
      procedure Run(com_to_run : in Integer);

   private
        com_1 : Command.Command_1;

end Command_List;
