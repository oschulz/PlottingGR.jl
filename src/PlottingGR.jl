# This file is a part of PlottingGR.jl, licensed under the MIT License (MIT).

__precompile__(true)

module PlottingGR

using Colors
using IntervalSets
using PlottingRecipes
using StaticArrays
using StatsBase

import GR

include("colors.jl")
include("options.jl")
include("data.jl")
include("grfigure.jl")
include("plot.jl")
include("gr_recipes.jl")
include("std_recipes.jl")

end # module
