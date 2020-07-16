

"""
This package implements basic unit conversions between units commonly used in spectroscopy which are not of the same dimensions,
such as Hz and m. It exports the function `convert_unit` which follows the same notation as uconvert from Unitful.
In the future it would be worthwhile to see if units and their conversion could be enforced in the rest of my packages.
"""
module SpectroscopicUnits

using Reexport
@reexport using Unitful
import PhysicalConstants.CODATA2018: c_0, ħ, h

export convert_unit


# Constants for the most commonly used units
export Hz, radHz, eV, m, cm, mm ,μm, nm

const Hz = u"s^-1"
const radHz = u"rad*s^-1"
const eV = u"eV"
const m = u"m"
const cm = u"cm"
const mm = u"mm"
const μm = u"μm"
const nm = u"nm"

function convert_unit(unit::Unitful.LengthUnits, quantity::Quantity{T,D,U}) where {T<:Real,D, U<:Unitful.FrequencyUnits}
    return uconvert(unit, c_0 / quantity)
end

function convert_unit(unit::Unitful.LengthUnits, quantity::Quantity{T,D,typeof(unit(1.0u"rad/s"))}) where {T<:Real,D}
    return uconvert(unit, 2.0 * pi * c_0 / quantity * 1.0 * u"rad")
end

function convert_unit(unit::Unitful.LengthUnits, quantity::Quantity{T,D,typeof(unit(1.0u"eV"))}) where {U <: Unitful.FrequencyUnits, T<:Real,D}
    energy = uconvert(u"J", quantity)
    freq = uconvert(Hz, energy / h)
    return convert_unit(unit, freq)
end

function convert_unit(unit::Unitful.LengthUnits, quantity::Quantity{T,D,typeof(unit(1.0 * cm^-1))}) where {T<:Real,D}
    return uconvert(unit, 1.0/quantity)
end


convert_unit(unit::U, quantity::Unitful.Length) where {U <: Unitful.FrequencyUnits} = uconvert(unit, c_0 / (quantity |> m))
convert_unit(unit::typeof(radHz), quantity::Unitful.Length) = unconvert(unit, 2.0 * pi * c_0 / (quantity |> m))

function convert_unit(unit::typeof(u"eV"), quantity::Unitful.Length)
    freq = uconvert(Hz, c_0 / quantity )
    energy = uconvert(u"J", h * freq)
    return uconvert(unit, energy)
end

function convert_unit(unit::typeof(cm^-1), quantity::Unitful.Length)
    return uconvert(unit, 1.0/quantity)
end

function convert_unit(unit::U, quantity::Quantity{T,D,V}) where {T<:Real,D,U,V}
    temp = convert_unit(m, quantity)
    return convert_unit(unit, temp)
end

convert_unit(unit::U, quantity::Quantity{T,D,U}) where {T<:Real,D,U,V} = quantity

end
