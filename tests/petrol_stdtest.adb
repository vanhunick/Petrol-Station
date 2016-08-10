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

   -- Makes sure the user cannot pump at it's initial state
   procedure Test_Pump_Initial(CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
      Condition1 : Boolean;
   begin

      Condition1 := Can_Pump(Pump_Unit_Main, 100.00);

      Assert (Condition => (Condition1 = False),
              Message => "Should not be able to pump in base state");
   end Test_Pump_Initial;


    -- Makes sure the user cannot pump at it's initial state
   procedure Test_Pump_Valid_Lift_Nozzle(CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
      condition1 : Boolean;
   begin

         -- Lift a nozzle
      Pump_Unit.lift_Nozzle(Pump_Unit_Main, F91);
      condition1 := Pump_Unit.can_pump(Pump_Unit_Main, 500.00);

      --Pump_Unit.Pump(Pump_Unit_Main, 500.00);

      Assert (Condition => (condition1 = True),
              Message => "Should not be able to pump in base state");
   end Test_Pump_Valid_Lift_Nozzle;

   --==========================================================
   --               STATE TESTS
   --==========================================================

   -- Makes sure It is in the ready state after the users lifts nozzle
   procedure Test_State_Lift_Nozzle(CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
      condition1 : Boolean;
   begin
         -- Lift a nozzle
      Pump_Unit.lift_Nozzle(Pump_Unit_Main, F91);
      condition1 := Pump_Unit.can_pump(Pump_Unit_Main, 500.00);


      Assert (Condition => (Pump_Unit.Get_State(Pump_Unit_Main) = READY_STATE),
              Message => "Should be in ready state after lifting nozzle");
   end Test_State_Lift_Nozzle;


          -- Makes sure the user cannot pump at it's initial state
   procedure Test_State_Drop_Nozzle_Ready(CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
      condition1 : Boolean;
   begin
         -- Lift a nozzle
      Pump_Unit.lift_Nozzle(Pump_Unit_Main, F91);
      condition1 := Pump_Unit.can_pump(Pump_Unit_Main, 500.00);
      Pump_Unit.Return_Nozzle(Pump_Unit_Main);


      Assert (Condition => (Pump_Unit.Get_State(Pump_Unit_Main) = BASE_STATE),
              Message => "Should be in ready state after lifting nozzle");
   end Test_State_Drop_Nozzle_Ready;

   -- Makes sure the user cannot pump at it's initial state
   procedure Test_State_Drop_Nozzle_Waiting(CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
      condition1 : Boolean;
   begin
         -- Lift a nozzle
      Pump_Unit.lift_Nozzle(Pump_Unit_Main, F91);
      condition1 := Pump_Unit.can_pump(Pump_Unit_Main, 100.00);
      Pump_Unit.Pump_Fuel(Pump_Unit_Main, 100.00);
      Pump_Unit.Return_Nozzle(Pump_Unit_Main);

      Assert (Condition => (Pump_Unit.Get_State(Pump_Unit_Main) = WAITING_STATE),
              Message => "Should be in waiting state after dropping nozzle and pumping");
   end Test_State_Drop_Nozzle_Waiting;

   -- Makes sure the pump is in the base state after pumping and paying
   procedure Test_State_Drop_Nozzle_Base_After_Pay(CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
      condition1 : Boolean;
   begin
         -- Lift a nozzle
      Pump_Unit.lift_Nozzle(Pump_Unit_Main, F91);
      condition1 := Pump_Unit.can_pump(Pump_Unit_Main, 100.00);
      Pump_Unit.Pump_Fuel(Pump_Unit_Main, 100.00);
      Pump_Unit.Return_Nozzle(Pump_Unit_Main);
      Pump_Unit.Pay_Outstanding(Pump_Unit_Main);


      Assert (Condition => (Pump_Unit.Get_State(Pump_Unit_Main) = BASE_STATE),
              Message => "Should be in ready state after lifting nozzle");
   end Test_State_Drop_Nozzle_Base_After_Pay;


   -- Makes sure the pump is in the ready state after pumping and then lifting nozzle
   procedure Test_State_Pay_Pump_Again(CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
      condition1 : Boolean;
   begin

      -- Lift a nozzle
      Pump_Unit.lift_Nozzle(Pump_Unit_Main, F91);
      condition1 := Pump_Unit.can_pump(Pump_Unit_Main, 100.00);
      Pump_Unit.Pump_Fuel(Pump_Unit_Main, 100.00);
      Pump_Unit.Return_Nozzle(Pump_Unit_Main);
      Pump_Unit.lift_Nozzle(Pump_Unit_Main, F91);

      Assert (Condition => (Pump_Unit.Get_State(Pump_Unit_Main) = READY_STATE),
              Message => "Should be in ready state after lifting nozzle");
   end Test_State_Pay_Pump_Again;


   -- Makes sure the pump is in the ready state after pumping and then lifting nozzle
   procedure Test_State_Pay_Pump_Once(CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
      condition1 : Boolean;
   begin

      -- Lift a nozzle
      Pump_Unit.lift_Nozzle(Pump_Unit_Main, F91);
      condition1 := Pump_Unit.can_pump(Pump_Unit_Main, 100.00);
      Pump_Unit.Pump_Fuel(Pump_Unit_Main, 100.00);
      Pump_Unit.Return_Nozzle(Pump_Unit_Main);
      Pump_Unit.lift_Nozzle(Pump_Unit_Main, F91);
      Pump_Unit.Return_Nozzle(Pump_Unit_Main);

      Put_Line("Even Getting here");

      Assert (Condition => (Pump_Unit.Get_State(Pump_Unit_Main) = WAITING_STATE),
              Message => "Should be waiting state after not pumping second time");
   end Test_State_Pay_Pump_Once;

   --==========================================================
   --               Reservoir Tests
   --==========================================================

   -- Test correct fuel reduction in reservoir
   procedure Test_Empty_Reservoir(CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
      condition1 : Boolean;
   begin

      Pump_Unit.lift_Nozzle(Pump_Unit_Main, F91);
      Pump_Unit.Pump_Fuel(Pump_Unit_Main, 1000.00);
      Pump_Unit.Return_Nozzle(Pump_Unit_Main);
      Pump_Unit.lift_Nozzle(Pump_Unit_Main, F91);

      -- Should not have any fuel in it anymore
      condition1 := Pump_Unit.can_pump(Pump_Unit_Main, 1.00);

      Assert (Condition => (condition1 = False),
              Message => "Should be waiting state after not pumping second time");
   end Test_Empty_Reservoir;

   -- Test Empty one res and pump from another
   procedure Test_Empty_Reservoir_Pump_Another(CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
      condition1 : Boolean;
   begin

      Pump_Unit.lift_Nozzle(Pump_Unit_Main, F91);
      Pump_Unit.Pump_Fuel(Pump_Unit_Main, 1000.00);
      Pump_Unit.Return_Nozzle(Pump_Unit_Main);
      Pump_Unit.lift_Nozzle(Pump_Unit_Main, F95);

      -- Should not have any fuel in it anymore
      condition1 := Pump_Unit.can_pump(Pump_Unit_Main, 100.00);

      Assert (Condition => (condition1 = True),
              Message => "There should be fuel left in the other fuel type");
   end Test_Empty_Reservoir_Pump_Another;



   procedure Test_Fill_Reservoir_Pump_After(CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
      condition1 : Boolean;
   begin

      Pump_Unit.lift_Nozzle(Pump_Unit_Main, F91);
      Pump_Unit.Pump_Fuel(Pump_Unit_Main, 1000.00);

      Pump_Unit.Return_Nozzle(Pump_Unit_Main);
      Pump_Unit.lift_Nozzle(Pump_Unit_Main, F95);

      -- Should not have any fuel in it anymore
      condition1 := Pump_Unit.can_pump(Pump_Unit_Main, 100.00);

      Assert (Condition => (condition1 = True),
              Message => "There should be fuel left in the other fuel type");
   end Test_Fill_Reservoir_Pump_After;

   procedure Test_Check_Nozzle_Down(CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
      condition1 : Boolean;
   begin

      condition1 := Pump_Unit.Check_Nozzle_Down(Pump_Unit_Main);

      Assert (Condition => (condition1 = True),
              Message => "All Nozzles should be down initially");
   end Test_Check_Nozzle_Down;

   -- Checks the nozzle is up after it is pulled up
   procedure Test_Check_Nozzle_Up(CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
      condition1 : Boolean;
   begin

      Pump_Unit.lift_Nozzle(Pump_Unit_Main, F91);
      condition1 := Pump_Unit.Check_Nozzle_Down(Pump_Unit_Main);

      Assert (Condition => (condition1 = False),
              Message => "Nozzle should be up after lifting");
   end Test_Check_Nozzle_Up;



   --
   -- Create empty res and check if empty
   procedure Test_Create_Empty_Reservoir(CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
      res : Reservoir_Type;
   begin

      -- Create empty res
      res := Reservoir.Create(F91, 0.00, 1.00);

      Assert (Condition => (Get_Fuel_Left(res) = 0.00),
              Message => "Reservoir should be empty");
   end Test_Create_Empty_Reservoir;

   -- Add some fuel to empty res
   procedure Test_Add_To_Reservoir(CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
      res : Reservoir_Type;
   begin

      -- Create empty res
      res := Reservoir.Create(F91, 0.00, 1.00);
      Reservoir.Add_Fuel(res, 100.00);

      Assert (Condition => (Get_Fuel_Left(res) = 100.00),
              Message => "Should have 100.00 of fuel");
   end Test_Add_To_Reservoir;


   -- Lift nozzle when already lifted
   procedure Lift_Nozzle_When_Lifted(CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
      condition1 : Boolean;
   begin
      Pump_Unit.lift_Nozzle(Pump_Unit_Main, F95);
      Pump_Unit.lift_Nozzle(Pump_Unit_Main, F91); -- Find a way to check
      condition1 := Pump_Unit.Check_Nozzle_Down(Pump_Unit_Main);

      Assert (Condition => (condition1 = False),
              Message => "Nozzle should not lift more than once");
   end Lift_Nozzle_When_Lifted;




   -- Test pumping when not in correct state
   procedure Test_Pump_Not_In_Ready_State(CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
   begin

      Pump_Unit.Pump_Fuel(Pump_Unit_Main, 1000.00);

      Assert (Condition => (Get_State(Pump_Unit_Main) = BASE_STATE),
              Message => "Should not be able to pump in base state");
   end Test_Pump_Not_In_Ready_State;

   -- Test paying when not in waiting state
   procedure Test_Pay_Not_In_Waiting_State(CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
   begin

      Pump_Unit.lift_Nozzle(Pump_Unit_Main, F91);
      Pump_Unit.Pump_Fuel(Pump_Unit_Main, 1000.00);
      Pump_Unit.lift_Nozzle(Pump_Unit_Main, F95);

      Pump_Unit.Pay_Outstanding(Pump_Unit_Main);

      Assert (Condition => (Get_State(Pump_Unit_Main) = READY_STATE),
              Message => "Should not change state base state");
   end Test_Pay_Not_In_Waiting_State;

   -- Test paying when not in waiting state
   procedure Test_Pay_Not_Outstanding(CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
   begin

      Pump_Unit.Pay_Outstanding(Pump_Unit_Main); -- Need to test it does nothing

      Assert (Condition => (Get_State(Pump_Unit_Main) = BASE_STATE),
              Message => "Should not change state base state");
   end Test_Pay_Not_Outstanding;



   --==========================================================
   --               REGISTRATION/NAMING
   --==========================================================

   procedure Register_Tests (T: in out TC) is
      use AUnit.Test_Cases.Registration;
   begin
      Register_Routine (Test => T,Routine => Test_Pump_Initial'Access, Name => "Test_Pump_Initial");

      Register_Routine (Test => T,Routine => Test_Pump_Valid_Lift_Nozzle'Access,Name => "Test_Pump_Valid_Lift_Nozzle");

      Register_Routine (Test => T,Routine => Test_State_Lift_Nozzle'Access,Name => "Test_State_Lift_Nozzle");

      Register_Routine (Test => T,Routine => Test_State_Drop_Nozzle_Ready'Access,Name => "Test_State_Drop_Nozzle_Ready");

      Register_Routine (Test => T,Routine => Test_State_Drop_Nozzle_Waiting'Access,Name => "Test_State_Drop_Nozzle_Waiting");

      Register_Routine (Test => T,Routine => Test_State_Drop_Nozzle_Base_After_Pay'Access,Name => "Test_State_Drop_Nozzle_Base_After_Pay");

      Register_Routine (Test => T,Routine => Test_State_Pay_Pump_Again'Access,Name => "Test_State_Pay_Pump_Again");

      Register_Routine (Test => T,Routine => Test_State_Pay_Pump_Once'Access,Name => "Test_State_Pay_Pump_Once");

      Register_Routine (Test => T,Routine => Test_Empty_Reservoir'Access,Name => "Test_Empty_Reservoir");

      Register_Routine (Test => T,Routine => Test_Empty_Reservoir_Pump_Another'Access,Name => "Test_Empty_Reservoir_Pump_Another");

      Register_Routine (Test => T,Routine => Test_Fill_Reservoir_Pump_After'Access,Name => "Test_Fill_Reservoir_Pump_After");

      Register_Routine (Test => T,Routine => Test_Check_Nozzle_Down'Access,Name => "Test_Check_Nozzle_Down");

      Register_Routine (Test => T,Routine => Test_Check_Nozzle_Up'Access,Name => "Test_Check_Nozzle_Up");

      Register_Routine (Test => T,Routine => Test_Create_Empty_Reservoir'Access,Name => "Test_Create_Empty_Reservoir");

      Register_Routine (Test => T,Routine => Test_Add_To_Reservoir'Access,Name => "Test_Add_To_Reservoir");

      Register_Routine (Test => T,Routine => Lift_Nozzle_When_Lifted'Access,Name => "Lift_Nozzle_When_Lifted");

      Register_Routine (Test => T,Routine => Test_Pump_Not_In_Ready_State'Access,Name => "Test_Pump_Not_In_Ready_State");

      Register_Routine (Test => T,Routine => Test_Pay_Not_In_Waiting_State'Access,Name => "Test_Pay_Not_In_Waiting_State");

      Register_Routine (Test => T,Routine => Test_Pay_Not_Outstanding'Access,Name => "Test_Pay_Not_Outstanding");

   end Register_Tests;

   function Name (T: TC) return AUnit.Message_String is
      pragma Unreferenced (T);
   begin
      return AUnit.Format ("Tests: Standard Tests");
   end Name;

end petrol_stdtest;
