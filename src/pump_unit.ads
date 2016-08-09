with Ada.Strings.Unbounded;
with pump; use Pump;
with fuel_types; use fuel_types;
with reservoir; use reservoir; use Ada.Strings.Unbounded;

package Pump_Unit with SPARK_Mode => on is

   -- States the Pump unit can be in
   type State is  (
                  BASE_STATE,
                  READY_STATE,
                  PUMPING_STATE,
                  WAITING_STATE
                  );

   -- Holds the values of the pump unit
   type Pump_Unit_Type is private;

   -- Array of pumps the pump unit holds
   type Pumps_Array is array (1..3) of Pump_Type;

   -- The reservoirs the pump unit can use for the pump types
   type Reservoir_Array is array (1..3) of Reservoir_Type;

    -- Creates an instance of the pump unit
   function Create(Pumps : in Pumps_Array; Res : Reservoir_Array)return Pump_Unit_Type;

   -- Returns if the unit can start pumping
   function Can_Pump(A_Pump_Unit : in Pump_Unit_Type; Amount : in Fuel_Litre) return Boolean;

   -- Lift a nozzle
   procedure Lift_Nozzle(A_Pump_Unit : in out Pump_Unit_Type; F_Type : in Fuel_Type); -- not sure if pump or fuel type

   -- Returns the nozzle to the cradle
   procedure Return_Nozzle(A_Pump_Unit : in out Pump_Unit_Type); -- not sure if pump or fuel type

   -- Pumps fuel
   procedure Pump_Fuel(A_Pump_Unit : in out Pump_Unit_Type; Amount : in Fuel_Litre);

   -- Check all the nozzles are down
   function Check_Nozzle_Down(A_pump_unit : in Pump_Unit_Type)return Boolean;

   -- Pay the outstanding amount
   procedure Pay_Outstanding(A_Pump_Unit : in out Pump_Unit_Type);

private
   type Pump_Unit_Type is
      record
         Cur_State : State;
         Pumps : Pumps_Array;
         Reservoirs : Reservoir_Array;
         Pumping : Boolean;
         Outstanding : Boolean;
         Outstanding_Cost : Dollars;
      end record;

end Pump_Unit;
