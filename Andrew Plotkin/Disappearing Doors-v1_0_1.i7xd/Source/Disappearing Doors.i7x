Version 1.0.1 of Disappearing Doors by Andrew Plotkin begins here.

"The ability to remove doors from the world and put them back."

Definition: a door is absent rather than present if I6 routine "AssertDoorAbsent" makes it so (it is out of scope and untraversible).

Include (-
[ AssertDoorAbsent door flag
	addr rm1 rm2 dir1 dir2 off1 off2;
	
	if (flag == -1) {
		return (door has absent);
	}
	
	! door.found_in should be a list of two rooms, which is I7's normal arrangement
	addr = door.&found_in;
	if (addr == 0 || door.#found_in ~= 2*WORDSIZE)
		print_ret "(BUG) Cannot activate/deactivate door: malformed found_in: ", (name) door;
	rm1 = addr-->0;
	rm2 = addr-->1;
	
	@push location;
	location = rm1;
	dir1 = door.door_dir();
	location = rm2;
	dir2 = door.door_dir();
	@pull location;
	
	if (~~(dir1 ofclass (+ direction +) && dir2 ofclass (+ direction +) ))
		print_ret "(BUG) Cannot activate/deactivate door: directions not found: ", (name) door;
	
	off1 = ((rm1.IK1_Count)*No_Directions + dir1.IK3_Count);
	off2 = ((rm2.IK1_Count)*No_Directions + dir2.IK3_Count);

	if (flag) {
		if (door hasnt absent) {
			SignalMapChange();
			
			if (Map_Storage-->off1 == door)
				Map_Storage-->off1 = 0;
			else
				print "(BUG) Map_Storage from door does not match^";
			if (Map_Storage-->off2 == door)
				Map_Storage-->off2 = 0;
			else
				print "(BUG) Map_Storage from door does not match^";
			
			give door absent;
			remove door;
		}
	}
	else {
		if (door has absent) {
			SignalMapChange();
			
			if (Map_Storage-->off1 == 0)
				Map_Storage-->off1 = door;
			else
				print "(BUG) Map_Storage from door does not match^";
			if (Map_Storage-->off2 == 0)
				Map_Storage-->off2 = door;
			else
				print "(BUG) Map_Storage from door does not match^";
			
			give door ~absent;
			if (rm1 == real_location || rm2 == real_location)
				move door to real_location;
			else
				remove door;
		}
	}
];
-) after "Map Connections" in "WorldModel.i6t".

Disappearing Doors ends here.
