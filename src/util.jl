# This file is a part of PlottingGR.jl, licensed under the MIT License (MIT).


const FloatInterval = Interval{:closed,:closed,Float64}


function _setup_plot_2d(;
    x_interval::FloatInterval = 0.0..1.0,
    y_interval::FloatInterval = 0.0..1.0,
    x_tick::Float64 = (maximum(x_interval) - minimum(x_interval)) / 10,
    y_tick::Float64 = (maximum(y_interval) - minimum(y_interval)) / 10,
    major_xtick::Int = 2,
    major_ytick::Int = 2,
    grid_color::AnyColor = convert(RGBAColor, colorant"gray"),
    axes_color::RGBAColor = convert(RGBAColor, colorant"black"),
    tick_size::Float64 = -0.005,
)
    x_min = minimum(x_interval)
    x_max = maximum(x_interval)
    y_min = minimum(y_interval)
    y_max = maximum(y_interval)

    GR.setwindow(x_min, x_max, y_min, y_max)

    _gr_setfillcolor(90)
    GR.setfillintstyle(1)
    GR.fillrect(x_min, x_max, y_min, y_max)

    x_origin = x_min
    y_origin = y_min

    _gr_setlinecolor(grid_color)
    GR.grid(x_tick, y_tick, x_origin, y_origin, major_xtick, major_ytick)

    _gr_setlinecolor(axes_color)
    GR.axes(x_tick, y_tick, x_origin, y_origin, major_xtick, major_ytick, tick_size)
end
