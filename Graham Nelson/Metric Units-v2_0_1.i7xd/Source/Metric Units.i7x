Version 2.0.1 of Metric Units (for Glulx only) by Graham Nelson begins here.

"Scientific kinds of value for simulations."

Use authorial modesty.

Part I - SI Base Units

Length is a kind of value.

The specification of length is "Used to measure heights, widths, distances,
thicknesses and so on."

1.0m (in metric units, in m) or 1 meter (in meters, singular) or 1 metre
(in metres, singular) or 2 meters (in meters, plural) or 2 metres (in
metres, plural) specifies a length.

1mm (in metric units, in mm) or 1 millimeter (in millimeters,
singular) or 1 millimetre (in millimetres, singular) or 2 millimeters
(in millimeters, plural) or 2 millimetres (in millimetres, plural)
specifies a length scaled down by 1000.

1cm (in metric units, in cm) or 1 centimeter (in centimeters,
singular) or 1 centimetre (in centimetres, singular) or 2 centimeters
(in centimeters, plural) or 2 centimetres (in centimetres, plural)
specifies a length scaled down by 100.

1km (in metric units, in km) or 1 kilometer (in kilometers, singular)
or 1 kilometre (in kilometres, singular) or 2 kilometers (in
kilometers, plural) or 2 kilometres (in kilometres, plural) specifies
a length scaled up by 1000.

Mass is a kind of value.

The specification of mass is "Used to measure how much of something is
present. Start fights with other nerds by deliberately mixing this up with
weight, which comes to the same thing for everyday purposes at ground level."

1.0kg (in metric units, in kg) or 1 kilogram (in kilograms, singular) or
2 kilograms (in kilograms, plural) specifies a mass.

1g (in metric units, in g) or 1 gram (in grams, singular) or 2 grams
(in grams, plural) specifies a mass scaled down by 1000.

1 tonne (in metric units, in tonnes, singular) or 2 tonnes (in metric units,
in tonnes, plural) specifies a mass scaled up by 1000.

Elapsed time is a kind of value.

The specification of elapsed time is "Used to measure how much time
something takes. Inform already has a built-in kind of value called
'time', which counts in minutes and keeps track of the time of day -
which is fine for most stories, but not good enough for science. So we
call this more precise version 'elapsed time'."

1.0s (in metric units, in s) or 1 second (in seconds, singular) or 2 seconds
(in seconds, plural) specifies an elapsed time.

1 min (in metric units, in min) specifies an elapsed time scaled up by 60.

1 hr (in metric units, in hr) specifies an elapsed time scaled up by 3600.

1 day (in metric units, in days, singular) or 2 days (in metric units,
in days, plural) specifies an elapsed time scaled up by 86400.

1 week (in metric units, in weeks, singular) or 2 weeks (in metric units,
in weeks, plural) specifies an elapsed time scaled up by 604800.

Electric current is a kind of value.

The specification of electric current is "Used to measure the amount of
electricity flowing through something at any given moment."

1.0A (in metric units, in A) or 1 amp (in amps, singular) or 2 amps
(in amps, plural) specifies an electric current.

1mA (in metric units, in mA) or 1 milliamp (in milliamps, singular) or
2 milliamps (in milliamps, plural) specifies an electric current scaled
down by 1000.

Temperature is a kind of value.

The specification of temperature is "Used to measure how hot or cold
something is. (Note that Inform writes '1 C' for one coulomb, and '1C' for
one degree centigrade.)"

1.0C (in metric units, in C) or 1 degree centigrade (in degrees centigrade,
singular) or 2 degrees centigrade (in degrees centigrade, plural) or 1 degree
Celsius (in degrees Celsius, singular) or 2 degrees Celsius (in degrees
Celsius, plural) specifies a temperature.

Luminosity is a kind of value.

