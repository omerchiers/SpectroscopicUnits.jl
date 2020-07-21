# SpectroscopicUnits.jl

This small package was created to convert easily between units commonly used to describe the energy, frequency or wavelength of the electromagnetic spectrum. It exports a single function `convert_unit` that wraps `uconvert` from [Unitful.jl](https://github.com/PainterQubits/Unitful.jl) and uses the same calling convention. Since spectroscopic units such as Hz, eV, μm or nm have not necessarily the same dimensions, we could not just extend `uconvert` which requires the same dimensions.

## Example
As an example, let's convert from a wavelength in nm to a frequency in Hz.
```julia
julia> convert_unit(u"Hz", 600.0u"nm")
4.996540966666666e14 Hz
```
Just as in `Unitful.uconvert`, the first argument is a unit and the second is a quantity of type `Unitful.Quantity{T,D,U}`.

## Supported units
For now, the following units are supported: Hz, radHz, eV (and most energy units), and all length units. Everything can be converted into everything.

To make writing units slightly easier, we created aliases for the most common ones:

```julia
const Hz = u"s^-1"
const radHz = u"rad*s^-1"
const eV = u"eV"
const m = u"m"
const cm = u"cm"
const mm = u"mm"
const μm = u"μm"
const nm = u"nm"
```
which are all exported.

## Interface
To extend the conversion for units of your own package, two methods should be defined which convert your unit to `Unitful.LengthUnits` and a length back to your unit.
We show here the example for Hz:

```julia
function convert_unit(unit::Unitful.LengthUnits, quantity::Quantity{T,D,U}) where {T<:Real,D, U<:Unitful.FrequencyUnits}
    return uconvert(unit, c_0 / quantity)
end

convert_unit(unit::U, quantity::Unitful.Length) where {U <: Unitful.FrequencyUnits} = uconvert(unit, c_0 / (quantity |> m))
```
where `c_0` is the speed of light in vacuum obtained from [PhysicalConstants.jl](https://github.com/JuliaPhysics/PhysicalConstants.jl). Converting everything between lenght units allows us to convert between all units. The choice of length units is quite arbitrary and we could have taken any other unit.

## **Important note**
In this package, the unit `radHz` is understood as the unit of pulsation ``ω = 2πν`` where ``ν`` is the frequency in `Hz`. Hence, when we convert a frequency in `Hz` to  `radHz`, the frequency is then multiplied by `2π`. This is different from the convention used in Unitful.jl where `1 Hz = 1 radHz`.
