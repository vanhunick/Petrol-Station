package body reservoir is

   -- Creates and returns the reservoir type
   function Create(f_type : in Fuel_Type; amount : in Fuel_Litre) return reservoir_type is
      res : reservoir_type;
   begin
      if amount > 0.0 then
         res.empty := False;
      else
         res.empty := True;
      end if;

      res.amout_fuel := amount;
      res.fuel := f_type;

      return res;
   end Create;

   -- Sets the reservoir to be empty
   procedure set_empty(res : in out reservoir_type) is
   begin
      res.amout_fuel := 0.00;
      res.empty := true;
   end set_empty;


   -- Adds fuel to the reservoir and sets the empty flag to false if it is no longer empty
   procedure add_fuel(res : in out reservoir_type; amount : in Fuel_Litre) is
   begin
      res.amout_fuel := res.amout_fuel + amount;

      if res.amout_fuel > 0.0 then
         res.empty := False;
      end if;
   end add_fuel;

end reservoir;
