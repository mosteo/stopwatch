with Ada.Text_IO;

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

   procedure Hold (This : in out Instance; Enable : Boolean := True) is
   begin
      if Enable and then not This.Is_Held then
         This.Held    := True;
         This.Elapsed := This.Elapsed + (Clock - This.Start);
      elsif not Enable and then This.Is_Held then
         This.Held  := False;
         This.Start := Clock;
      end if;
   end Hold;

   -----------
   -- Image --
   -----------

   function Image (This : Instance; Decimals : Natural := 2) return String
   is (Image (This.Elapsed, Decimals));

   -----------
   -- Image --
   -----------

   function Image (Elapsed : Duration; Decimals : Natural := 2) return String
   is
      package FIO is new Ada.Text_IO.Fixed_IO (Duration);
      package IIO is new Ada.Text_IO.Integer_IO (Natural);
      Buffer : String (1 .. 32) := (others => ' ');
   begin
      if Decimals > 0 then
         FIO.Put (Buffer, Elapsed, Aft => Decimals);
      else
         IIO.Put (Buffer, Natural (Elapsed));
      end if;

      --  Locate first non-blank and return from there, as Put is right-aligned
      for I in Buffer'Range loop
         if Buffer (I) /= ' ' then
            return Buffer (I .. Buffer'Last);
         end if;
      end loop;

      raise Program_Error with "Put did not put anything";
   end Image;

   -------------
   -- Is_Held --
   -------------

   function Is_Held (This : Instance) return Boolean is (This.Held);

   procedure Release (This : in out Instance) is
   begin
      This.Hold (Enable => False);
   end Release;

end Stopwatch;
