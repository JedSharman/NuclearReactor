with Ada.Text_Io; use Ada.Text_Io;
with Ada.Integer_Text_Io;
with Command_List;

package body User_Interface is
package Int_Io renames Ada.Integer_Text_Io;

   procedure Initialise is
	begin
		Put_Line("Nuclear Reactor Simulator");
		--Promt to accept inital senario
		Put_Line("What initial senario do you with to load?");
		-- TODO Accept input from user
	end Initialise;

   function AuthoriseUser return Boolean is
   temp_user, temp_pw : Integer;
   current_user : User;
   begin
      Put("Enter User ID: "); --Using Number for simplicity.
      Int_Io.Get(temp_user); Skip_Line;
      current_user := User'Enum_Val(temp_user);
      Put("Enter Password: ");
      Int_Io.Get(temp_pw); Skip_Line;
      if pw(current_user) = temp_pw then
         Put("Welcome ");
         Put_Line(current_user'Img);
         return True;
      else
         Put_Line("Invalid Login");
         return False;
      end if;
   end AuthoriseUser;

   procedure Output (text : in String; ln : in Boolean) is
   begin
      if ln = False then
         Put_Line(text);
      else
         Put(text);
      end if;
   end Output;

   procedure RunCommand is

      temp_id :Integer;
   begin
      Put_Line("The following Commands are available:");
      Command_List.Print_All;
      Put("Which to Run?");
      Int_Io.Get(temp_id); Skip_Line;
      Command_List.Run(temp_id);

      end RunCommand;

   end User_Interface;
