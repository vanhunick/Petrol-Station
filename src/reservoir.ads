with Ada.Strings.Unbounded;
with fuel_types;
use fuel_types;
use Ada.Strings.Unbounded;


package reservoir with SPARK_Mode => on is

   -- The type that stores the reservoirs data
   type reservoir_type is private;

   --
   type Fuel_Litre is digits 10 range 0.00 .. 10000000.00;

   procedure set_empty(res : in out reservoir_type);

   function Create(f_type : in Fuel_Type; amount : in Fuel_Litre)return reservoir_type;

   procedure add_fuel(res : in out reservoir_type; amount : in Fuel_Litre);

private
   type reservoir_type is
      record
         empty : Boolean;
         fuel : Fuel_Type;
         amout_fuel : Fuel_Litre;
      end record;

end reservoir;
