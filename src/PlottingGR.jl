# This file is a part of PlottingGR.jl, licensed under the MIT License (MIT).

__precompile__(true)

module PlottingGR

using Colors
using IntervalSets
using PlottingRecipes
using StaticArrays
using StatsBase

import GR

include("util.jl")
include("colors.jl")
include("plotprimitive.jl")
include("grfigure.jl")

end # module
