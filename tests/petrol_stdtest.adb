with Ada.Text_IO; use Ada.Text_IO;
with AUnit.Assertions; use AUnit.Assertions;
with Pump_Unit; use Pump_Unit;
with Pump; use Pump;
with Reservoir; use Reservoir;
with fuel_types; use fuel_types;

package body petrol_stdtest is



   Pump_Unit_Main : Pump_Unit_Type;

   -- Fuel Pumps
   Pump_91,Pump_95,Pump_Diesel : Pump_Type;

   -- Reserviours
   Res_91,Res_95,Res_Diesel : Reservoir_Type;

   -- The array of reservoirs
   Res_Array : Reservoir_Array;

   -- The array of pumps
   pump_array : Pumps_Array;

   -- Temp
   test : Boolean;

   procedure Set_Up_Case (T: in out TC) is
      pragma Unreferenced (T);
   begin
      New_Line;
      Put_Line ("Set up case ..");
         -- Init the pumps and reserviors
   Pump_91 := Pump.create(F91);
   Pump_95 := Pump.create(F95);
   Pump_Diesel := Pump.create(Diesel);

   -- Init the reserviors
   Res_91 := Reservoir.Create(F91, 1000.00, 1.00);
   Res_95 := Reservoir.Create(F95, 1000.00, 1.50);
   Res_Diesel :=Reservoir.Create(Diesel, 1000.00, 2.00);

   -- Set the pump array
   pump_array(1) := Pump_91;
   pump_array(2) := Pump_95;
   pump_array(3) := Pump_Diesel;

   -- set the res array
   res_array(1) := Res_91;
   res_array(2) := Res_95;
   res_array(3) := Res_Diesel;

   -- Create the unit
   Pump_Unit_Main := Pump_Unit.create(pump_array,res_array);

   end Set_Up_Case;


   procedure Set_Up (T : in out TC) is
   begin
      New_Line;
      Put_Line("Set Up ..");
   end;

   -- After each
   procedure Tear_Down (T : in out TC) is
   begin
      Put_Line("Tear Down ...");
   end;

   -- After last
   procedure Tear_Down_Case (T : in out TC) is
   begin
      Put_Line ("Tear Down Case ..");

   end;


   -- ===========================================================
   --                 TEST CASES/SCENARIOS
   -- ===========================================================


   procedure Test_Pump_Initial(CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
   begin

      test := Can_Pump(Pump_Unit_Main, 100.00);

      Assert (Condition => (test = False),
              Message => "Should not be able to pump in base state");
   end Test_Pump_Initial;

   --==========================================================
   --               REGISTRATION/NAMING
   --==========================================================

   procedure Register_Tests (T: in out TC) is
      use AUnit.Test_Cases.Registration;
   begin
      Register_Routine (Test => T,
                        Routine => Test_Pump_Initial'Access,
                        Name => "Test_Pump_Initial");
   end Register_Tests;

   function Name (T: TC) return AUnit.Message_String is
      pragma Unreferenced (T);
   begin
      return AUnit.Format ("Tests: Standard Tests");
   end Name;

end petrol_stdtest;
