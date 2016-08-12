with fuel_types; use fuel_types;

package Pump with SPARK_Mode => on is

   -- Type that holds the pump data
   type Pump_Type is private;

   -- Creates an instance of the pump type and returns it
   function Create(Fuel : in Fuel_Type )return Pump_Type with
     Post => Get_Fuel_Type(Create'Result) = Fuel; -- Checks the correct fuel type assigned

   -- Returns if the nozzle is lifted
   function Nozzle_Lifted(Pump : in Pump_Type)return Boolean;

   -- lifts the nozzle
   procedure Lift_Nozzle(Pump : in out Pump_Type) with
   Pre => Nozzle_Lifted(Pump) = False,
   Post => Nozzle_Lifted(Pump) = True;

   -- returns the nozzle
   procedure Return_Nozzle(Pump : in out Pump_Type) with
   Pre => Nozzle_Lifted(Pump) = True,
   Post => Nozzle_Lifted(Pump) = False;

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
