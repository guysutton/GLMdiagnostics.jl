module GLMdiagnostics

import
    GLM,
    Gadfly,
    Distributions,
    Random,
    StatsModels,
    StatsBase,
    Statistics

# Separate .jl files for each function (have to manually add file, otherwise error)

# Function #1: Calculate deviance residuals for fitted GLM object
include("calc_dev_resids.jl")
export calc_dev_resids

# Function #2: Plot quantile-quantile plot (qqplot)
include("plot_qq.jl")
export plot_qq

# Function #3: Plot fitted versus residuals plot
include("plot_fit_res.jl")
export plot_fit_res

# Function #4: Plot scale-location plot
include("plot_scale_loc.jl")
export plot_scale_loc

# Function #5: Plot all diagnostics plots together
include("plot_diagnostics.jl")
export plot_diagnostics

end
