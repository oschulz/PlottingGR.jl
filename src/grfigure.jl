# This file is a part of PlottingGR.jl, licensed under the MIT License (MIT).


abstract trype GRFigure <: AbstractFigure end


abstract type AbstractPlotBackground end


abstract type AbstractFigure{NDIMS} end


const PlotArgs = Vector{Any}
const PlotOpts = Dict{Symbol, Any}


struct Axis
    range::FloatInterval
    scale::Function
    label::String
    label_color::AnyGRColor
end

Axis() = Axis(-Inf..Inf, identity, "", RGBAColor(0, 0, 0, 1))


@with_kw struct Legend
    range::FloatInterval = -Inf..Inf
    scale::Function = identity
    label::String
    label_color::AnyGRColor = RGBAColor(0, 0, 0, 1)
end


abstract type GRPlotPrimitive end

struct GRPlotBackground
    background_color::RGBAColor
    grid_color::RGBAColor
end


const PlotActionFunc = FunctionWrappers.FunctionWrapper{Nothing,Tuple{PlotArgs,PlotOpts}}

struct PlotAction
    args::Vector{Any}
    opts::GRPlotOpts
    func::PlotActionFunc
end


mutable struct GRFigure{N}
    title::String
    axes::StaticVector{N,Axis}
    # TODO: legend
    actions::Vector{PlotAction}
    sub_figures::Vector{GRFigure}
end


mutable struct Plot{T<:AbstractBackend} <: AbstractPlot{T}
    backend::T                   # the backend type
    n::Int                       # number of series
    attr::KW                     # arguments for the whole plot
    user_attr::KW                # raw arg inputs (after aliases).  these are used as the input dict in `_plot!`
    series_list::Vector{Series}  # arguments for each series
    o                            # the backend's plot object
    subplots::Vector{Subplot}
    spmap::SubplotMap            # provide any label as a map to a subplot
    layout::AbstractLayout
    inset_subplots::Vector{Subplot}  # list of inset subplots
    init::Bool
end
