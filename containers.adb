--containers.adb
with Ada.Unchecked_Deallocation;
with Ada.Text_IO; use Ada.Text_IO;

package body Containers is
   
   procedure Free is new Ada.Unchecked_Deallocation(Element, Element_Ptr);
   
   procedure Init_List(L : in out List) is
      Head : Element_Ptr := new Element;
   begin
      L.Size := 0;
      Head.Data := null;
      Head.Next := Head;
      Head.Previous := Head;
      L.Head := Head;
   end;
   
   procedure Free_List(L : in out List) is
      B: Element_Ptr;
   begin
      -- TODO: pop / free elements until list is empty?
      -- TODO: or raise exception if Size /= 0?
      B := L.Head;
      Free(B);
      L.Head := null;
   end;
 
   function List_Size(L : in List) return Integer is
   begin
      return L.Size;
   end;
      
   procedure Insert_Front(L : in out List; D : Data_Ptr) is
      E : Element_Ptr := new Element;
   begin
      E.Data := D;
      E.Next := L.Head.Next;
      E.Previous := L.Head;
      E.Next.Previous := E;
      E.Previous.Next := E;
      L.Size := L.Size + 1;     
   end;
      
   procedure Insert_Rear(L : in out List; D : Data_Ptr) is
      E : Element_Ptr := new Element;
   begin
      E.Data := D;
      E.Previous := L.Head.Previous;
      E.Next := L.Head;
      E.Previous.Next := E;
      E.Next.Previous := E;
      L.Size := L.Size + 1;
   end;
   
   function Remove_Front(L : in out List) return Data_Ptr is
      E : Element_Ptr;
      D : Data_Ptr;
   begin
      if L.Head.Next = L.Head then
         return null;
      end if;
      E := L.Head.Next;
      E.Next.Previous := L.Head;
      L.Head.Next := E.Next;
      D := E.Data;
      Free(E);
      L.Size := L.Size - 1;
      return D;
   end;
   
   --not needed; just for flexibility
   function Remove_Rear(L : in out List) return Data_Ptr is
      E : Element_Ptr;
      D : Data_Ptr;
   begin
      if L.Head.Previous = L.Head then
         return null;
      end if;
      E := L.Head.Previous;
      E.Previous.Next := L.Head;
      L.Head.Previous := E.Previous;
      D := E.Data;
      Free(E);
      L.Size := L.Size - 1;
      return D;
   end;
        
   procedure Process_All(L : in List) is
      E: Element_Ptr;
   begin
      E := L.Head.Next;
      while E /= L.Head loop         
         Process(E.Data.all);
         E := E.Next;
         New_Line;
      end loop;
   end;
   
   function Find_First_Equal(L : in List; C : Data_Ptr) return Data_Ptr is
      E: Element_Ptr;
   begin
      E := L.Head.Next;
      while E /= L.Head loop
         if C.all = E.Data.all then
            return E.Data;
         end if;
         E := E.Next;
      end loop;
      return null;
   end;

   function Remove_First_Equal(L : in out List; C : Data_Ptr) return Data_Ptr is
      E: Element_Ptr;
      D : Data_Ptr;
   begin
      E := L.Head.Next;
      while E /= L.Head loop
         if C.all = E.Data.all then
            E.Previous.Next := E.Next;
            E.Next.Previous := E.Previous;
            D := E.Data;
            Free(E);
            L.Size := L.Size - 1;
            return D;
         end if;
         E := E.Next;
      end loop;
      return null;
   end;

end Containers;
