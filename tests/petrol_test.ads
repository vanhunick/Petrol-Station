with AUnit; use AUnit;
with AUnit.Simple_Test_Cases;

package Petrol_test is

   type TC is new AUnit.Simple_Test_Cases.Test_Case with record
      I1, I2, I3 : Int;
   end record;

   overriding procedure Set_Up (T: in out TC);
   overriding procedure Tear_Down (T: in out TC);

   procedure Run_Test (T: in out TC);
   function Name (T: TC) return Message_String;

end Petrol_Test;
