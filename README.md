FreeBodyDiagram
===============

Software for computing mechanical forces and moments with free body diagrams.

this is my attempt in creating (it's a work in progress with long big holdups :) ) software for calculating reaction forces on a mechanical construction.

This is in no way an attempt to make FEM modelling software, but to calculate basic reaction forces for the engineer.

An engineer should
- make "free bodies" with points
- attach Forces and Moments to those points
- define interfaces with other "free bodies"

All those Forces and Moments should result in 1 Forcervector and 1 Momentvector in 1 point.
That point can then be used in another Free Body Diagram.

At each level the software should calculate and solve the 6 equations of mechanical systems
- Sum of all X-forces
- Sum of all Y-forces
- Sum of all Z-forces
- Sum of all moments around X-axis
- Sum of all moments around Y-axis
- Sum of all moments around Z-axis

In the end the software should generate some SVG files where forces and points are shown for documenting purposes.
