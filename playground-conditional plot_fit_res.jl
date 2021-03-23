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

# Define function
function plot_fit_res(;model, df)

    # Extract fitted/predicted values from model object
    pred = GLM.predict(model)

    # Extract vector containing response variable 
    response = df.y

    # Calculate deviance residuals 
    devResids = sign.(response .- pred) .* sqrt.(GLM.devresid.(Distributions.Poisson(), response, pred))

    # Create plot
    p = Gadfly.plot(
                # Add points layer
                Gadfly.layer(x = pred,
                             y = devResids,
                             Gadfly.Geom.point),
                # Add horizontal y = 0 line
                Gadfly.layer(yintercept = [0],
                             Gadfly.Geom.hline),
                # Change plot aesthetics
                Gadfly.Guide.xlabel("Fitted values", orientation=:horizontal),
                Gadfly.Guide.ylabel("Residuals"),
                Gadfly.Guide.title("Residuals vs Fitted"))
end

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

df = hcat(y, x)
df = DataFrame(df)
colnames = ["y","x"]
rename!(df, Symbol.(colnames))

# Run model
modAov = lm(@formula(y ~ 1 + x), df)

# Plot diagnostics
plot_fit_res(model = modAov, df = df)

##################
# TEST POISSON GLM
##################

# Set reproducible seed
Random.seed!(123)

# Simulate n = 100 data points from a Poisson distribution
y = rand(Poisson(7), 100)

# Assign grouping variables (5 groups of 20)
x = repeat([1, 2, 3, 4, 5],
            inner = 20,
            outer = 1)

df = hcat(y, x)
df = DataFrame(df)
colnames = ["y","x"]
rename!(df, Symbol.(colnames))

# Run model
modPoisson = fit(GeneralizedLinearModel,
           @formula(y ~ 1 + x),
           df,
           Poisson(),
           GLM.LogLink())

plot_fit_res(model = modPoisson, df = df)


