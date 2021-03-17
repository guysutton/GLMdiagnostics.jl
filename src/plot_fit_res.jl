# Write function to automate plotting fitted versus residuals plot
# - Plots standard fitted versus residuals plot for assessing linear model fits

function plot_fit_res(model)

    # Extract fitted/predicted values from model object
    pred = GLM.predict(model)

    # Extract residuals from model object
    res = GLM.residuals(model)

    # Create plot
    p = Gadfly.plot(
                # Add points layer
                Gadfly.layer(x = pred,
                             y = res,
                             Gadfly.Geom.point),
                # Add horizontal y = 0 line
                Gadfly.layer(yintercept = [0],
                             Gadfly.Geom.hline),
                # Change plot aesthetics
                Gadfly.Guide.xlabel("Fitted values", orientation=:horizontal),
                Gadfly.Guide.ylabel("Residuals"),
                Gadfly.Guide.title("Residuals vs Fitted"))
end
