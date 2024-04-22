Version 1.1.1 of Mobile Doors by David Corbett begins here.

Chapter 1 - New properties

Include (-
Attribute mobile;
Property mobile_door;
Property mobile_door_dir;
Property mobile_door_to;
-).

Include (-
has mobile,
with mobile_door nothing nothing nothing nothing,
with mobile_door_dir [ loc; loc = location;
	if (loc == thedark) loc = real_location;
	if (loc == (self.&mobile_door)-->0) return (self.&mobile_door)-->3; return (self.&mobile_door)-->2;
],
with mobile_door_to [ loc; loc = location;
	if (loc == thedark) loc = real_location;
	if (loc == (self.&mobile_door)-->0) return (self.&mobile_door)-->1; return (self.&mobile_door)-->0;
]
-) when defining a door.

Chapter 2 - Mobility

Include (-
[ MobilizeDoor d set;
	if (set < 0) return d.mobile;
	if (set == true && d hasnt mobile) {
		give d mobile;
		if (d provides found_in) { ! two-sided door
			(d.&mobile_door)-->0 = (d.&found_in)-->0;
			(d.&mobile_door)-->1 = (d.&found_in)-->1;
			@push location;
			location = LocationOf((d.&mobile_door)-->0);
			(d.&mobile_door)-->2 = d.door_dir();
			location = LocationOf((d.&mobile_door)-->1);
			(d.&mobile_door)-->3 = d.door_dir();
			@pull location;
		} else { ! one-sided door
			(d.&mobile_door)-->0 = parent(d);
			(d.&mobile_door)-->1 = d.door_to;
			(d.&mobile_door)-->2 = d.door_dir;
		}
		(d.&door_dir)-->0 = (d.&mobile_door_dir)-->0;
		(d.&door_to)-->0 = (d.&mobile_door_to)-->0;
	}
	! Once a mobile door, always a mobile door.
];
-).

Chapter 3 - Removal from play

Section 3.1 - Phrase

To remove (D - door) from play, preserving routes:
	(- RemoveFromPlay({D}, {phrase options}); -).

Section 3.2 - Modified AssertMapConnection

Include (-
+replacing [ AssertMapConnection r1 dir r2 in_direction;
	SignalMapChange();
	in_direction = Map_Storage-->
		((r1.IK1_Count)*No_Directions + dir.IK3_Count);
	if ((in_direction == 0) || (in_direction ofclass (+ room +) or (+ door +))) {
		Map_Storage-->((r1.IK1_Count)*No_Directions + dir.IK3_Count) = r2;
		return;
	}
	RunTimeProblem(RTP_NOEXIT, r1, dir);
];
-).

Section 3.3 - Modified RemoveFromPlay

Include (-
+replacing [ RemoveFromPlay F preserve;
	if (F == nothing) return RunTimeProblem(RTP_CANTREMOVENOTHING);
	if (F == player) return RunTimeProblem(RTP_CANTREMOVEPLAYER);
	if (F ofclass (+ door +)) {
		MobilizeDoor(F, true);
		SignalMapChange();
		! The door will keep the values in mobile_door after removal, but SearchDoor relies on this.
		if (preserve) {
			if ((F.&mobile_door)-->0 ~= nothing && (F.&mobile_door)-->2)
				AssertMapConnection((F.&mobile_door)-->0, (F.&mobile_door)-->2, (F.&mobile_door)-->1);
			if ((F.&mobile_door)-->1 ~= nothing && (F.&mobile_door)-->3)
				AssertMapConnection((F.&mobile_door)-->1, (F.&mobile_door)-->3, (F.&mobile_door)-->0);
		} else {
			if ((F.&mobile_door)-->0 ~= nothing && (F.&mobile_door)-->2)
				AssertMapConnection((F.&mobile_door)-->0, (F.&mobile_door)-->2, nothing);
			if ((F.&mobile_door)-->1 ~= nothing && (F.&mobile_door)-->3)
				AssertMapConnection((F.&mobile_door)-->1, (F.&mobile_door)-->3, nothing);
		}
	}
	if (IndirectlyContains(F, player)) return RunTimeProblem(RTP_CANTBEOFFSTAGE);
	give F ~worn; DetachPart(F);
	if (F ofclass K7_backdrop) give F absent;
	remove F;
];
-).

Section 3.4 - Modified MoveFloatingObjects

