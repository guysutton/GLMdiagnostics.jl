using SafeTestsets

##############################################
# - Run unit tests
##############################################

# Each function has its own .jl file containing a SafeTestset
# - Using the 'SafeTestsets' approach requires each test set to run as a
#   stand alone file (e.g. contains its own Using ... packages code for each function).
# - SafeTestsets runs each test set in its own clean environment - no leakage between
#   environments and test sets.

# (1) Test 'plot_qq' function
@safetestset "test plot_qq" begin include("test_plot_qq.jl") end

# (2) Test 'plot_fit_res' function
@safetestset "test plot_fit_res" begin include("test_plot_fit_res.jl") end

# (3) Test 'plot_scale_loc' function
@safetestset "test plot_scale_loc" begin include("test_plot_scale_loc.jl") end
