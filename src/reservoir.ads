with Ada.Strings.Unbounded;
with fuel_types;
use fuel_types;
use Ada.Strings.Unbounded;


package reservoir with SPARK_Mode => on is

   type reservoir_type is private;
   type Fuel_Litre is digits 10 range 0.00 .. 10000000.00;

   procedure set_empty(res : in out reservoir_type);

private
   type reservoir_type is
      record
         empty : Boolean;
         fuel : Fuel_Type;
         amout_fuel : Fuel_Litre;
      end record;

end reservoir;