The specification of luminosity is "Used to measure the total amount of
light. (This is not quite the same thing as brightness - that's the amount
of light produced per unit of area, and is called luminance.) Candela is a
term adopted in 1948 to replace the old 'candlepower', but 1 cd remains
about the light of a single candle. A strong light-bulb produces about 100
cd; a very small indicator LED about 0.001 cd; and the old Blackpool
Illuminations were about 20000 cd."

1.0 cd (in metric units, in cd) or 1 candela (in candelas, singular) or
2 candelas (in candelas, plural) specifies a luminosity.

[There is also the mole, an amount of substance, as used in chemistry.]


Part II - SI Derived Units

Frequency is a kind of value. 

The specification of frequency is "Used to measure how often a series of events
takes place, with 1 Hertz meaning once per second. 1 mHz is about the frequency
of a bus arriving at an urban stop in daytime; human eyes can't detect
flickering faster than around 100 Hz, which is why high-end television sets
refresh at about that rate."

1.0 Hz (in metric units, in Hz) or 1 Hertz (in Hertz) specifies
a frequency.

1 mHz (in metric units, in mHz) or 1 millihertz (in millihertz)
specifies a frequency scaled down by 1000.

1 kHz (in metric units, in kHz) or 1 kilohertz (in kilohertz)
specifies a frequency scaled up by 1000.

Elapsed time times frequency specifies a number.

Force is a kind of value.

The specification of force is "Used to measure how much push or pull is
needed to make something move (properly speaking, accelerate). 1N is about
the force of Earth's gravity acting on a typical apple. 0.001N is a tug
which would barely move a pebble. A climber's rope will typically break
under a force of about 20kN, or half that if it's knotted. (Stylishly if
bizarrely, some people call the kilonewton the 'sthène', but Inform
doesn't.) 2000kN is roughly the thrust of one of the Space Shuttle Main
Engines, which is about the most violent controlled machine ever built."

1.0N (in metric units, in N) or 1 Newton (in Newtons, singular) or 2 Newtons
(in Newtons, plural) specifies a force.

1kN (in metric units, in kN) or 1 kilonewton (in kilonewtons, singular) or
2 kilonewtons (in kilonewtons, plural) specifies a force scaled up by 1000.

Energy is a kind of value.

The specification of energy is "Used to measure how much ability something
has to do work. Human beings give off about 100J in body heat every second
just sitting still. 2000kJ is twice the food energy stored in a Mars bar,
or enough to run a typical electric radiant heater for an hour."

1.0J (in metric units, in J) or 1 Joule (in Joules, singular) or 2 Joules
(in Joules, plural) specifies an energy.

1mJ (in metric units, in mJ) or 1 millijoule (in millijoules, singular) or
2 millijoules (in millijoules, plural) specifies an energy scaled down by 1000.

1kJ (in metric units, in kJ) or 1 kilojoule (in kilojoules, singular) or
2 kilojoules (in kilojoules, plural) specifies an energy scaled up by 1000.

Force times length specifies an energy.

Pressure is a kind of value.

The specification of pressure is "Used to measure how much force is being
applied per unit of area, sometimes by one object pulled against another,
sometimes by gas or water pressing in on things inside it. 1Pa is the tiny
pressure which a bank note applies to a table it's sitting on top of;
20000MPa can compress carbon into diamonds. Atmospheric pressure at sea level
is about 100kPa; water pressure at the bottom of the Mariana Trench a
thousand times greater, at about 100MPa."

1.0Pa (in metric units, in Pa) or 1 Pascal (in Pascals, singular) or 2 Pascals
(in Pascals, plural) specifies a pressure.

1kPa (in metric units, in kPa) or 1 kilopascal (in kilopascals, singular) or
2 kilopascals (in kilopascals, plural) specifies a pressure scaled up by 1000.

1MPa (in metric units, in MPa) or 1 megapascal (in megapascals, singular) or
2 megapascals (in megapascals, plural) specifies a pressure scaled up by
1000000.

Power is a kind of value.

The specification of power is "Used to measure how much energy something can
apply in a given time - in the same period of time powerful things can do a lot
while feeble things much less. Typical domestic light bulbs take 60W of power
to run (twice as much as the human brain), and electric heaters perhaps 3kW."

