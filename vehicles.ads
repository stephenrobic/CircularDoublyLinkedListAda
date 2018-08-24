--vehicles.ads
with Ada.Text_IO;
use Ada.Text_IO;

package Vehicles is
   
   type Vehicle is tagged null record;
   procedure Print(V : in Vehicle);
   function Same_Manufacturer(V : in Vehicle; W : in Vehicle'Class) return Boolean;
   
   type Car is new Vehicle with record
      Doors: Integer;
      Manu: String(1..5);
   end record;   
   overriding procedure Print(C : in Car);
   overriding function Same_Manufacturer(C : in Car; W : in Vehicle'Class) return Boolean;
   
   type Plane is new Vehicle with record
      Doors: Integer;
      Engines: Integer;
      Manu: String(1..6);
   end record;
   overriding procedure Print(P : in Plane);
   overriding function Same_Manufacturer(P : in Plane; W : in Vehicle'Class) return Boolean;

end Vehicles;
