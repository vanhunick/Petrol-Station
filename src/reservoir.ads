with fuel_types; use fuel_types;

package Reservoir with SPARK_Mode => on is

   -- Cost of the fuel type
   type Dollars is delta 0.01 digits 12;

   -- The type that stores the reservoirs data
   type Reservoir_Type is private;

   -- The quanity of fuel type
   type Fuel_Litre is digits 10 range 0.00 .. 10000000.00;

   -- Creates and returns a reservoir
   function Create(f_type : in Fuel_Type; amount : in Fuel_Litre; cost_fuel : in Dollars)return reservoir_type with
     post => Get_Fuel_Type(Create'Result) = f_type and then
     Get_Fuel_Left(Create'Result) = amount and then
     Get_Cost(Create'Result) = cost_fuel;

   -- Add fuel to the reservoir
   procedure Add_Fuel(Res : in out Reservoir_Type; amount : in Fuel_Litre) with
     Pre => Amount > 0.00,
     Post => Get_Fuel_Left(Res'old) + Amount = Get_Fuel_Left(res);

   -- Removes fuel from the reservoir
   procedure Remove_Fuel(Res : in out Reservoir_Type; Amount : in Fuel_Litre) with
     Pre => Amount > 0.00,
     Post => Get_Fuel_Left(Res'old) = (Get_Fuel_Left(res) + Amount);

   -- Returns the fuel type the reservoir holds
   function Get_Fuel_Type(Res : in Reservoir_Type)return Fuel_Type;-- with
   --Post => Get_Fuel_Type'Result = Reservoir_Type.Fuel =  ; // Check it is equal to return type

   -- Gets the cost of the fuel in the reservoir
   function Get_Cost(Res : in Reservoir_Type)return Dollars with
   Post =>  Get_Cost'Result > 0.00; -- Should not have 0 as the cost

   -- Returns the amount of fuel left in the reservoir
   function Get_Fuel_Left(Res : in Reservoir_Type)return Fuel_Litre with
     Post => Get_Fuel_Left'Result >= 0.00;
   -- Could check that the returned result is equal to the amount in the record but it would require a ghost function which would be identical to the get function anyway


private
   type Reservoir_Type is
      record
         Empty : Boolean;
         Fuel : Fuel_Type;
         Amout_Fuel : Fuel_Litre;
         Cost : Dollars;
      end record;

end Reservoir;
