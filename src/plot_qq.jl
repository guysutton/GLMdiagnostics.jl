# Write function to automate plotting qqplot
# - Plots standard quantile-quantile plot for assessing linear model fits

function plot_qq(model)

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

    # Define quantiles
    qx = Distributions.quantile.(Distributions.Normal(),
                                    range(0.5,
                                    stop = (n - 0.5),
                                    length = (n)) / (n + 1))

    # Create plot
    p = Gadfly.plot(
                    # Add points layer
                    Gadfly.layer(x = qx,
                                 y = sort(stdRes),
                                 Gadfly.Geom.point),
                    # Add 1:1 line
                    Gadfly.layer(x = [-3,3],
                                 y = [-3,3],
                                 Gadfly.Geom.line,
                                 Gadfly.style(line_style = [:dot])),
                    # Change plot aesthetics
                    Gadfly.Guide.title("Normal Q-Q plot"),
                    Gadfly.Guide.xlabel("Theoretical Quantiles"),
                    Gadfly.Guide.ylabel("Standardized residuals"))

end
