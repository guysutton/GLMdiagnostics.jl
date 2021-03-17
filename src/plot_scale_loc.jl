# Write function to automate plotting of scale-location plot
# - Plots scale-location plot for assessing linear model fits

function plot_scale_loc(model)

    # Extract predicted values from model object
    pred = GLM.predict(model)

    # Extract residuals from model object
    res = GLM.residuals(model)

    # Calculate mean of residuals
    res_mean = StatsBase.mean(res)

    # Calculate length (n) of residuals vector
    n = length(res)

    # Calculate standardised residuals
    stdRes = (res - res_mean * ones(n)) / (Statistics.std(res))

    # Calculate square-root of standardised residuals
    sqrtStdRes = sqrt.(abs.(stdRes))

    # Create plot
    p = Gadfly.plot(x = pred,
                    y = sqrtStdRes,
                    Gadfly.layer(Gadfly.Geom.point),
                    Gadfly.layer(Gadfly.Geom.smooth(method = :loess,
                                                    smoothing = 0.9)),
                    # Change plot aesthetics
         Gadfly.Guide.title("Scale-Location"),
         Gadfly.Guide.xlabel("Fitted values",
                             orientation=:horizontal),
         Gadfly.Guide.ylabel("(|Standardized residuals|)"))

end