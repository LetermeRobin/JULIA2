using Pkg
cd(joinpath(@__DIR__, ".."))
Pkg.activate(".")
Pkg.instantiate()

BROWNFIELD = false
include("run_model.jl")
