function Base.show(io::IO, ::MIME"text/plain", v::Spherical)
    println(io, typeof(v), ":")
    println(io, " r: ", r(v))
    # TODO: do I want to have the factor of π included?
    println(io, " θ: ", theta(v)/π, "π")
    print(io, " ϕ: ", phi(v)/π, "π")
end

function Base.show(io::IO, ::MIME"text/plain", s::SphericalComponents{Lmax}) where Lmax
    print(io, "SphericalComponents{$Lmax}", ":\n", " "^13)
    for m = -Lmax:Lmax
        print(io, rpad("m = $m", 12))
    end
    for l in 0:Lmax
        print(io, "\n", rpad("l = $l:", 8))
        for m = -Lmax:Lmax
            if abs(m) <= l
                print(io, lpad(@sprintf("%6f", s[l,m]), 12))
            else
                print(io, " "^12)
            end
        end
    end
end
