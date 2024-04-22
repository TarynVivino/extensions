Version 9.1.1 of Bulk Limiter by Eric Eve begins here.

"Containers and actors that limit their contents by bulk"

A container has a number called bulk capacity. 
The bulk capacity of a container is usually 10.

A person has a number called bulk capacity.
The bulk capacity of a person is usually 100.

A thing has a number called bulk. 
The bulk of a thing is usually 1.

Check an actor inserting into when the second noun provides the property bulk capacity (this is the bulk test rule):   
   if the bulk of the noun is greater than the bulk capacity of the second noun,  
      say "[The noun] [are] too big to fit in [the second noun]." (A) instead;
   if the bulk of the noun is greater than the free capacity of the second noun,  
      say "[There] [are not] enough room left in [the second noun] for [the noun]."  (B) instead;
  
Check an actor taking when the actor provides the property bulk capacity 
   (this is the person bulk test rule):
   if the bulk of the noun is greater than the bulk capacity of the actor, 
      say "[The noun] [are] too big for [if the actor is the player][us][otherwise][the actor][end if] to pick up." (A) instead;
   if the bulk of the noun is greater than the free capacity of the actor,
      say "[If the player is the actor][We] [don't][otherwise][The actor] [don't][end if] have enough room left to carry [the noun]." (B) instead;
 
To decide what number is the free capacity of (targetbox - a container):
  let sum be the total bulk of the things in the targetbox;
  now sum is the bulk capacity of the targetbox minus sum;
  decide on the sum.

To decide what number is the free capacity of (targetperson - a person):  
   let sum be the total bulk of the things carried by targetperson;  
   now sum is the bulk capacity of the targetperson minus sum;  
   decide on the sum.


Bulk Limiter ends here.
