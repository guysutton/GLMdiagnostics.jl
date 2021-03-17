##############################################
# - Write tests for plot_scale_loc
##############################################

# Import dependencies required
using GLMdiagnostics
using Test
using Distributions
using Random
using DataFrames
using StatsBase
using GLM
using Gadfly
using Statistics
using Compose

# Import simulated data and linear model to test functions
include("test_simulated_model.jl")

@testset "plot_scale_loc" begin

    # Test #1
    # - Test that object created by function is of type 'Plot'
    @test   typeof(plot_scale_loc(modAov)) == Plot

end # End of testing for plot_scale_loc function
