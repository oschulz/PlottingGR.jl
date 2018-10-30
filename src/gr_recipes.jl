# This file is a part of PlottingGR.jl, licensed under the MIT License (MIT).


PlottingRecipes.plotting_recipe!(
    figure::GRFigure, options::PlotOptions,
    ::Val{:gr_polyline}, x::RealVector, y::RealVector
)
    _gr_setfillcolor(options[:fillcolor])
    _gr_setfillstyle(options[:fillstyle])
    _gr_setlinecolor(options[:linecolor])
    GR.polyline(convert(GRVector, x), convert(GRVector, y))
end


# GR.polymarker
# ...
