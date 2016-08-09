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

   -- Adds fuel to the reservoir and sets the empty flag to false if it is no longer empty
   procedure Add_Fuel(Res : in out Reservoir_Type; Amount : in Fuel_Litre) is
   begin
      Res.Amout_Fuel := Res.Amout_Fuel + Amount;

      if Res.Amout_Fuel > 0.0 then
         Res.Empty := False;
      end if;
   end Add_Fuel;


   procedure Remove_Fuel(Res : in out Reservoir_Type; Amount : in Fuel_Litre) is
   begin
      Res.Amout_Fuel := Res.Amout_Fuel - Amount;
   end Remove_Fuel;

   function Get_Cost(Res : in Reservoir_Type)return Dollars is (Res.Cost);

   function Get_Fuel_Type(Res : in Reservoir_Type)return Fuel_Type is (Res.Fuel);

   function Get_Fuel_Left(Res : in Reservoir_Type)return Fuel_Litre is (Res.Amout_Fuel);

end reservoir;
