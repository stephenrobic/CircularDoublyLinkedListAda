--in Containers.ads
with Ada.Unchecked_Deallocation;

generic
   type Data is tagged limited private;
   with function "="(C,D: Data'Class) return Boolean;
package Containers is
   type List is private;
   type Data_Ptr is access all Data'Class;
   
   procedure Init_List(L : in out List);
   procedure Free_List(L : in out List); --free all from heap memory
   function List_Size(L : in List) return Integer;
   
   procedure Insert_Front(L : in out List; D : Data_Ptr);
   procedure Insert_Rear(L : in out List; D : Data_Ptr);
   function Remove_Front(L : in out List) return Data_Ptr;
   function Remove_Rear(L : in out List) return Data_Ptr;   
   
   generic
      with procedure Process(D : Data'Class);
   procedure Process_All(L : in List);
   
   function Find_First_Equal(L : in List; C : Data_Ptr) return Data_Ptr;
   
   function Remove_First_Equal(L : in out List; C : Data_Ptr) return Data_Ptr;            
   
private
   type Element;
   type Element_Ptr is access Element;
   type Element is record
      Data : Data_Ptr;
      Next, Previous : Element_Ptr;
   end record;      
   type List is record
      Size: Integer := 0;
      Head : Element_Ptr;
   end record;
end Containers;
