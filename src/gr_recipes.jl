# This file is a part of PlottingGR.jl, licensed under the MIT License (MIT).


PlottingRecipes.plotting_recipe!(
    figure::GRFigure, options::PlotOptions,
    ::Val{:gr_polyline}, x::RealVector, y::RealVector
)
    x_gr = convert(GRVector, x)
    y_gr = convert(GRVector, y)
    GR.polyline(x_gr, y_gr)

    _gr_setlinecolor(:green)(options[:linecolor])

    push!(scene.actions, action)
end


# GR.polymarker
# ...
