with AUnit.Test_Suites; use AUnit.Test_Suites;
--with petrol_Test;

function Petrol_Suite return Access_Test_Suite is

   TS_Ptr : constant Access_Test_Suite := new Test_Suite;

begin

   --TS_Ptr.Add_Test (new Petrol_Test.TC);

   return TS_Ptr;

end Petrol_Suite;
