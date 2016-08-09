package body pump is

   -- Creates and returns a Pump Type
   function Create(Fuel : in Fuel_Type )return Pump_Type is
      Pump : Pump_Type;
   begin
      Pump.Pumping := False;
      Pump.Nozzle_Lifted := False;
      Pump.Fuel_T := Fuel;
      return Pump;
   end Create;

   -- lifts the nozzle
   procedure Lift_Nozzle(Pump : in out Pump_Type) is
   begin
      Pump.Nozzle_Lifted := True;
   end Lift_Nozzle;

   -- returns the nozzle
   procedure Return_Nozzle(Pump : in out Pump_Type) is
   begin
      Pump.Nozzle_Lifted := False;
   end Return_Nozzle;

   -- Returns the fuel type of the pump
   function Get_Fuel_Type(Pump : in Pump_Type)return Fuel_Type is (Pump.Fuel_T);

   -- Returns if the nozzle is lifted
   function Nozzle_Lifted(Pump : in Pump_Type)return Boolean is (Pump.Nozzle_Lifted);


end pump;
