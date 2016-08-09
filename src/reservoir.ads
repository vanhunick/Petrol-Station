with Ada.Strings.Unbounded;
with fuel_types;
use fuel_types;
use Ada.Strings.Unbounded;


package reservoir with SPARK_Mode => on is

   -- Cost of the fuel type
   type Dollars is delta 0.01 digits 12;

   -- The type that stores the reservoirs data
   type reservoir_type is private;

   --
   type Fuel_Litre is digits 10 range 0.00 .. 10000000.00; -- Might need to be larger

   procedure set_empty(res : in out reservoir_type);

   function Create(f_type : in Fuel_Type; amount : in Fuel_Litre; cost_fuel : in Dollars)return reservoir_type;

   procedure add_fuel(res : in out reservoir_type; amount : in Fuel_Litre);

   procedure remove_fuel(res : in out reservoir_type; amount : in Fuel_Litre);

   function Get_Fuel_Type(res : in reservoir_type)return Fuel_Type;

   function get_cost(res : in reservoir_type)return Dollars;

   function get_fuel_Left(res : in reservoir_type)return Fuel_Litre;

private
   type reservoir_type is
      record
         empty : Boolean;
         fuel : Fuel_Type;
         amout_fuel : Fuel_Litre;
         cost : Dollars;
      end record;

end reservoir;
