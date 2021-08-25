private with Ada.Calendar;

package Stopwatch is

   type Instance is tagged private;

   procedure Reset (This : in out Instance);

   function Elapsed (This : Instance) return Duration;

   procedure Hold (This : in out Instance; Release : Boolean := False);
   --  Stop counting time, or re-start if Release

   function Is_Held (This : Instance) return Boolean;

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
