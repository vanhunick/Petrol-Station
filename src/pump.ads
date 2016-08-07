with Ada.Strings.Unbounded;
with reservoir;
with fuel_types;
use fuel_types;
with reservoir;
use Ada.Strings.Unbounded;

package Pump with SPARK_Mode => on is

   type Pump_Type is private;

   procedure pump(A_Pump : in out Pump_Type);

   function can_pump(a_pump : in Pump_Type) return Boolean;

   function Create(fuel : in Fuel_Type )return Pump_Type;

   function nozzle_lifted(Pump : in Pump_Type)return Boolean;



private
   type Pump_Type is
      record
         Pumping : Boolean;
         Nozzle_Lifted : Boolean;
      end record;
end pump;
