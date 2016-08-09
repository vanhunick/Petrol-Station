with Ada.Strings.Unbounded;
with pump; use Pump;
with fuel_types; use fuel_types;
with reservoir; use reservoir; use Ada.Strings.Unbounded;


package Pump_Unit with SPARK_Mode => on is

      -- States the Pump unit can be in
   type state is  (
                  BASE_STATE,
                  READY_STATE,
                  PUMPING_STATE,
                  WAITING_STATE
                  );

   -- Holds the values of the pump unit
   type Pump_Unit_Type is private;

   -- Array of pumps the pump unit holds
   type pumps_array is array (1..3) of Pump_Type;

   -- The reservoirs the pump unit can use for the pump types
   type reservoir_array is array (1..3) of reservoir_type;


    -- Creates an instance of the pump unit
   function create(pumps : in pumps_array; res : reservoir_array)return Pump_Unit_Type;

   -- Returns if the unit can start pumping
   function can_pump(A_Pump_Unit : in Pump_Unit_Type; Amount : in Fuel_Litre) return Boolean;

   -- Lift a nozzle
   procedure lift_Nozzle(A_Pump_Unit : in out Pump_Unit_Type; ftype : in Fuel_Type); -- not sure if pump or fuel type


   -- Returns the nozzle to the cradle
   procedure return_Nozzle(A_Pump_Unit : in out Pump_Unit_Type); -- not sure if pump or fuel type

   -- Pumps fuel
   procedure pump_fuel(A_Pump_Unit : in out Pump_Unit_Type; Amount : in Fuel_Litre);

   -- Check all the nozzles are down
   function check_nozzle_down(A_pump_unit : in Pump_Unit_Type)return Boolean;

   procedure pay_outstanding(A_Pump_Unit : in out Pump_Unit_Type); -- No need for amount

   -- Pay



private
   type Pump_Unit_Type is
      record
         cur_state : state;
         pumps : pumps_array;
         reservoirs : reservoir_array;
         pumping : Boolean;
         outstanding : Boolean;
         outstanding_Cost : Dollars;
      end record;

end pump_unit;
