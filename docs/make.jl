using GLMdiagnostics
using Documenter

DocMeta.setdocmeta!(GLMdiagnostics, :DocTestSetup, :(using GLMdiagnostics); recursive=true)

makedocs(;
    modules=[GLMdiagnostics],
    authors="Guy F. Sutton",
    repo="https://github.com/guysutton/GLMdiagnostics.jl/blob/{commit}{path}#{line}",
    sitename="GLMdiagnostics.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://guysutton.github.io/GLMdiagnostics.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/guysutton/GLMdiagnostics.jl",
)
