with petrol_Stdtest;

package body Petrol_Stdsuite is

   use AUnit.Test_Suites;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is

      TS_Ptr : constant Access_Test_Suite := new Test_Suite;
   begin

      TS_Ptr.Add_Test (new Petrol_Stdtest.TC) ;

      return TS_Ptr;

   end Suite;

end Petrol_Stdsuite;
