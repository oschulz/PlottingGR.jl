# This file is a part of PlottingGR.jl, licensed under the MIT License (MIT).


PlottingRecipes.plotting_recipe!(
    figure::GRFigure, options::PlotOptions,
    ::Val{:lines}, x::RealVector, y::RealVector
)
    x_gr = gr_data_copy(x)
    y_gr = gr_data_copy(y)
    action = ActionWrapper() do
        GR.polyline(x_gr, y_gr)
    end
    push!(scene.actions, action)
end
