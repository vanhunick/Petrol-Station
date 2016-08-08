with Ada.Text_IO; use Ada.Text_IO;
with Pump_Unit;
use Pump_Unit;
with Pump;
use Pump;
with reservoir;
use reservoir;
with fuel_types;
with Pump_Unit;
use fuel_types;
with Ada.Strings.Unbounded;
use Ada.Strings.Unbounded;

procedure main is

   Pump_Unit_Main : Pump_Unit_Type;

   -- Fuel Pumps
   Pump_91 : Pump_Type;
   Pump_95 : Pump_Type;
   Pump_Diesel : Pump_Type;

   -- Reserviours
   Res_91 : reservoir_type;
   Res_95 : reservoir_type;
   Res_Diesel : reservoir_type;

   res_array : reservoir_array;
   pump_array : pumps_array;


begin

   -- Init the pumps and reserviors
   Pump_91 := Pump.create(F91);
   Pump_95 := Pump.create(F95);
   Pump_Diesel := Pump.create(Diesel);

   -- Init the reserviors
   Res_91 := Reservoir.Create(F91, 1000.00);
   Res_95 := Reservoir.Create(F95, 1000.00);
   Res_Diesel :=Reservoir.Create(Diesel, 1000.00);

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


   null;
end main;
