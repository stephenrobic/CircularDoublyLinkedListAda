This is a circular doubly linked list implemented in Ada, using generics for the easy 
addition of different data types and info into the same list at the same time.

This implementation uses a list head, which keeps track of the number of nodes in the list 
(or other general pertinent information about the list that may change as nodes are added or removed).

The following functions are available:
	-Insert to the front of the list
	-Insert to the rear of the list
	-Remove from the from of the list
	-Remove from the rear of the list
	-Display the list size
	-Find Item On List and return its pointer
	-Find and Remove Item from List
	-Print an Item on the list's info given a pointer to it
	-Print Items on list from front to Rear
			
In the "vehiclelist" driver, as an example for a class project, I used cars and planes as data types in the same list. 
For cars, the number of doors and the manufacturer name are recorded. For planes, the number of doors, 
the number of engines, and the manufacturer name are recorded.