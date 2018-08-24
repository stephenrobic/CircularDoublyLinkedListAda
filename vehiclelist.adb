--vehiclelist.adb
with Containers;
with Vehicles; use Vehicles;
with Ada.Unchecked_Deallocation;
with Ada.Text_IO; use Ada.Text_IO;

procedure VehicleList is

   type Vehicle_Ptr is access all Vehicle'Class;   
   procedure Free is new Ada.Unchecked_Deallocation(Vehicle'Class, Vehicle_Ptr);
  
   procedure Do_Print(P : Vehicle'Class) is
   begin
      Print(P);
   end;

   function Is_Same_Manufacturer(V : in Vehicle'Class; W : in Vehicle'Class) return Boolean is
   begin
      return Same_Manufacturer(V, W);
   end;
   
   package VehicleContainers is new Containers(Vehicle, Is_Same_Manufacturer);
   use VehicleContainers;   
   
   procedure Print_All is new Process_All(Do_Print);

   L: List;
   V : access Vehicle'Class;
   C : access Car;  
   P : access Plane; -- heap allocated, must be freed
   F : aliased Car;
   
begin
   Init_List(L);
   
    --a) Insert a Ford with 4 doors at the rear
   C := new Car'(Doors => 4, Manu => "Ford ");
   Insert_Rear(L, Data_Ptr(C));
   Print(C.all); Put("has been added to the list.");New_Line(2);

   --b) Insert a Ford with 2 doors ar the front
   C := new Car'(Doors => 2, Manu => "Ford ");
   Insert_Front(L, Data_Ptr(C));
   Print(C.all); Put("has been added to the list."); New_Line(2);  

   --c) insert a GMC with 2 doors at the rear
   C := new Car'(Doors => 2, Manu => "GMC  ");
   Insert_Rear(L, Data_Ptr(C));
   Print(C.all); Put("has been added to the list.");New_Line(2);

   --d) insert a RAM with 2 foors at the rear
   C := new Car'(Doors => 2, Manu => "RAM  ");
   Insert_Rear(L, Data_Ptr(C));
   Print(C.all); Put("has been added to the list.");New_Line(2);  

   --e) insert a Chevy with 3 doors at the front
   C := new Car'(Doors => 3, Manu => "Chevy");
   Insert_Front(L, Data_Ptr(C));
   Print(C.all); Put(" has been added to the list.");New_Line(2);
   
   --f) Print number of items in list
   Put_Line("The number of items in the list is: " & List_Size(L)'Img);
   
   New_Line;
   --g)Print the contents of the list (front to rear)
   Put_Line("The contents of the list are: ");
   Print_All(L);
   New_Line;
   
   --h) Find and delete the first Ford in the list (search front to rear)
   F := Car'(-1, "Ford ");
     
   V := Find_First_Equal(L, F'Access);
   V := Remove_First_Equal(L, F'Access);
   put_line("The following vehicle has been deleted from the list:");
   Print(V.all);
   New_Line;
   
   --i) Print the number of items in the list
   New_Line;
   Put_Line("The number of items in the list is now: "& List_Size(L)'Img);
   
   --j)Print the contents of the list (front to rear)
   New_line;
   Put_Line("The list now contains: ");
   Print_All(L);
   New_Line;
   
   --k) insert a plane with 3 doors and 6 engines by Boeing at the front
   P := new Plane'(Doors => 3, Engines => 6,  Manu => "Boeing");
   Insert_Front(L, Data_Ptr(P));
   Print(P.all); Put("has been added to the list.");New_Line(2);

   
   --l) Insert a Plane with 2 doors and 1 engine by Piper at the front
   
   P := new Plane'(Doors => 2, Engines => 1,  Manu => "Piper ");
   Insert_Front(L, Data_Ptr(P));
   Print(P.all); Put_Line("has been added to the list.");New_Line;

   
   --m) Insert a Plane with 4 doors and 4 engines by Cessna at the front
   P := new Plane'(Doors => 4, Engines => 4,  Manu => "Cessna");
   Insert_Front(L, Data_Ptr(P));
   Print(P.all); Put("has been added to the list.");New_Line;

   --n) Print the List
   New_Line;
   Put_Line("The list now contains: ");
   Print_All(L);
   New_Line;
  
   --since allocated in heap memory, needs to be deallocated?
   Loop
      V := Remove_Front(L);
      if V = null then
         exit;
      end if;
      Free(V);
   end loop;
   Free_List(L);
   
end VehicleList;
