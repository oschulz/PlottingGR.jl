# This file is a part of PlottingGR.jl, licensed under the MIT License (MIT).


abstract trype GRFigure <: AbstractFigure end


abstract type AbstractPlotBackground end


abstract type AbstractFigure{NDIMS} end


const PlotArgs = Vector{Any}
const PlotOpts = Dict{Symbol, Any}



struct Axis
    range::FloatInterval
    scale::Symbol
    label::String
    axis_color::GRColor
    label_color::GRColor
end

Axis() = Axis(-Inf..Inf, identity, "", RGBAColor(0, 0, 0, 1))


function _gr_drawaxes(axes::StaticVector{2,Axis})
    x_min = minimum(x_interval)
    x_max = maximum(x_interval)
    y_min = minimum(y_interval)
    y_max = maximum(y_interval)

    GR.setwindow(x_min, x_max, y_min, y_max)

    if !_gr_iscolorless(background_color)
        _gr_setfillcolor(background_color)
        _gr_setfillstyle(true)
        GR.fillrect(x_min, x_max, y_min, y_max)
    end

    x_origin = x_min
    y_origin = y_min

    _gr_setlinecolor(grid_color)
    GR.grid(x_tick, y_tick, x_origin, y_origin, major_xtick, major_ytick)

    GR.setcharheight(0.020)
    _gr_settextcolor(axes_color)
    _gr_setlinecolor(axes_color)
    GR.axes(x_tick, y_tick, x_origin, y_origin, major_xtick, major_ytick, tick_size)
end


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