1.0W (in metric units, in W) or 1 Watt (in Watts, singular) or 2 Watts
(in Watts, plural) specifies a power.

1mW (in metric units, in mW) or 1 milliwatt (in milliwatts, singular) or
2 milliwatts (in milliwatts, plural) specifies a power scaled down by 1000.

1kW (in metric units, in kW) or 1 kilowatt (in kilowatts, singular) or
2 kilowatts (in kilowatts, plural) specifies a power scaled up by 1000.

Elapsed time times power specifies an energy.

Electric charge is a kind of value.

The specification of electric charge is "Electricity works because,
although matter is usually 'neutral', electric charge can flow between one
thing and another so that this balance is broken, and then a force is felt
between them. Electric forces are very strong, so even a small charge has a
big effect - a storm cloud might only have a charge of 20 C, but that's
enough to cause thunder and lightning. On the other hand batteries store
very large charges, but of course release them much more slowly - a typical
car battery holds about 200 kC. (Note that Inform writes '1 C' for one
coulomb, and '1C' for one degree centigrade.)"

1.0 C (in metric units, in C) or 1 Coulomb (in Coulombs, singular) or
2 Coulombs (in Coulombs, plural) specifies an electric charge.

1 kC (in metric units, in kC) or 1 kilocoulomb (in kilocoulombs, singular)
or 2 kilocoulombs (in kilocoulombs, plural) specifies an electric charge
scaled up by 1000.

Elapsed time times electric current specifies an electric charge.

Voltage is a kind of value.

The specification of voltage is "Measures the 'potential difference' between
two points, a sort of pulling power for electricity. Quite low voltages can be
dangerous on human skin - a 50V potential difference between two points on the
body can cause enough charge to flow to electrocute somebody."

1.0V (in metric units, in V) or 1 volt (in volts, singular) or 2 volts
(in volts, plural) specifies a voltage.

1mV (in metric units, in mV) or 1 millivolt (in millivolts, singular) or
2 millivolts (in millivolts, plural) specifies a voltage scaled down by 1000.

1kV (in metric units, in kV) or 1 kilovolt (in kilovolts, singular) or
2 kilovolts (in kilovolts, plural) specifies a voltage scaled up by 1000.

Voltage times electric current specifies a power. Voltage times electric
charge specifies energy.

Luminance is a kind of value.

The specification of luminance is "Used to measure the brightness of something:
how much light it produces per unit of its surface area. (The actual amount
of light produced is luminosity. A fully lit computer display of 2008 has a
brightness of about 330 cd/sq m, and has a surface area of maybe 0.5 sq m,
so pours out about 150 cd. This is more than a domestic light bulb
produces, but the bulb is much, much brighter - maybe 150000 cd/sq m -
because the light comes out of a smaller area.) A luminance of 0.001 cd/sq m
is so dim it can barely be seen, whereas 2000000 cd/sq m would be painful
to look at."

1.0 cd/sq m (in metric units, in cd/sq m) or 1 candela per square meter (in
candelas per square meter, singular) or 2 candelas per square meter
(in candelas per square meter, plural) specifies a luminance.

[I'm leaving out capacitance, resistance, conductance, magnetic flux, magnetic
field, and inductance for now, but they could easily be added.]

[There are also angle, solid angle, luminous flux, and some specialist
measures of radioactive dosage and level of catalysis.]


Part III - SI Compound Units

Area is a kind of value.

1.0 sq m (in metric units, in sq m) or 1 square meter (in square meters,
singular) or 2 square meters (in square meters, plural) or 1 square metre
(in square metres, singular) or 2 square metres (in square metres, plural)
specifies an area.

1.0 sq cm (in metric units, in sq cm) or 1 square centimeter (in square
centimeters, singular) or 2 square centimeters (in square centimeters,
plural) or 1 square centimetre (in square centimetres, singular) or 2
square centimetres (in square centimetres, plural) specifies an area scaled
down by 10000.

