# This file is a part of PlottingGR.jl, licensed under the MIT License (MIT).


PlottingRecipes.parse_color(color::Colorant) = color
PlottingRecipes.parse_color(color::Integer) = color
PlottingRecipes.parse_color(color::Nothing) = RGBA{Float64}(1, 1, 1, 0)
PlottingRecipes.parse_color(color::NTuple{3, Real}) = RGB(color...)
PlottingRecipes.parse_color(color::NTuple{4, Real}) = RGBA(color...)
PlottingRecipes.parse_color(color::Symbol) = parse(Colorant, color)



const AnyColor = Any

struct GRColor
    colorindex::Int
    alpha::Float64
end


convert(::Type{GRColor}, color::GRColor) = color
convert(::Type{GRColor}, color::Any) = GRColor(color)

GRColor(color::GRColor) = GRColor(color.colorindex, color.alpha)

GRColor(color::Integer) = GRColor(color, 1.0)

function GRColor(color::Colorant)
    colorindex = GR.inqcolorfromrgb(red(color), green(color), blue(color))
    alpha = GRColor(alpha(color))
    GRColor(colorindex, color)
end

GRColor(color::Nothing) = GRColor(colorant"white", 1.0)

GRColor(color::Symbol) = GRColor(parse_color(color), 1.0)


_gr_isinvisible(color::GRColor) = color.alpha ≈ 0


function _gr_setlinecolor(color::AnyColor)
    c = convert(GRColor, color)
    GR.settransparency(c.alpha)
    GR.setlinecolorind(c.colorindex)
end

function _gr_setfillcolor(color::AnyColor)
    c = convert(GRColor, color)
    GR.settransparency(c.alpha)
    GR.setfillcolorind(c.colorindex)
end

function _gr_setmarkercolor(color::AnyColor)
    c = convert(GRColor, color)
    GR.settransparency(c.alpha)
    GR.setmarkercolorind(c.colorindex)
end

function _gr_settextcolor(color::AnyColor)
    c = convert(GRColor, color)
    GR.settransparency(c.alpha)
    GR.settextcolorind(c.colorindex)
end


const AnyFillStyle = Any



const _gr_fillstyles = Dict{Symbol,Int}(
    :hollow => GR.INTSTYLE_HOLLOW,
    :solid => GR.INTSTYLE_SOLID,
    :pattern => GR.INTSTYLE_PATTERN,
    :hatch => GR.INTSTYLE_HATCH,
)


struct GRFillStyle
    mode::Int
    pattern::Int
end


GRFillStyle(fillstyle::GRFillStyle) = GRFillStyle(fillstyle.mode, fillstyle.pattern)

convert(::Type{GRFillStyle}, fillstyle::GRFillStyle) = fillstyle
convert(::Type{GRFillStyle}, fillstyle::Any) = GRFillStyle(fillstyle)

GRFillStyle(fillstyle::Bool) = GRFillStyle(fillstyle ? INTSTYLE_SOLID : GR.INTSTYLE_HOLLOW, -1)
GRFillStyle(fillstyle::Nothing) = GRFillStyle(GR.INTSTYLE_HOLLOW, -1)
GRFillStyle(fillstyle::Symbol) = GRFillStyle(_gr_fillstyles[fillstyle], -1)


function _gr_setfillstyle(fillstyle::AnyFillStyle)
    style = convert(GRFillStyle, fillstyle)
    GR.setfillintstyle(style.mode)
    if style.pattern >= 0
        GR.setfillstyle(convert(Int, style.pattern))
    end
end
