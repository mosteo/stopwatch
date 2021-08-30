private with Ada.Calendar;

package Stopwatch is

   type Instance is tagged private;

   procedure Reset (This : in out Instance);

   function Elapsed (This : Instance) return Duration;

   procedure Hold (This : in out Instance; Enable : Boolean := True);
   --  Stop counting time, or re-start if not Enable

   procedure Release (This : in out Instance);
   --  Equivalent to Hold (Enable => False)

   function Is_Held (This : Instance) return Boolean;

   function Image (This : Instance; Decimals : Natural := 2) return String;
   --  Elapsed time in seconds, without leading space, without units

   function Image (Elapsed : Duration; Decimals : Natural := 2) return String;
   --  Convenience to format durations even without a stopwatch

private

   use Ada.Calendar;

   type Instance is tagged record
      Start   : Time     := Clock;
      --  Last moment the timer was released/started

      Held    : Boolean  := False;

      Elapsed : Duration := 0.0;
      --  Track elapsed time when held
   end record;

end Stopwatch;
