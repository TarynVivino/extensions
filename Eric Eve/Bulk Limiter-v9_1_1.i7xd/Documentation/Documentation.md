
This extension adds a bulk property to all things, and a bulk capacity property to all containers and people. The implementation is deliberately quite basic, in order to provide an
extension with a relatively small footprint to deal with simple cases such as preventing boulders being put in purses or carried. In order to keep things simple this extension deliberately doesn't deal with bulk capacities of supporters, or weights, or take into account the maximum dimension of long, thin objects or the like. It is intended to provide a simple solution to a common problem, not a full simulation.

The default bulk of a thing is 1. The default bulk capacity of a container is 10.  The default bulk capacity of a person is 100.

The extension performs a check on attempting to insert something into a container that the total bulk of the objects inside the container does not exceed its capacity. If an actor (not necessarily the player) attempts to insert an object whose bulk is larger than the bulk capacity of the container or to take an object whose bulk is larger than their own bulk capacity, the attempt will fail with a message saying that the object is too large for the container. Otherwise, if we attempt to insert an object into a container when there's not enough room left for it or take an object we can no longer carry, we'll get a message saying that there's not enough room left.

Note that this extension complements rather than replaces Inform's built in capacity check for containers.

With thanks to Kevin Riggle whose suggestions have been incorporated into this extension.


