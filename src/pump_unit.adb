with Ada.Strings.Unbounded;
use Ada.Strings.Unbounded;
with Pump;
use Pump;
package body pump_unit is


   -- Creates and returns a pump unit
   function create(pumps : in pumps_array; res : reservoir_array)return Pump_Unit_Type is
      New_Pump_Unit : Pump_Unit_Type;
   begin
      New_Pump_Unit.cur_state := BASE_STATE; -- Initialise it in the base state
      New_Pump_Unit.pumps := pumps; -- Set the pumps array
      New_Pump_Unit.reservoirs := res; -- Set the reservoir array
      New_Pump_Unit.pumping := False; -- Set pumping to false it is in base state
      New_Pump_Unit.outstanding := False; -- Set paying to false it is in base state

      return New_Pump_Unit;
   end create;


   function check_nozzle_down(A_pump_unit : in Pump_Unit_Type)return Boolean is
   begin
      for I in 1..A_pump_unit.pumps'Length loop
         if  Pump.nozzle_lifted(A_pump_unit.pumps(I)) = True then
            return False;
         end if;
      end loop;
         return True;
   end check_nozzle_down;


   function can_pump(A_Pump_Unit : in Pump_Unit_Type; Amount : in Fuel_Litre) return Boolean is
   begin
      if A_Pump_Unit.cur_state = READY_STATE and then -- TODO might need to check some more condition like

      -- Check if the res has enough fuel in it


         return true;
      else
         return False;
      end if;

   end can_pump;


   -- Lift a nozzle
   procedure lift_Nozzle(A_Pump_Unit : in out Pump_Unit_Type; ftype : in Fuel_Type) is
   begin
            -- First check we are in the correct state
      if not (A_Pump_Unit.cur_state = BASE_STATE) and then not (A_Pump_Unit.cur_state = WAITING_STATE) then  -- Just picked up the nozzle currently no charge
        return;
      end if;

      -- We are in the current state to life a nozzle
      for I in 1..A_pump_unit.pumps'Length loop
         if not pump.nozzle_lifted(A_pump_unit.pumps(I)) and then pump.get_fuel_Type(A_pump_unit.pumps(I)) = ftype then
            pump.Lift_Nozzle(A_pump_unit.pumps(I));
         end if;
      end loop;

      -- Change state to ready state
      A_Pump_Unit.cur_state := READY_STATE;

   end lift_Nozzle;


   -- Returns the nozzle to the cradle
   procedure return_Nozzle(A_Pump_Unit : in Pump_Unit_Type) is
   begin

      -- Return the nozzle to the cradle
      for I in 1..A_pump_unit.pumps'Length loop
         if pump.nozzle_lifted(A_pump_unit.pumps(I)) then
            pump.Return_Nozzle(A_pump_unit.pumps(I));
         end if;


      -- Change the state
      if A_Pump_Unit.outstanding then
         A_Pump_Unit.cur_state := WAITING_STATE;
      else
         A_Pump_Unit.cur_state := READY_STATE;
      end if;

   end return_Nozzle;


   -- Pumps fuel
   procedure pump_fuel(A_Pump_Unit : in Pump_Unit_Type; Amount : in Fuel_Litre) is
   begin
      -- First check we are in the correct state
      if not ( A_Pump_Unit.cur_state = READY_STATE) then
         return;
      end if;






   end pump_fuel;


end pump_unit;
