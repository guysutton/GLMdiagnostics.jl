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

###########################################
# - Create simulated data to test functions (ANOVA)
###########################################

# Set reproducible seed
Random.seed!(123)

# Simulate data from a Normal distribution
d = Normal(1, 2)
y = rand(d, 100)

# Assign grouping variables (5 groups of 20)
x = repeat([1, 2, 3, 4, 5],
            inner = 20,
            outer = 1)

# Create dataframe of response and predictor variables 
DataFrame(; y, x)

##########################################
# - Run linear model (one-way ANOVA)
##########################################

# Run model
modAov = lm(@formula(y ~ 1 + x), df)
