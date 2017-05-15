package User_Interface is

   type User is (Jed, Jordan, Liam, Sudo);
   type Password is array (User) of Integer;
   pw : constant Password := (10, 10, 10, 10);


   procedure Initialise;
   function AuthoriseUser return Boolean ;

   end User_Interface;
