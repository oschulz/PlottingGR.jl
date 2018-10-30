# This file is a part of PlottingGR.jl, licensed under the MIT License (MIT).


@with_kw struct GRAxis <: AbstractPlotAxis
    range::FloatInterval = -Inf..Inf
    scale::Function = identity
    label::String
    label_color::AnyGRColor = RGBAColor(0, 0, 0, 1)
end


abstract trype GRFigure <: AbstractFigure end


struct GRAxes2D
    x::GRAxis
    y::GRAxis
end


struct GRAxes3D
    x::GRAxis
    y::GRAxis
    z::GRAxis
end


struct GRPlotBackground
    background_color::RGBAColor
    grid_color::RGBAColor
end


struct GREmptyFigure <: GRFigure
    axes::GRAxes2D
    plot_background::GRPlotBackground
end


struct GRFigure2D <: GRFigure
    axes::GRAxes2D
    plot_background::GRPlotBackground
end
