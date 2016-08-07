with Ada.Strings.Unbounded;
with pump; use Pump;
with fuel_types; use fuel_types;
with reservoir; use reservoir; use Ada.Strings.Unbounded;


package Pump_Unit with SPARK_Mode => on is

      -- Holds the values of the pump unit
   type Pump_Unit_Type is private;

   -- Array of pumps the pump unit holds
   type pumps_array is array (1..3) of Pump_Type;

   -- The reservoirs the pump unit can use for the pump types
   type reservoir_array is array (1..3) of reservoir_type;

   -- States the Pump unit can be in
   type state is  (
                  BASE_STATE,
                  Ready_STATE,
                  PUMPING_STATE,
                  WAITING_STATE
                  );

      -- Init
   function create(pumps : in pumps_array; res : reservoir_array)return Pump_Unit_Type;

   function can_pump(A_Pump_Unit : in Pump_Unit_Type; Amount : in Fuel_Litre) return Boolean;

   -- Lift a nozzle
   procedure lift_Nozzle(A_Pump_Unit : in Pump_Unit_Type; ftype : in Fuel_Type); -- not sure if pump or fuel type

   -- Returns the nozzle to the cradle
   procedure return_Nozzle(A_Pump_Unit : in Pump_Unit_Type); -- not sure if pump or fuel type

   -- Pumps fuel
   procedure pump(A_Pump_Unit : in Pump_Unit_Type; Amount : in Fuel_Litre);

   -- Check all the nozzles are down
   function check_nozzle_down(A_pump_unit : in Pump_Unit_Type)return Boolean;

   -- Pay





private
   type Pump_Unit_Type is
      record
         cur_state : state;
         pumps : pumps_array;
         reservoirs : reservoir_array;
         pumping : Boolean;
         paying : Boolean;
      end record;

end pump_unit;
