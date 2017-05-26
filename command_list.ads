with Command;
package Command_List is
   type node;
   type ptr is access node;
   type node is record
      item : Integer;
      next: ptr;
   end record;
   type command_ptr is access Command.CommandBase'class;


   type Commands is array (1..10) of command_ptr;

--protected type All_Commands is
   --procedure Print_All;

   --private
      --command_array : Commands;


      --end All_Commands;
end Command_List;
