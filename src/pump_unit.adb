with Ada.Strings.Unbounded;
use Ada.Strings.Unbounded;

package body pump_unit is

   procedure add(A_Pump : in out Pump; Amount : Integer) is
      begin
      A_Pump.fuel := A_Pump.fuel + Amount;
      end add;


   function create(name : in Unbounded_String) return Pump is
      New_Pump : Pump;
   begin
      New_Pump.name := name;
      New_Pump.name := name;
      New_Pump.fuel := 0;

      return New_Pump;
   end create;

   function Get_Name(A_Pump : in Pump) return String is
   begin
      return Ada.Strings.Unbounded.To_String(A_Pump.name);
   end Get_Name;


end pump_unit;
