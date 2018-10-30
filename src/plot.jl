# This file is a part of PlottingGR.jl, licensed under the MIT License (MIT).


function plot(args...)
    figure = GRFigure
    plot_recipe!(figure)
    gr_draw(figure)
end


@inline function plot(plot_type::Symbol, args...) = plot(Val(plot_type), args...)
@inline function plot!(plot_type::Symbol, args...) = plot!(Val(plot_type), args...)

@inline function plot!(plot_type::Symbol, args...) = plot!(Val(plot_type), args...)
