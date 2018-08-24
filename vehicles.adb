--vehicles.adb
with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Unchecked_Deallocation;

package body Vehicles is
     
   procedure Print(V : in Vehicle) is
   begin
      Put_Line("unknown vehicle");
   end Print;
   
   overriding procedure Print(C : in Car) is
   begin
      Put("A car with" & C.Doors'Img & " doors, by " & C.Manu);
   end Print;
   
   overriding procedure Print(P : in Plane) is
   begin
      Put("A plane with " & P.Doors'Img & " doors, and " & P.Engines'Img & " engines, by " & P.Manu);
   end Print;
   
   function Same_Manufacturer(V : in Vehicle; W : in Vehicle'Class) return Boolean is
   begin
      return False;
   end;
   
   overriding function Same_Manufacturer(C : in Car; W : in Vehicle'Class) return Boolean is
   begin
      return W in Car and then C.Manu = Car(W).Manu;
   end;
   
   overriding function Same_Manufacturer(P : in Plane; W : in Vehicle'Class) return Boolean is
   begin
      return W in Plane and then P.Manu = Plane(W).Manu;
   end;
   
end Vehicles;