Include (-
+replacing [ MoveFloatingObjects toroom i k l m address flag;
	if (toroom == nothing) toroom = real_location;
	if (toroom == nothing) return;
	objectloop (i) {
		if (i provides mobile && i has mobile) {
			if ((toroom == (i.&mobile_door)-->0 && (i.&mobile_door)-->2 ~= nothing) ||
				(toroom == (i.&mobile_door)-->1 && (i.&mobile_door)-->3 ~= nothing)) {
				if (i notin toroom) move i to toroom;
			}
		} else {
			address = i.&found_in;
			if (address ~= 0 && i hasnt absent) {
				if (ZRegion(address-->0) == 2) {
					m = address-->0;
					.TestPropositionally;
					if (m.call(toroom) ~= 0) move i to toroom;
					else { if (i in toroom) remove i; }
				} else {
					k = i.#found_in;
					for (l=0 : l<k/WORDSIZE : l++) {
						m = address-->l;
						if (ZRegion(m) == 2) jump TestPropositionally;
						if (m == toroom || m in toroom) {
							if (i notin toroom) move i to toroom;
							flag = true;
						}
					}
					if (flag == false) { if (i in toroom) remove i; }
				}
				if ((i ofclass K4_door) && (parent(i) == nothing)) {
					move i to ((i.door_to).call());
				}
			}
		}
	}
];
-).

Chapter 4 - Updating

To replace (query - object) in (D - door) with (replacement - object),
	on the opposite side, and/or
	preserving routes:
	(- SearchDoor({D}, {query}, {replacement}, {phrase options}, true); -).

Chapter 5 - Querying

Section 5.1 - Room query

To decide what object is room matching (query - object) in (D - door), on the opposite side:
	(- SearchDoor({D}, {query}, IK1_First, {phrase options}) -).

Section 5.2 - Direction query

To decide what object is direction matching (query - object) in (D - door), on the opposite side:
	(- SearchDoor({D}, {query}, IK3_First, {phrase options}) -).

Section 5.2 - Predicate

To decide whether (query - object) is matched in (D - door):
	(- (SearchDoor({D}, {query})) -).

Chapter 6 - Searching a door

Include (-
[ SearchDoor d old new opt modify i j;
	if (old == nothing && new == nothing) return;
	RemoveFromPlay(d, opt);
	for (i = 0: i < 4: i++) {
		if ((d.&mobile_door)-->i ~= old) continue;
		if (opt & 1)
			j = (i | 1) & (~(i & 1)); ! on the opposite side
		else j = i;
		if ((new ofclass (+ room +) && (j & 2) == 2) || (new ofclass (+ direction +) && (j & 2) == 0)) {
			if (old == nothing) continue;
			j = (j | 2) & (~(j & 2)); ! of the other class (room vs. direction)
		}
		if (modify == true)
			(d.&mobile_door)-->j = new;
		else 
			return (d.&mobile_door)-->j;
	}
	for (i = 0 : i < 2 : i++)
		if ((d.&mobile_door)-->i ~= nothing && (d.&mobile_door)-->(i + 2) ~= nothing)
			AssertMapConnection((d.&mobile_door)-->i, (d.&mobile_door)-->(i + 2), d);
	MoveFloatingObjects();
	rfalse;
];
-).

Chapter 7 - Moving

Section 7.1 - Phrase

To move (D - door) to (C1 - object) from/of (R1 - object) and (C2 - direction) from/of (R2 - object), preserving routes:
	(- MoveDoor({D}, {R1}, {R2}, {C1}, {C2}, {phrase options}); -).

Section 7.2 - I6 implementation

Include (-
[ MoveDoor d room1 room2 dir1 dir2 opt;
	RemoveFromPlay(d, opt);
	(d.&mobile_door)-->0 = room1;
	(d.&mobile_door)-->1 = room2;
	(d.&mobile_door)-->2 = dir1;
	(d.&mobile_door)-->3 = dir2;
	if ((d.&mobile_door)-->0 ~= nothing && (d.&mobile_door)-->2 ~= nothing)
		AssertMapConnection((d.&mobile_door)-->0, (d.&mobile_door)-->2, d);
	if ((d.&mobile_door)-->1 ~= nothing && (d.&mobile_door)-->3 ~= nothing)
		AssertMapConnection((d.&mobile_door)-->1, (d.&mobile_door)-->3, d);
	MoveFloatingObjects();
];
-).

Mobile Doors ends here.
