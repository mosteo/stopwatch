pragma Ada_2012;
package body Stopwatch is

   -----------
   -- Reset --
   -----------

   procedure Reset (This : in out Instance) is
   begin
      This := (others => <>);
   end Reset;

   -------------
   -- Elapsed --
   -------------

   function Elapsed (This : Instance) return Duration is
   begin
      return This.Elapsed +
        (if This.Is_Held
         then 0.0
         else Clock - This.Start);
   end Elapsed;

   ----------
   -- Hold --
   ----------

   procedure Hold (This : in out Instance; Release : Boolean := False) is
   begin
      if not Release and then not This.Is_Held then
         This.Held    := True;
         This.Elapsed := This.Elapsed + (Clock - This.Start);
      elsif Release and then This.Is_Held then
         This.Held  := False;
         This.Start := Clock;
      end if;
   end Hold;

   -------------
   -- Is_Held --
   -------------

   function Is_Held (This : Instance) return Boolean is (This.Held);

end Stopwatch;
