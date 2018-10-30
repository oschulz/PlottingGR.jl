# This file is a part of PlottingGR.jl, licensed under the MIT License (MIT).


abstract trype GRFigure <: AbstractFigure end


abstract type AbstractPlotBackground end


abstract type AbstractFigure{NDIMS} end



@with_kw struct GRAxis
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


struct GRFigure{NDIMS}
    axes::StaticArray{NDIMS,GRAxis}
    plot_background::GRPlotBackground
    contents::Vector{GRPlottingPrimitive}
    sub_figures::Vector{GRFigure}
end
