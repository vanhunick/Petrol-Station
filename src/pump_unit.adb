with Ada.Text_IO; use Ada.Text_IO;
with Pump; use Pump;

package body pump_unit is


   -- Creates and returns a pump unit
   function Create(Pumps : in Pumps_Array; Res : Reservoir_Array)return Pump_Unit_Type is
      New_Pump_Unit : Pump_Unit_Type;
   begin
      New_Pump_Unit.Cur_State := BASE_STATE;  -- Initialise it in the base state
      New_Pump_Unit.Pumps := Pumps;           -- Set the pumps array
      New_Pump_Unit.Reservoirs := Res;        -- Set the reservoir array
      New_Pump_Unit.Pumping := False;         -- Set pumping to false it is in base state
      New_Pump_Unit.Outstanding := False;     -- Set paying to false it is in base state
      New_Pump_Unit.Outstanding_Cost := 0.00; -- Set the amount to 0.00 at the start
      return New_Pump_Unit;                   -- Return the pump unit
   end Create;

   -- Returns if all of the nozzles in the pump unit are down
   function Check_Nozzle_Down(A_pump_unit : in Pump_Unit_Type)return Boolean is
   begin
      for I in 1..A_Pump_Unit.Pumps'Length loop
         if  Pump.Nozzle_Lifted(A_Pump_Unit.Pumps(I)) = True then
            Put_Line("Nozzle not down");
            return False;
         end if;
      end loop;
      Put_Line("Nozzle is down");
      return True;
   end check_nozzle_down;

   -- Returns if we are able to pump right now given the amount of fuel
   function Can_Pump(A_Pump_Unit : in Pump_Unit_Type; Amount : in Fuel_Litre) return Boolean is
   begin
      if not (A_Pump_Unit.Cur_State = READY_STATE) then
         Put_Line("Can't pump incorrect state");
         return False;-- TODO might need to check some more condition like
      end if;


      for I in 1..A_pump_Unit.Pumps'Length loop
         if Pump.Nozzle_lifted(A_pump_Unit.Pumps(I)) then
               for J in 1..A_pump_Unit.Reservoirs'Length loop
                  if Reservoir.Get_Fuel_Type(A_pump_unit.Reservoirs(J)) = (Pump.Get_Fuel_Type(A_pump_Unit.Pumps(I))) then
                     if Reservoir.get_fuel_Left(A_pump_unit.reservoirs(J)) < Amount then -- check if there is enough in the res
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
         return False;
   end can_pump;

   -- Lift a nozzle
   procedure Lift_Nozzle(A_Pump_Unit : in out Pump_Unit_Type; F_Type : in Fuel_Type) is
   begin
      -- First check we are in the correct state
      if not (A_Pump_Unit.Cur_State = BASE_STATE) and then not (A_Pump_Unit.Cur_State = WAITING_STATE) then  -- Just picked up the nozzle currently no charge
         Put_Line("Cannot lift nozzle incorrect state");
        return;
      end if;

      -- We are in the current state to life a nozzle
      for I in 1..A_pump_Unit.Pumps'Length loop
         if not Pump.Nozzle_Lifted(A_pump_Unit.Pumps(I)) and then Pump.Get_Fuel_Type(A_pump_Unit.Pumps(I)) = F_Type then
            Pump.Lift_Nozzle(A_pump_unit.Pumps(I));
            Put_Line("Lifting Nozzle");
         end if;
      end loop;

      -- Change state to ready state
      A_Pump_Unit.Cur_State := READY_STATE;
      Put_Line("Changed to ready state");
   end Lift_Nozzle;


   -- Returns the nozzle to the cradle
   procedure Return_Nozzle(A_Pump_Unit : in out Pump_Unit_Type) is
   begin

      -- Return the nozzle to the cradle
      for I in 1..A_pump_unit.Pumps'Length loop
         if Pump.Nozzle_Lifted(A_Pump_Unit.Pumps(I)) then
            Pump.Return_Nozzle(A_pump_unit.Pumps(I));
            Put_Line("Returned Nozzle");
         end if;
      end loop;

      -- Change the state
      if A_Pump_Unit.Outstanding then
         A_Pump_Unit.Cur_State := WAITING_STATE;
         Put_Line("Changed to Waiting state");
      else
         A_Pump_Unit.Cur_State := BASE_STATE;
         Put_Line("Changed to Base state");
      end if;

   end Return_Nozzle;


   -- Pumps fuel
   procedure Pump_Fuel(A_Pump_Unit : in out Pump_Unit_Type; Amount : in Fuel_Litre) is
   begin
      -- First check we are in the correct state
      if not ( A_Pump_Unit.Cur_State = READY_STATE) then
         Put_Line("Cannot pump, inccorect state");
         return;
      end if;

      if Can_Pump(A_Pump_Unit, Amount) then
         -- Find the res

               -- Return the nozzle to the cradle
      for I in 1..A_Pump_Unit.Pumps'Length loop
         if Pump.Nozzle_Lifted(A_pump_Unit.Pumps(I)) then
               for J in 1..A_Pump_Unit.Reservoirs'Length loop
                  if Reservoir.Get_Fuel_Type(A_pump_unit.Reservoirs(J)) = (Pump.Get_Fuel_Type(A_Pump_Unit.Pumps(I))) then
                     -- Take fuel out of res
                     Reservoir.Remove_Fuel(A_Pump_Unit.Reservoirs(J), Amount);
                     A_Pump_Unit.Outstanding_Cost := Dollars (Float(A_Pump_Unit.Outstanding_Cost) + Float(Amount) * Float(reservoir.get_cost(A_Pump_Unit.Reservoirs(J))));
                     Put_Line("Fuel Pumped and cost updated");

                     -- Set the state to waiting
                     A_Pump_Unit.Outstanding := True;
                     A_Pump_Unit.Cur_State := WAITING_STATE;
                     return;
                  end if;
               end loop;
            end if;
      end loop;
      end if;
   end Pump_Fuel;

   -- Pays the outstanding amount and returns to base state
   procedure Pay_Outstanding(A_Pump_Unit : in out Pump_Unit_Type) is
   begin
      if not (A_Pump_Unit.Cur_State = WAITING_STATE) then
         Put_Line("Not in waiting state for payment, can't pay in this state");
         return;
      end if;

      if not (A_Pump_Unit.Outstanding) then
         Put_Line("Not waiting for payment, can't pay");
         return;
      end if;

      -- Clear the outstanding payment
      A_Pump_Unit.Outstanding := False;
      A_Pump_Unit.Outstanding_Cost := 0.00;

      -- The payment has been made return state back to base state
      A_Pump_Unit.Cur_State := BASE_STATE;
      Put_Line("Payment made, back to base state");
   end Pay_Outstanding;

   function Get_State(A_Pump_Unit : in Pump_Unit_Type)return State is (A_Pump_Unit.Cur_State);

end pump_unit;
