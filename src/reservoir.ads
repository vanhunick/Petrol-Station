with fuel_types; use fuel_types;

package Reservoir with SPARK_Mode => on is

   -- Cost of the fuel type
   type Dollars is delta 0.01 digits 12;

   -- The type that stores the reservoirs data
   type Reservoir_Type is private;

   -- The quanity of fuel type
   type Fuel_Litre is digits 10 range 0.00 .. 10000000.00;

   -- Creates and returns a reservoir
   function Create(f_type : in Fuel_Type; amount : in Fuel_Litre; cost_fuel : in Dollars)return reservoir_type;

   -- Add fuel to the reservoir
   procedure Add_Fuel(Res : in out Reservoir_Type; amount : in Fuel_Litre);

   -- Removes fuel from the reservoir
   procedure Remove_Fuel(Res : in out Reservoir_Type; Amount : in Fuel_Litre);

   -- Returns the fuel type the reservoir holds
   function Get_Fuel_Type(Res : in Reservoir_Type)return Fuel_Type;

   -- Gets the cost of the fuel in the reservoir
   function Get_Cost(Res : in Reservoir_Type)return Dollars;

   -- Returns the amount of fuel left in the reservoir
   function Get_Fuel_Left(Res : in Reservoir_Type)return Fuel_Litre;

private
   type Reservoir_Type is
      record
         Empty : Boolean;
         Fuel : Fuel_Type;
         Amout_Fuel : Fuel_Litre;
         Cost : Dollars;
      end record;

end Reservoir;
