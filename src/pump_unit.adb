with Ada.Text_IO; use Ada.Text_IO;
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
      New_Pump_Unit.outstanding_Cost := 0.00; -- Set the amount to 0.00 at the start

      return New_Pump_Unit;
   end create;


   function check_nozzle_down(A_pump_unit : in Pump_Unit_Type)return Boolean is
   begin
      for I in 1..A_pump_unit.pumps'Length loop
         if  Pump.nozzle_lifted(A_pump_unit.pumps(I)) = True then
            Put_Line("Nozzle not down");
            return False;
         end if;
      end loop;
      Put_Line("Nozzle is down");
      return True;
   end check_nozzle_down;


   function can_pump(A_Pump_Unit : in Pump_Unit_Type; Amount : in Fuel_Litre) return Boolean is
   begin
      if not (A_Pump_Unit.cur_state = READY_STATE) then
         Put_Line("Can't pump incorrect state");
         return False;-- TODO might need to check some more condition like
      end if;


      for I in 1..A_pump_unit.pumps'Length loop
         if pump.nozzle_lifted(A_pump_unit.pumps(I)) then
               for J in 1..A_pump_unit.reservoirs'Length loop
                  if Reservoir.Get_Fuel_Type(A_pump_unit.reservoirs(J)) = (pump.get_fuel_Type(A_pump_unit.pumps(I))) then
                     -- Take fuel out of res

                     if Reservoir.get_fuel_Left(A_pump_unit.reservoirs(J)) < Amount then
                        Put_Line("Can't pump, not enough fuel in the reservoir");
                        return False;
                     else
                        Put_Line("Can pump");
                        return True;
                     end if;
                  end if;
               end loop;
            end if;
         end loop; -- Check if the res has enough fuel in it
         Put_Line("Can't pump Something horrible has occoured should not get here");
         return False;

   end can_pump;




   -- Lift a nozzle
   procedure lift_Nozzle(A_Pump_Unit : in out Pump_Unit_Type; ftype : in Fuel_Type) is
   begin
            -- First check we are in the correct state
      if not (A_Pump_Unit.cur_state = BASE_STATE) and then not (A_Pump_Unit.cur_state = WAITING_STATE) then  -- Just picked up the nozzle currently no charge
         Put_Line("Cannot lift nozzle incorrect state");
        return;
      end if;

      -- We are in the current state to life a nozzle
      for I in 1..A_pump_unit.pumps'Length loop
         if not pump.nozzle_lifted(A_pump_unit.pumps(I)) and then pump.get_fuel_Type(A_pump_unit.pumps(I)) = ftype then
            pump.Lift_Nozzle(A_pump_unit.pumps(I));
            Put_Line("Lifting Nozzle");
         end if;
      end loop;

      -- Change state to ready state
      A_Pump_Unit.cur_state := READY_STATE;
      Put_Line("Changed to ready state");
   end lift_Nozzle;


   -- Returns the nozzle to the cradle
   procedure return_Nozzle(A_Pump_Unit : in out Pump_Unit_Type) is
   begin

      -- Return the nozzle to the cradle
      for I in 1..A_pump_unit.pumps'Length loop
         if pump.nozzle_lifted(A_pump_unit.pumps(I)) then
            pump.Return_Nozzle(A_pump_unit.pumps(I));
            Put_Line("Returned Nozzle");
         end if;
      end loop;

      -- Change the state
      if A_Pump_Unit.outstanding then
         A_Pump_Unit.cur_state := WAITING_STATE;
         Put_Line("Changed to Waiting state");
      else
         A_Pump_Unit.cur_state := BASE_STATE;
         Put_Line("Changed to Base state");
      end if;

   end return_Nozzle;


   -- Pumps fuel
   procedure pump_fuel(A_Pump_Unit : in out Pump_Unit_Type; Amount : in Fuel_Litre) is
   begin
      -- First check we are in the correct state
      if not ( A_Pump_Unit.cur_state = READY_STATE) then
         Put_Line("Cannot pump, inccorect state");
         return;
      end if;

      if can_pump(A_Pump_Unit, Amount) then
         -- Find the res

               -- Return the nozzle to the cradle
      for I in 1..A_pump_unit.pumps'Length loop
         if pump.nozzle_lifted(A_pump_unit.pumps(I)) then
               for J in 1..A_pump_unit.reservoirs'Length loop
                  if Reservoir.Get_Fuel_Type(A_pump_unit.reservoirs(J)) = (pump.get_fuel_Type(A_pump_unit.pumps(I))) then
                     -- Take fuel out of res
                     Reservoir.remove_fuel(A_pump_unit.reservoirs(J), Amount);
                     A_pump_unit.outstanding_Cost := Dollars (Float(A_pump_unit.outstanding_Cost) + Float(Amount) * Float(reservoir.get_cost(A_pump_unit.reservoirs(J))));
                     Put_Line("Fuel Pumped and cost updated");

                     -- Set the state to waiting
                     A_Pump_Unit.cur_state := WAITING_STATE;
                     return;
                  end if;
               end loop;
            end if;
      end loop;
      end if;
      Put_Line("Can't pump");

   end pump_fuel;

   -- Pays the outstanding amount and returns to base state
   procedure pay_outstanding(A_Pump_Unit : in out Pump_Unit_Type) is
   begin
      if not (A_Pump_Unit.cur_state = WAITING_STATE) then
         Put_Line("Not in waiting state for payment, can't pay in this state");
         return;
      end if;

      if not (A_Pump_Unit.outstanding) then
         Put_Line("Not waiting for payment, can't pay");
         return;
      end if;


      -- Clear the outstanding payment
      A_Pump_Unit.outstanding := False;
      A_Pump_Unit.outstanding_Cost := 0.00;

      -- The payment has been made return state back to base state
      A_Pump_Unit.cur_state := BASE_STATE;
      Put_Line("Payment made, back to base state");
   end pay_outstanding;

end pump_unit;
