# SpectroscopicUnits.jl

This small package was created to convert easily between spectroscopic units. It exports a single function `convert_unit` that wraps `uconvert` from Unitful and uses the same calling convention. Since spectroscopic units such as Hz, eV, μm or nm have not necessarily the same dimensions, we could not just extend `uconvert` which requires the same dimensions.

## Example
As an example, let's convert from a wavelength in nm to a frequency in Hz.
```julia
julia> convert_unit(u"Hz", 600.0u"nm")
4.996540966666666e14 Hz
```
Just as in `Unitful.uconvert`, the first argument is a unit and the second is a quantity of type `Unitful.Quantity{T,D,U}`.

## Supported units
For now, the following units are supported: Hz, radHz, eV, and all length units. Everything can be converted into everything.

To make writing units slightly easier, we created aliases for the most common units:

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
To extend the units in our own package, two methods should be defined which convert your unit to `Unitful.LengthUnits` and a length back to you unit.
I made the choice to convert everything to lenght units.  everything 
