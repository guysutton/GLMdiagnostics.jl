using Test
using Distributions
using Random
using DataFrames
using StatsBase
using GLM
using Gadfly
using Statistics
using Compose
using GLMdiagnostics

##################
# - TEST POISSON GLM
##################

# Set reproducible seed
Random.seed!(123)

# Simulate n = 100 data points from a Poisson distribution (lambda = 7)
y = rand(Poisson(7), 100)

# Assign grouping variables (5 groups of 20)
x = repeat([1, 2, 3, 4, 5],
            inner = 20,
            outer = 1)

df = DataFrame(; y, x)

# Run model
modPoisson = fit(GeneralizedLinearModel,
                    @formula(y ~ 1 + x),
                    df,
                    Poisson(),
                    GLM.LogLink())

# Plot diagnostics 
GLMdiagnostics.calc_dev_resids(model = modPoisson, df = df, resp_var = "y")
GLMdiagnostics.plot_fit_res(model = modPoisson, df = df, resp_var = "y")
GLMdiagnostics.plot_qq(model = modPoisson, df = df, resp_var = "y")
GLMdiagnostics.plot_scale_loc(model = modPoisson, df = df, resp_var = "y")


devResids = GLMdiagnostics.calc_dev_resids(model = modPoisson,  df = df, resp_var = "y")
n = Base.length.(devResids)
n = Array(1:100)
qx = Distributions.quantile.(Distributions.Normal(), 
                             Base.range(0.5, 
                             stop = (n .- 0.5), length = (n)) ./ (n .+ 1))









 # Extract fitted/predicted values from model object
 pred = GLM.predict(modPoisson)

 # Extract vector containing response variable 
 response_y = df[!, :y]























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
modAov = fit(LinearModel,
                @formula(y ~ 1 + x),
                df)

                
# Plot diagnostics
plot_fit_res(model = modAov, df = df)
















# Define function to calculate deviance residuals 
function calcDevResids(;model, df)
    
    ###################################################
    # Section #1: Extract response vector and model residuals 
    ###################################################

    # Extract fitted/predicted values from model object
    pred = GLM.predict(model)

    # Extract vector containing response variable 
    response_y = df.y

    ###################################################
    # Section #2: Calculate deviance residuals
    #             - requires conditional statements to 
    #               loop through different data distributions
    ###################################################

    # Extract statistical distribution specified in model 
    distType = typeof(model).parameters[1].parameters[1].parameters[2]

    # Use if-elseif-else statements to calculate deviance residuals depending
    # on which errors were specified during model specification 

        # If model was specified with Poisson errors
        if distType <: Poisson
            sign.(response_y .- pred) .* sqrt.(GLM.devresid.(Distributions.Poisson(), response_y, pred))

        # If model was specified with negative binomial errors
        elseif distType <: NegativeBinomial
            sign.(response_y .- pred) .* sqrt.(GLM.devresid.(Distributions.NegativeBinomial(), response_y, pred))
        
        # If model was specified with Gamma errors
        elseif distType <: Gamma
            sign.(response_y .- pred) .* sqrt.(GLM.devresid.(Distributions.Gamma(), response_y, pred))
        
        # If model was specified with Bernoulli errors 
        elseif distType <: Bernoulli
            sign.(response_y .- pred) .* sqrt.(GLM.devresid.(Distributions.Bernoulli(), response_y, pred))
        
        # If model was specified with Binomial errors 
        elseif distType <: Binomial
            sign.(response_y .- pred) .* sqrt.(GLM.devresid.(Distributions.Binomial(), response_y, pred))

        # If model was specified with unsupported error distribution (e.g. tweedie)
        else 
            println("ERROR: Unsupported error distribution specified. Please refer to GLM.jl documentation for supported error distributions.")
        
        end 
end

# Define function
# Use ";x, y, z) to define keyword arguments
function plot_fit_res(;model, df)

    ###################################################
    # Section #1: Extract response vector and model residuals 
    ###################################################

    # Extract fitted/predicted values from model object
    pred = GLM.predict(model)

    # Extract vector containing response variable 
    response_y = df.y

    ###################################################
    # Section #3: Create plot
    ###################################################

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
