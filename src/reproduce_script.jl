using Pkg
cd(joinpath(@__DIR__, ".."))
Pkg.activate(".")
Pkg.instantiate()

BROWNFIELD = false
include("graph_construction.jl")
include("graph_plotting.jl")
include("run_model.jl")
