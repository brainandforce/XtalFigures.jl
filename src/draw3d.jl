"""
    Draw3D

Contains methods used for drawing objects in 3D plots.
"""
module Draw3D

using Xtal
import PlotlyJS

"""
    Draw3D.unitcell(
        b::BasisVectors{3};
        offset::AbstractVector{<:Real} = [0, 0, 0],
        basiscolor::Bool=true,
        kwargs...
    ) -> Vector{GenericTrace{Dict{Symbol,Any}}}

Draws the boundaries of a unit cell.

If `basiscolor` is `true`, the cell boundaries at the origin which point along the unit cell basis
vectors will be colored red, green, and blue for a, b, and c respectively.
"""
function unit_cell(
    basis::BasisVectors{3};
    offset::AbstractVector{<:Real} = [0, 0, 0],
    basiscolor::Bool=true,
    kwargs...
)
    # Draw the a, b, c axes in RGB if set
    colorlist = if basiscolor
        [RGB(1, 0, 0), RGB(0, 1, 0), RGB(0, 0, 1)]
    else
        [RGB(0, 0, 0) for n in 1:3]
    end
    # TODO: I can probably get this to return a single `GenericTrace{Dict{Symbol,Any}}`
    # Currently it returns a vector of them, but that seems to be unnecessary for plotting
    # Not sure if this severely impacts performance or anything but it would be neater
    return [
        PlotlyJS.scatter3d(
            x = [0, basis[n][1]] .+ offset[1],
            y = [0, basis[n][2]] .+ offset[2],
            z = [0, basis[n][3]] .+ offset[3],
            line_color = colorlist[n],
            showlegend = false,
            mode = "lines";
            kwargs...
        ) for n in 1:3
    ]
end

"""
    Draw3D.sphericalharmonic(
        components::SphericalComponents{Lmax};
        offset::AbstractVector{<:Real} = [0, 0, 0], 
        grit::Integer = 32,
        gradient::Bool=true,
        kwargs...
    )

Draws the surface corresponding to a linear combination of spherical harmonics.

If `gradient` is set to `true``, the spherical harmonics will be colored with a gradient that
depends on the value of `r`, with positive values in red, and negative values in blue. By default,
the gradient is disabled.

The default color scheme is `PlotlyJS.colors.thermometer`, but this may be modified by using the
`colorscale` keyword argument and providing a color scheme. (Relevant documentation: 
)
"""
function spherical_harmonic(
    components::SphericalComponents{Lmax};
    offset::AbstractVector{<:Real} = [0, 0, 0], 
    grit::Integer = 32,
    gradient::Bool=false,
    kwargs...
)
        # Convert back to Cartesian coordinates
    sph = Y_real(s; grit)
    cart = sph2cart.(abs.(sph))
    # Get all 3D components
    (x,y,z) = ([v[n] for v in cart] .+ offset[n] for n in 1:3)
    return PlotlyJS.surface(
        x=x, y=y, z=z,
        surfacecolor=(gradient ? r.(sph) : sign.(r.(sph))),
        cmid = 0,
        showscale = false,
        colorscale=PlotlyJS.colors.thermometer;
        kwargs...
    )
end

export unit_cell, spherical_harmonic

end
