package Command is
   type CommandBase is tagged

      record
         name : String(1..10);
      end record;

   function GetName return String;

   type Command_1 is new CommandBase with
      record
         var : Integer;
         end record;
     procedure Run;

end Command;