1.0 hectare (in metric units, in hectares, singular) or 2 hectares (in metric
units, in hectares, plural) specifies an area scaled up by 10000.

The specification of area is "Measures the extent of a two-dimensional surface,
usually a patch of land or the covering of an object. 1 sq cm is about the
area of a small coin, whereas 20 hectares would be the grounds of a large
country house or a typical French vineyard. A boxing ring is 36 sq m; a sports
field about 6000 sq m."

Length times length specifies an area. Pressure times area specifies
a force. Area times luminance specifies a luminosity.

A Volume is a kind of value. [That "A" prevents Inform mistaking the line for
a volume heading, in the literary sense.]

1.0 cu m (in metric units, in cu m) or 1 cubic meter (in cubic meters,
singular) or 2 cubic meters (in cubic meters, plural) or 1 cubic metre
(in cubic metres, singular) or 2 cubic metres (in cubic metres, plural)
specifies an volume.

1.0 l (in metric units, in l) or 1 liter (in liters, singular) or 2 liters
(in liters, plural) or 1 litre (in litres, singular) or 2 litres (in
litres, plural) specifies a volume scaled down by 1000.

1.0 cc (in metric units, in cc) or 1 cubic centimeter (in cubic centimeters,
singular) or 2 cubic centimeters (in cubic centimeters, plural) or 1 cubic
centimetre (in cubic centimetres, singular) or 2 cubic centimetres (in
cubic centimetres, plural) or 1 ml (in ml) or 1 millilitre (in millilitres,
singular) or 2 millilitres (in millilitres, plural) or 1 milliliter (in
milliliters, singular) or 2 milliliters (in milliliters, plural) specifies
a volume scaled down by 1000000.

The specification of volume is "Measures the extent of a three-dimensional
space, usually the space taken up by an object or the space inside a
container. 1 cc (or 1 ml - same thing) is about a teaspoon-full, whereas
1000 cu m is roughly the capacity of an Olympic swimming pool."

Length times area specifies a volume.

Velocity is a kind of value.

1.0 m/s (in metric units, in m/s) or 1 meter per second (in meters per
second, singular) or 1 metre per second (in metres per second, plural)
specifies a velocity.

1.0 km/s (in metric units, in km/s) or 1 kilometer per second (in kilometers per
second, singular) or 1 kilometre per second (in kilometres per second, plural)
specifies a velocity scaled up by 1000.

The specification of velocity is "Measures how fast something is moving
relative to something else - usually something apparently fixed, like the
ground. 0.01 m/s is the speed of a garden snail; people walk at about 1.2 m/s,
cars drive at about 30 m/s; high speed trains are up to 160 m/s. The speed
of sound is around 330 m/s at sea level on a cool day, and nothing travels
faster than light, at 299792458 m/s."

Velocity times elapsed time specifies a length.

Acceleration is a kind of value.

1.0 m/ss (in metric units, in m/ss) or 1 meter per second squared (in meters
per second squared, singular) or 2 meters per second squared (in meters per
second squared, plural) or 1 metre per second squared (in metres
per second squared, singular) or 2 metres per second squared (in metres per
second squared, plural) specifies an acceleration.

The specification of acceleration is "Measures the rate at which something
is gaining velocity - a positive acceleration makes something speed up,
negative makes it slow down. Accelerations look small, numerically, but have
large effects very quickly in practice - a high-performance Bugatti sports
car accelerates at only about 6 m/ss, but you'd notice all right if it
happened in front of you. Surface gravity on the tiny asteroid of Gaspra
is about 0.002 m/ss; whereas on Earth, gravity accelerates falling objects
at about 9.789 m/ss at the equator, 9.832 m/ss at the poles, so people
usually calculate with an average mid-latitudes value of 9.807 m/ss."

Acceleration times elapsed time specifies a velocity. Mass times
acceleration specifies a force.

Momentum is a kind of value.

