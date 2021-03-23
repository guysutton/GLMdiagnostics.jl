# test.jl

t = Template(;
    user = "guysutton",
    authors = ["Guy F. Sutton"],
    dir = "C:/Users/s1900332/.julia/dev/",
    julia = v"1.0.0",
    plugins=[
        License(; name="MPL"),
        Git(; manifest=true, ssh=true),
        GitHubActions(; x86=true),
        Codecov(),
        Documenter{GitHubActions}(),
        Develop(),
    ],
)

generate("GLMdiagnostics", t)

# Change default theme to make nicer plots
    # Set theme to use as default
    default_theme = Gadfly.Theme(
        panel_fill = nothing,
        highlight_width = 0mm,
        point_size = 0.5mm,
        key_position = :inside,
        grid_line_width = 0mm)
    Gadfly.push_theme(default_theme)

plot_fit_res(model = modAov, df = df, y = y)






# Set reproducible seed
Random.seed!(123)

# Simulate n = 100 data points from a Poisson distribution
y = rand(Poisson(7), 100)

# Assign grouping variables (5 groups of 20)
x = repeat([1, 2, 3, 4, 5],
            inner = 20,
            outer = 1)

df = hcat(y, x)
df = DataFrame(df)
colnames = ["y","x"]
rename!(df, Symbol.(colnames))

# Run model
modPoisson = fit(GeneralizedLinearModel,
           @formula(y ~ 1 + x),
           df,
           Poisson(),
           GLM.LogLink())

# Make qqplot for ANOVA model
poisson_qqplot = plot_qq(modPoisson)
poisson_fit_res_plot = plot_fit_res(modPoisson)