# nb

A new, exciting programming language powered by n-bodies simulations.

## Semantics

nb is an object-oriented programming language where each object
is a planetary body. The virtual machine runs an n-body simulation
on the objects, and for each collision at timestep `t`, the virtual
machine emits the ascii character `t % 256`.


## Syntax

Each line of an nb program must be five space-separated values `px py vx vy m` representing a planetary body,
where `px` and `py` specifies the initial position, `vx` and `vy` specify the initial velocity, and `m` is the mass.

## Usage

    $ ./bin/nb-compile foo.nb > foo.nbc
    $ ./foo.nbc
