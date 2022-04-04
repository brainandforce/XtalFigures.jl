function PlotlyJS.surface(s::SphericalComponents; grit::Integer = 32, kwargs...)
    # Convert back to Cartesian coordinates
    sph = Y_real(s; grit)
    cart = sph2cart.(abs.(sph))
    # Get all 3D components
    (x,y,z) = ([v[n] for v in cart] for n in 1:3)
    return surface(x=x, y=y, z=z, 
        surfacecolor=r.(sph),
        colorscale=colors.thermometer;
        kwargs...)
end
