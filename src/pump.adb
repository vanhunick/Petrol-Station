with Ada.Strings.Unbounded;
use Ada.Strings.Unbounded;

package body pump is

   function Create(fuel : in Fuel_Type )return Pump_Type is
      pump : Pump_Type;
   begin
      pump.Pumping := False;
      Pump.Nozzle_Lifted := false;
      pump.fuel_t := fuel;
      return Pump;
   end Create;

   -- Returns if the nozzle is lifted
   function nozzle_lifted(Pump : in Pump_Type)return Boolean is
   begin
      return Pump.Nozzle_Lifted;
   end nozzle_lifted;

   -- lifts the nozzle
   procedure Lift_Nozzle(pump : in out Pump_Type) is
   begin
      pump.Nozzle_Lifted := True;
   end Lift_Nozzle;

   -- returns the nozzle
   procedure Return_Nozzle(pump : in out Pump_Type) is
   begin
      Pump.Nozzle_Lifted := False;
   end Return_Nozzle;

   function get_fuel_Type(pump : in Pump_Type)return Fuel_Type is
   begin
      return Pump.fuel_t;
   end get_fuel_Type;

end pump;
