# Write function to automate plotting qqplot
# - Plots standard quantile-quantile plot for assessing linear model fits

function plot_qq(;model, df, resp_var)

    # Extract predicted values from model object
    pred = GLM.predict(model)

    # Calculate deviance residuals 
    devResids = GLMdiagnostics.calc_dev_resids(model = model, df = df, resp_var = resp_var)

    # Calculate length (n) of residuals vector
    n = Base.length.(devResids)

    # Define quantiles
    qx = Distributions.quantile.(Distributions.Normal(),
                                    Base.range(0.5,
                                    stop = (n - 0.5),
                                    length = (n)) / (n + 1))

    # Create plot
    p = Gadfly.plot(
                    # Add points layer
                    Gadfly.layer(x = qx,
                                 y = sort(devResids),
                                 Gadfly.Geom.point),
                    # Add 1:1 line
                    Gadfly.layer(x = [-3,3],
                                 y = [-3,3],
                                 Gadfly.Geom.line,
                                 Gadfly.style(line_style = [:dot])),
                    # Change plot aesthetics
                    Gadfly.Guide.title("Normal Q-Q plot"),
                    Gadfly.Guide.xlabel("Theoretical Quantiles"),
                    Gadfly.Guide.ylabel("Deviance residuals"))
end