1.0 Ns (in metric units, in Ns) or 1 Newton-second (in Newton-seconds) specifies
a momentum.

The specification of momentum is "Momentum is the product of mass and velocity
for a moving object, so it measures in effect how hard it would shove you;
historical physicists had some trouble finding a good word for this concept,
but it's important because of the Principle of Conservation of Momentum -
the total momentum of all the bodies involved in a collision is constant
whatever happens in it. Billiard balls weigh about 150g, and travel at about
0.25 m/s, so each one has a momentum of about 0.038 Ns."

Mass times velocity specifies a momentum.

Density is a kind of value.

1.0 kg/cu m (in metric units, in kg/cu m) or 1 kilogram per cubic meter (in
kilograms per cubic meter, singular) or 2 kilogram per cubic meters (in
kilograms per cubic meter, plural) or 1 kilogram per cubic metre (in
kilograms per cubic meter, singular) or 2 kilograms per cubic metre (in
kilograms per cubic meter, plural) specifies a density.

1 g/cu m (in metric units, in kg/cu m) or 1 gram per cubic meter (in
grams per cubic meter, singular) or 2 gram per cubic meters (in
grams per cubic meter, plural) or 1 gram per cubic metre (in
grams per cubic meter, singular) or 2 grams per cubic metre (in
grams per cubic meter, plural) specifies a density scaled down by 1000.

1 g/cc (in metric units, in g/cc) or 1 gram per cubic centimeter (in
grams per cubic centimeter, singular) or 2 gram per cubic centimeters (in
grams per cubic centimeter, plural) or 1 gram per cubic centimetre (in
grams per cubic centimeter, singular) or 2 grams per cubic centimetre (in
grams per cubic centimeter, plural) specifies a density scaled up by 1000.

The specification of density is "Density is the amount of mass per unit volume.
(When people say that a substance is heavy, they usually mean it has a high
density.) The densest stuff on Earth is osmium metal, at 22610 kg/cu m; the
least dense is hydrogen gas, at 90 g/cu m. All else being equal, objects
whose density is below that of water - 1000 kg/cu m - will float up to the
surface if submerged. (That only includes human beings - 1010 kg/cu m - when
they have air in their lungs, reducing their density.)"

Density times volume specifies a mass.

Heat capacity is a kind of value.

1.0 J/C (in metric units, in J/C) or 1 Joule per degree centigrade (in Joules
per degree centigrade, singular) or 2 Joules per degree centigrade (in Joules
per degree centigrade, plural) specifies a heat capacity.

The specification of heat capacity is "Heat capacity is also known as thermal
mass, and measures how much energy it takes to increase the temperature of
something by one degree. (See specific heat capacity for typical values.)
Entropy is also measured as a heat capacity."

Heat capacity times temperature specifies an energy.

Specific heat capacity is a kind of value.

1.0 J/kg/C (in metric units, in J/kg/C) or 1 Joule per kilogram per degree
centigrade (in Joules per kilogram per degree centigrade, singular) or 2 Joules
per kilogram per degree centigrade (in Joules per kilogram per degree
centigrade, plural) specifies a specific heat capacity.

Specific heat capacity times a mass specifies a heat capacity.

The specification of specific heat capacity is "Whereas heat capacity measures
the energy needed to heat up a specific object - say, a whole house - specific
heat capacity is the energy needed per kilogram of its mass. Thus wood, at
420 J/kg/C, heats up and cools down twice as fast as brick, marble, sand or
soil, all at about 800 J/kg/C; glass is somewhere in between. Liquid water
takes a lot more energy to heat up, at 4180 J/kg/C; but at least this means
that hot baths stay hot for a little while. Butters and oils tend to be in
the range 1500 to 2000 J/kg/C, and most foodstuffs in the 3000s: banana,
3350 J/kg/C; chicken, 3200 J/kg/C; eggs, 3180 J/kg/C and so forth."

[That leaves torque, energy density, and a few other oddities.]

Metric Units ends here.
