module XtalFigures

using LinearAlgebra
using StaticArrays
using Printf
using ComputedFieldTypes
# Documentation can be found at https://plotly.com/julia/
import PlotlyJS
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
export Draw2D
include("draw3d.jl")
export Draw3D
# Show methods for custom types
include("show.jl")

end # module
