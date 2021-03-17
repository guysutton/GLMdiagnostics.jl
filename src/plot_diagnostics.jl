# Write function to automate plotting combined diagnostics plots
# - Plots all three standard plots for assessing linear model fits

function plot_diagnostics(model)

    # Set default plot size
    Gadfly.set_default_plot_size(21Gadfly.cm, 8Gadfly.cm)

    # Make individual diagnostics plots
    # - These plots are the equivalent of calling plot(...) on a
    #   linear model (e.g. lm, ANOVA) in R.
    p1 = GLMdiagnostics.plot_qq(model)
    p2 = GLMdiagnostics.plot_fit_res(model)
    p3 = GLMdiagnostics.plot_scale_loc(model)

    # Plot all three plots in a single graph
    all_plots = Gadfly.hstack(p1, p2, p3)

end