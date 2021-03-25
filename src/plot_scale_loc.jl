# Write function to automate plotting of scale-location plot
# - Plots scale-location plot for assessing linear model fits

function plot_scale_loc(;model, df, resp_var)

    # Extract predicted values from model object
    pred = GLM.predict(model)

    # Calculate deviance residuals 
    devResids = GLMdiagnostics.calc_dev_resids(model = model, 
                                               df = df, 
                                               resp_var = resp_var)

    # Calculate length (n) of residuals vector
    n = Base.length.(devResids)

    # Create plot
    p = Gadfly.plot(x = pred,
                    y = devResids,
                    Gadfly.layer(Gadfly.Geom.point),
                    Gadfly.layer(Gadfly.Geom.smooth(method = :loess,
                                                    smoothing = 0.9)),
                    # Change plot aesthetics
         Gadfly.Guide.title("Scale-Location"),
         Gadfly.Guide.xlabel("Fitted values",
                             orientation=:horizontal),
         Gadfly.Guide.ylabel("Deviance residuals"))
end