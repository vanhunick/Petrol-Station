with Ada.Text_IO; use Ada.Text_IO;
with AUnit.Assertions; use AUnit.Assertions;

package body Petrol_Test is

   procedure Set_Up (T : in out TC) is
   begin
      New_Line;
      Put_Line("Set Up ..");
      T.I1 := 5;
      T.I2 := 7;
      T.I3 := 2;
   end;

   procedure Tear_Down (T : in out TC) is
   begin
      Put_Line("Tear Down ...");
      T.I1 := 0;
      T.I2 := 0;
      T.I3 := 0;
   end;

   procedure Run_Test (T : in out TC) is
      Expected: constant Int := 0;
      Expected2: constant Int := 10;
   begin
      Put_Line ("Running Test");

      Assert (Condition => (T.I1 - T.I2 + T.I3 = Expected),
              Message => "Incorrect result after adding and subtracting");
      Assert (Condition => (T.I1 + T.I2 - T.I3 = Expected2),
              Message => "Incorrect result after adding and subtracting");
   end Run_Test;

   function Name (T: TC) return Message_String is
      pragma Unreferenced (T);
   begin
      return AUnit.Format ("Test-case name: Math.Test");
   end Name;

end petrol_Test;
