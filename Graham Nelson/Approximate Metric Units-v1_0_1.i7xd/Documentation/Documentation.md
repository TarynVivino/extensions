(Note: This extension uses integer arithmetic for its calculations, which was the best that could be done until June 2012. The new version of "Metric Units" uses floating-point calculations and is much more accurate, though it only works on versions of the Glulx virtual machine dating from 2011. This is a renamed copy of the old "Metric Units", and is preserved in case people need it to keep older works running.)

The metric system provides a consistent set of units for scientific measurement of the world. Though often associated with the French Revolution or with Napoleon, the system of metric units only really began to displace existing units in May 1875, when it was made official by an international treaty. In 1960, it was renamed the "Système international d'unités", which is usually abbreviated "SI".

This extension is a kit for writers who want to make realistic simulations, backed up by some quantitative physics. It defines kinds of values for the 25 or so SI units in common usage, and more than 100 notations for them. It also makes sure they multiply correctly. For instance, a mass times an acceleration produces a force, so

	say "You feel a force of [2kg times 5 m/ss]."

will produce the text "You feel a force of 10N." The easiest way to see how all these units combine is to run one of the examples below and look at the Kinds index which results.

For each unit, both names and notations are allowed. Thus '2 kilograms' is
equivalent to '2kg'. Both English and French spellings of 'meter'/'metre' and 'liter'/'litre' are allowed, but we insist on 'gram' not 'gramme' and 'tonne' not 'ton'. ('Ton' is too easily confused with the Imperial measure, which is not quite the same.) We can print back the same value in a variety of ways. For instance:

	say "[m0 in metric units]";
	say "[m0 in kg]";
	say "[m0 in g]";
	say "[m0 in kilograms]";
	
might produce: '2.04kg', '2.04kg', '2040g', '2.04 kilograms'. The text expansion '... in metric units' prints any value of any of these units in its most natural notation: 2.04kg is thought to be better than 2040g, but 981g would be better than 0.981kg. Or in the case of our variant spellings:

	say "[C in metric units]";
	say "[C in milliliters]";
	say "[C in millilitres]";

might produce '47 ml', '47 milliliters', '47 millilitres'. It's also worth remembering that any value can be rounded:

	say "[C to the nearest 5 ml]";

would produce '45 ml', for instance.

For detailed notes on each of the units, consult the Kinds index for any project using this extension.

There are three main restrictions. First, Inform can only represent numbers within a certain range. Each kind of value is set up on the assumption that writers will want it to model human-scale situations - length, for instance, varies from 1mm, the smallest conscious movement a human can make, up to 2150km or so, the length of a continent-spanning footpath. 'Approximate Metric Units' is an extension to help with real-world physics questions like how long a plate dropped off the roof takes to hit the ground, or when a rope will break, or how long a saucepan of water will take to boil. It won't be much use for celestial events like lightning strikes, where enormous energies are released for fleeting periods of time, or for tiny subatomic events.

Secondly, calculations are done with fixed-point arithmetic and will inevitably involve small rounding errors. Working out the same quantity by two different methods, which ought to have the same result according to physics, will often produce slightly different answers because these errors accumulate differently. 'Approximate Metric Units' aspires to help the writer to get physical answers which are about right, not to be a precision tool.

Thirdly, we haven't included every SI unit. There are hundreds of kinds of value which turn up in physics, and we only include the commonest 25 or so. The missing ones which have named SI units are:

	solid angle (measured in steradians), luminous flux (lux), electric capacitance (Farads), electric resistance (Ohms), electric conductance (Siemens), magnetic flux (Webers), magnetic field (Teslas), inductance (Henries), radioactivity (Becquerels), absorbed radioactive dose (Grays), equivalent radioactive dose (Sieverts), chemical quantity (mole), catalytic activity (katals).

As can be seen, we've missed out units for chemistry, electromagnetic effects beyond the basic ones, and radioactivity. It would be easy to add any of these which might be needed:

	Electric resistance is a kind of value.

	1 Ohm (in metric units, in Ohms, singular) or 2 Ohms (in metric units, in Ohms, plural) specifies an electric resistance scaled at 1000.

	Electric resistance times electric current specifies a voltage.

Similarly, there are many kinds of value which don't have named SI units, but where physicists write them down as compounds. These are also easy to add as needed:

	Angular momentum is a kind of value.
	
	1 Nms specifies an angular momentum scaled at 1000.
	
	Momentum times length specifies an angular momentum.

Besides angular momentum, 'Approximate Metric Units' also leaves out:

	volumetric flow (cu m/s), jerk (m/sss), snap (m/ssss), angular velocity (rad/s, though Inform would probably use degrees/s), torque (Nm), wavenumber (1/m), specific volume (cu m/kg), molar volume (cu m/mole), molar heat capacity (J/K/mol), molar energy (J/mol), specific energy (J/kg), energy density (J/cu m), surface tension (J/sq m), thermal conductivity (W/m/C), viscosity (sq m/s), conductivity (S/m), permittivity (F/m), permeability (H/m), electric field strength (V/m), magnetic field strength (A/m), resistivity (Ohm metre).

This extension is pretty faithful to SI conventions. It chooses degrees rather than radians for angle, and centigrade rather than Kelvin for temperature, because these are more useful for humans and easier to represent in text. But otherwise it's strictly metric, and does not define Imperial measures. See the example below for how to add these.

