module XtalFigures

using LinearAlgebra
using StaticArrays
using Printf
using ComputedFieldTypes
using Colors
# Documentation can be found at https://plotly.com/julia/
import PlotlyJS
# TODO: ensure that this works correctly; Xtal isn't in the registry yet
using Xtal

# Coordinate system types
include("coordinates.jl")
export AbstractPolar, Polar, Spherical
export r, theta, phi, cart2sph, sph2cart, sphere
# Polynomials that come up in spherical harmonic definitions
include("polynomials.jl")
# Tools for generating spherical harmonics and linear combinations
include("sphericalharmonics.jl")
export SphericalComponents
export Y_real
# Tools for plotting with PlotlyJS
include("draw2d.jl")
include("draw3d.jl")
export Draw3D
# Show methods for custom types
include("show.jl")

end # module
