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