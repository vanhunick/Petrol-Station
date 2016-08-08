with Ada.Strings.Unbounded;
with reservoir;
with fuel_types;
use fuel_types;
with reservoir;
use Ada.Strings.Unbounded;

package Pump with SPARK_Mode => on is

   -- Type that holds the pump data
   type Pump_Type is private;

   -- Creates an instance of the pump type and returns it
   function Create(fuel : in Fuel_Type )return Pump_Type;

   -- Returns if the nozzle is lifted
   function nozzle_lifted(Pump : in Pump_Type)return Boolean;

   -- lifts the nozzle
   procedure Lift_Nozzle(pump : in out Pump_Type);

   -- returns the nozzle
   procedure Return_Nozzle(pump : in out Pump_Type);

   -- Returns the type of fuel the pump is on
   function get_fuel_Type(pump : in Pump_Type)return Fuel_Type;

private
   type Pump_Type is
      record
         Pumping : Boolean;
         Nozzle_Lifted : Boolean;
         fuel_t : Fuel_Type;
      end record;
end pump;
