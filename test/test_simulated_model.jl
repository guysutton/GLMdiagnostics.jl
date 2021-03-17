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
# - Create simulated data to test functions
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

df = hcat(y, x)
#df = convert(DataFrame, df)
df = DataFrame(df)
colnames = ["y","x"]
rename!(df, Symbol.(colnames))

##########################################
# - Run linear model (one-way ANOVA)
##########################################

# Run model
modAov = lm(@formula(y ~ 1 + x), df)

# Make qqplot for ANOVA model
anova_qqplot = plot_qq(modAov)