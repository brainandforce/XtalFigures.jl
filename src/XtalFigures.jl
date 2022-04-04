module XtalFigures

using LinearAlgebra
using StaticArrays
using ComputedFieldTypes
# Documentation can be found at https://plotly.com/julia/
using PlotlyJS

# Coordinate system types
include("coordinates.jl")
export AbstractPolar, Polar, Spherical
export r, theta, phi, cart2sph, sph2cart, sphere
# Polynomials that come up in spherical harmonic definitions
include("polynomials.jl")
# Tools for generating spherical harmonics and linear combinations
include("sphericalharmonics.jl")
export SphericalComponents
export Y_real, Y_real_lcomb
# Show methods for custom types
include("show.jl")

end # module
