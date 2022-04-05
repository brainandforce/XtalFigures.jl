"""
    PlotlyJS.surface(s::SphericalComponents; grit::Integer = 32, gradient::Bool=true, kwargs...)

Generates a plottable surface from linear combinations of spherical harmonics.

If `gradient` is `true`, the colors will be given as a gradient of the value of `r` at every angle.
If `false`, the colors will only correspond to the positive and negative values of `r`. By default,
the `thermometer` color scheme from `PlotlyJS.colors` is used, which represents positive values in 
red and negative values in blue. This may be overridden by setting `colorscale`.
"""
function PlotlyJS.surface(
    s::SphericalComponents; 
    grit::Integer = 32,
    gradient::Bool=true,
    kwargs...
)
    # Convert back to Cartesian coordinates
    sph = Y_real(s; grit)
    cart = sph2cart.(abs.(sph))
    # Get all 3D components
    (x,y,z) = ([v[n] for v in cart] for n in 1:3)
    return PlotlyJS.surface(
        x=x, y=y, z=z,
        surfacecolor=(gradient ? r.(sph) : sign.(r.(sph))),
        cmid=0,
        colorscale=PlotlyJS.colors.thermometer;
        kwargs...
    )
end

#=
function PlotlyJS.scatter3d(positions::Vector{AtomPosition{3}}; kwargs...)
    
    return scatter3d(

        kwargs...
    )
end
=#

"""
    PlotlyJS.scatter3d(basis::BasisVectors{3}; basiscolor=true, kwargs...)

Plots the basis vectors of a crystal as lines on a scatter plot. If `basiscolor` is set to true,
the vectors a, b, and c will be colored red, green, and blue respectively.
"""
function PlotlyJS.scatter3d(
    basis::BasisVectors{3};
    basiscolor::Bool=true,
    kwargs...
)
    # Draw the a, b, c axes in RGB if set
    colorlist = if basiscolor
        [RGB(1, 0, 0), RGB(0, 1, 0), RGB(0, 0, 1)]
    else
        [RGB(0, 0, 0) for n in 1:3]
    end
    return [
        PlotlyJS.scatter3d(
            x = [0, basis[n][1]],
            y = [0, basis[n][2]],
            z = [0, basis[n][3]],
            line_color = colorlist[n],
            showlegend = false,
            mode = "lines";
            kwargs...
        ) for n in 1:3
    ]
end
