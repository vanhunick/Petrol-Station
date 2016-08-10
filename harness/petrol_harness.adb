with AUnit.Reporter.Text;
with AUnit.Run;
with petrol_suite;
with petrol_Stdsuite;

procedure Petrol_Harness is

   procedure Runner is new AUnit.Run.Test_Runner (Petrol_Stdsuite.Suite);  -- change to Math_Suite for simple test

   Reporter : AUnit.Reporter.Text.Text_Reporter;

begin
   Runner (Reporter);
end Petrol_Harness;
