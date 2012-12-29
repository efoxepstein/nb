# nb

A new, exciting programming language powered by n-bodies simulations.
This joke language is a submission to PLT games.

## Semantics

nb is an object-oriented programming language where each object
is a planetary body. The virtual machine runs an n-body simulation
on the objects, and for each collision at timestep `t`, the virtual
machine emits the ascii character `t % 256`.

A collision is defined by two bodies being within distance 1 on any timestep.
If this occurs, after outputting the character, the two bodies are combined
by averaging their positions, determining the resulting velocity, and combining the masses,
as in a rigid, sticky collision.

The first tick is 1. The universal gravitational constant is 1.

### Unusual Semantics

The virtual machine is tick-based. This means that any collisions that occur between ticks are NOT COUNTED. This means that objects can teleport through each other.

## Syntax

Each line of an nb program must be five space-separated values `px py vx vy m` representing a planetary body,
where `px` and `py` specifies the initial position, `vx` and `vy` specify the initial velocity, and `m` is the mass.

## Usage

    $ cat program.nb | ruby nb.rb

## Hello World

Okay, "hello world" is too complex. Let's do "hi":

    $ echo -e "55.7 0 0 0 1\n0 0 0 0 1\n10000 0 0 0 1\n10059.4 0 0 0 1" | ruby nb.rb 
