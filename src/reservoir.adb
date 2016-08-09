package body reservoir is

   -- Creates and returns the reservoir type
   function Create(f_type : in Fuel_Type; amount : in Fuel_Litre; cost_fuel : in Dollars) return reservoir_type is
      res : reservoir_type;
   begin
      if amount > 0.0 then
         res.empty := False;
      else
         res.empty := True;
      end if;

      res.amout_fuel := amount;
      res.fuel := f_type;
      res.cost := cost_fuel;

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

   procedure remove_fuel(res : in out reservoir_type; amount : in Fuel_Litre) is
   begin
      res.amout_fuel := res.amout_fuel - amount;
   end remove_fuel;

   function get_cost(res : in reservoir_type)return Dollars is (res.cost);

   function Get_Fuel_Type(res : in reservoir_type)return Fuel_Type is (res.fuel);

   function get_fuel_Left(res : in reservoir_type)return Fuel_Litre is (res.amout_fuel);



end reservoir;
