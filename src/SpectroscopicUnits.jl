

"""
This package implements basic unit conversions between units commonly used in spectroscopy which are not of the same dimensions,
such as Hz and m. It exports the function `convert_unit` which follows the same convention as uconvert from Unitful.
"""
module SpectroscopicUnits

using Reexport
@reexport using Unitful
import PhysicalConstants.CODATA2018: c_0, ħ, h

export convert_unit


# Constants for the most commonly used units
export Hz, radHz, eV, m, cm, mm ,μm, nm

const Hz = u"Hz"
const radHz = u"rad*Hz"
const eV = u"eV"
const m = u"m"
const cm = u"cm"
const mm = u"mm"
const μm = u"μm"
const nm = u"nm"

function convert_unit(unit::Unitful.LengthUnits, quantity::Quantity{T,D,U}) where {T<:Real,D, U<:Unitful.FrequencyUnits}
    return uconvert(unit, c_0 / quantity)
end

function convert_unit(unit::Unitful.LengthUnits, quantity::Quantity{T,D,typeof(u"rad*Hz")}) where {T<:Real,D}
    return uconvert(unit, 2.0 * pi * c_0 / quantity)
end

function convert_unit(unit::Unitful.LengthUnits, quantity::Quantity{T,D,U}) where {U <: Unitful.EnergyUnits, T<:Real,D}
    energy = uconvert(u"J", quantity)
    freq = uconvert(Hz, energy / h)
    return convert_unit(unit, freq)
end

function convert_unit(unit::Unitful.LengthUnits, quantity::Quantity{T,D,typeof(cm^-1)}) where {T<:Real,D}
    return uconvert(unit, 1.0/quantity)
end


convert_unit(unit::U, quantity::Unitful.Length) where {U <: Unitful.FrequencyUnits} = uconvert(unit, c_0 / (quantity |> m))
convert_unit(unit::typeof(radHz), quantity::Unitful.Length) = uconvert(unit, 2.0 * pi * c_0 / (quantity |> m))

function convert_unit(unit::Unitful.EnergyUnits, quantity::Unitful.Length)
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

convert_unit(unit::U, quantity::Quantity{T,D,U}) where {T<:Real,D,U} = quantity

end
