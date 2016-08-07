with Ada.Strings.Unbounded;
use Ada.Strings.Unbounded;
with Pump;
package body pump_unit is


   -- Creates and returns a pump unit
   function create(pumps : in pumps_array; res : reservoir_array)return Pump_Unit_Type is
      New_Pump_Unit : Pump_Unit_Type;
   begin
      New_Pump_Unit.cur_state := BASE_STATE; -- Initialise it in the base state
      New_Pump_Unit.pumps := pumps; -- Set the pumps array
      New_Pump_Unit.reservoirs := res; -- Set the reservoir array
      New_Pump_Unit.pumping := False; -- Set pumping to false it is in base state
      New_Pump_Unit.paying := False; -- Set paying to false it is in base state

      return New_Pump_Unit;
   end create;


   function check_nozzle_down(A_pump_unit : in Pump_Unit_Type)return Boolean is
   begin
      for I in 1..A_pump_unit.pumps'Length loop
         if  pump.nozzle_lifted(pumps(I)) then
            return False;
         end if;
      end loop;
         return True;
   end check_nozzle_down;


   function can_pump(A_Pump_Unit : in Pump_Unit_Type; Amount : in Fuel_Litre) return Boolean is
   begin
      return true;
   end can_pump;


   -- Lift a nozzle
   procedure lift_Nozzle(A_Pump_Unit : in Pump_Unit_Type; ftype : in Fuel_Type) is
   begin
      null;
   end lift_Nozzle;


   -- Returns the nozzle to the cradle
   procedure return_Nozzle(A_Pump_Unit : in Pump_Unit_Type) is
   begin
      null;
   end return_Nozzle;


   -- Pumps fuel
   procedure pump(A_Pump_Unit : in Pump_Unit_Type; Amount : in Fuel_Litre) is
   begin
      null;
   end pump;





end pump_unit;
