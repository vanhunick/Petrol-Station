with Pump_Unit; use Pump_Unit;
with Pump; use Pump;
with reservoir; use reservoir;
with fuel_types; use fuel_types;
with Text_IO; use Text_IO;

procedure main is

   Pump_Unit_Main : Pump_Unit_Type;

   -- Fuel Pumps
   Pump_91 : Pump_Type;
   Pump_95 : Pump_Type;
   Pump_Diesel : Pump_Type;

   -- Reserviours
   Res_91 : Reservoir_Type;
   Res_95 : Reservoir_Type;
   Res_Diesel : Reservoir_Type;

   -- The array of reservoirs
   Res_Array : Reservoir_Array;

   -- The array of pumps
   pump_array : Pumps_Array;

   -- Temp
   test : Boolean;

   pumped : Boolean;

begin

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

   -- Check if the nozzles are down
   test := Pump_Unit.check_nozzle_down(Pump_Unit_Main);


   -- Lift a nozzle
   Pump_Unit.lift_Nozzle(Pump_Unit_Main, F91);

   -- Pump too much fuel
   test := Pump_Unit.can_pump(Pump_Unit_Main, 500.00);

   -- Check if the nozzles are down
   test := Pump_Unit.check_nozzle_down(Pump_Unit_Main);

   -- Return the nozzle
   Pump_Unit.return_Nozzle(Pump_Unit_Main);

   -- Check if you can pump
   test := Pump_Unit.can_pump(Pump_Unit_Main, 500.00);

   --

   Pump_Unit.pump_fuel(Pump_Unit_Main, 100.00, pumped);

   Put_Line(pumped'Image);

   Pump_Unit.lift_Nozzle(Pump_Unit_Main, F91);

   Pump_Unit.pump_fuel(Pump_Unit_Main, 100.00, pumped);

   Put_Line(pumped'Image);

   null;
end main;
