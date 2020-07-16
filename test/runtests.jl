using SpectroscopicUnits
using Unitful
using Test

@testset "SpectroscopicUnits.jl" begin
    @testset "convert Hz to length" begin
        @test ustrip(convert_unit(m, 1e15Hz)) ≈ 2.9979e-7 atol = 1e-11
        @test ustrip(convert_unit(cm, 1e15Hz)) ≈ 2.9979e-5 atol = 1e-9
        @test ustrip(convert_unit(mm, 1e15Hz)) ≈ 0.00029979 atol = 1e-8
        @test ustrip(convert_unit(μm, 1e15Hz)) ≈ 0.29979 atol = 1e-5
        @test ustrip(convert_unit(nm, 1e15Hz)) ≈ 299.79246 atol = 1e-5
    end

    @testset "convert radHz to length" begin
        @test ustrip(convert_unit(m, 2.0*pi*1e15radHz)) ≈ 2.9979e-7 atol = 1e-11
        @test ustrip(convert_unit(cm, 2.0*pi*1e15radHz)) ≈ 2.9979e-5 atol = 1e-9
        @test ustrip(convert_unit(mm, 2.0*pi*1e15radHz)) ≈ 0.00029979 atol = 1e-8
        @test ustrip(convert_unit(μm, 2.0*pi*1e15radHz)) ≈ 0.29979 atol = 1e-5
        @test ustrip(convert_unit(nm, 2.0*pi*1e15radHz)) ≈ 299.79246 atol = 1e-5
    end

    @testset "convert eV to length" begin
        @test ustrip(convert_unit(nm, 3.2eV)) ≈ 387.451 atol = 1e-3
        @test ustrip(convert_unit(μm, 3.2eV)) ≈ 0.38745 atol = 1e-5
    end
end
