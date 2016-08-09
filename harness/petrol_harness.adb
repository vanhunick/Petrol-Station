with AUnit.Reporter.Text;
with AUnit.Run;
with petrol_Suite;
with petrol_Stdsuite;

procedure Petrol_Harness is

   procedure Runner is new AUnit.Run.Test_Runner (Math_Stdsuite.Suite);  -- change to Math_Suite for simple test

   Reporter : AUnit.Reporter.Text.Text_Reporter;

begin
   Runner (Reporter);
end Petrol_Harness;
