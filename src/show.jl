function Base.show(io::IO, ::MIME"text/plain", v::Spherical)
    println(io, typeof(v), ":")
    println(io, " r: ", r(v))
    # TODO: do I want to have the factor of π included?
    println(io, " θ: ", theta(v)/π, "π")
    print(io, " ϕ: ", phi(v)/π, "π")
end