with Ada.Strings.Unbounded;
with pump; use Pump;
with reservoir; use reservoir; use Ada.Strings.Unbounded;


package Pump_Unit with SPARK_Mode => on is

   type state is (
                  BASE_STATE,
                  Ready_STATE,
                  PUMPING_STATE,
                  WAITING_STATE
                 );

   -- Holds the values of the pump unit
   type Pump_Unit_Type is private;

   -- Array of pumps the pump unit holds
   type pumps_array is array (1..4) of Pump_Type;

   -- The reservoirs the pump unit can use for the pump types
   type reservoir_array is array (1..4) of reservoir_type;

   procedure pump(A_Pump_Unit : in Pump_Unit_Type; Amount : in Fuel_Litre);

   function can_pump(A_Pump_Unit : in Pump_Unit_Type; Amount : in Fuel_Litre) return Boolean;


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
