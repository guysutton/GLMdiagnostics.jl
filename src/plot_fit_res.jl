# Write function to automate plotting fitted versus residuals plot
# - Plots standard fitted versus residuals plot for assessing linear model fits

function plot_fit_res(;model, df, resp_var)

        # Extract fitted/predicted values from model object
        pred = GLM.predict(model)

        # Calculate deviance residuals 
        devResids = GLMdiagnostics.calc_dev_resids(model = model, 
                                                   df = df, 
                                                   resp_var = resp_var)
    
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
                    Gadfly.Guide.ylabel("Deviance residuals"),
                    Gadfly.Guide.title("Residuals vs Fitted"))
end

