package body reservoir is

   procedure set_empty(res : in out reservoir_type) is
   begin
      res.amout_fuel := 0.00;
   end set_empty;

end reservoir;
