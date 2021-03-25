# Test GLMdiagnostics.jl 
# - Use the built-in `Salamanders dataset` from R's glmmTMB package 

# Load required packages 
using RCall
using Distributions
using Random
using DataFrames
using StatsBase
using GLM
using Gadfly
using Statistics
using Compose
using GLMdiagnostics

# Load in the dataset 
salamander = rcopy(R"glmmTMB::Salamanders")

# Check the structure of the dataset
first(salamander, 6)  

# Run Poisson GLM
m1 = fit(GeneralizedLinearModel,
            @formula(count ~ 1 + mined + spp),
            salamander,
            Poisson(),
            GLM.LogLink())

# Test functions against simple Poisson GLM (2 categorical variables)
GLMdiagnostics.calc_dev_resids(model = m1, df = salamander, resp_var = "count")
GLMdiagnostics.plot_fit_res(model = m1, df = salamander, resp_var = "count")
GLMdiagnostics.plot_qq(model = m1, df = salamander, resp_var = "count")
GLMdiagnostics.plot_scale_loc(model = m1, df = salamander, resp_var = "count")