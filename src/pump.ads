with fuel_types; use fuel_types;

package Pump with SPARK_Mode => on is

   -- Type that holds the pump data
   type Pump_Type is private;

   -- Creates an instance of the pump type and returns it
   function Create(Fuel : in Fuel_Type )return Pump_Type;

   -- Returns if the nozzle is lifted
   function Nozzle_Lifted(Pump : in Pump_Type)return Boolean;

   -- lifts the nozzle
   procedure Lift_Nozzle(Pump : in out Pump_Type);

   -- returns the nozzle
   procedure Return_Nozzle(Pump : in out Pump_Type);

   -- Returns the type of fuel the pump is on
   function Get_Fuel_Type(Pump : in Pump_Type)return Fuel_Type;

private
   type Pump_Type is
      record
         Pumping : Boolean;
         Nozzle_Lifted : Boolean;
         Fuel_T : Fuel_Type;
      end record;
end Pump;
