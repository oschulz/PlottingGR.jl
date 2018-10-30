# This file is a part of PlottingGR.jl, licensed under the MIT License (MIT).


const AnyColor = Any

const RGBAColor = RGBA{Float64}




PlottingRecipes.parse_color(color::Colorant) = color
PlottingRecipes.parse_color(color::Integer) = color
PlottingRecipes.parse_color(color::Nothing) = RGBA{Float64}(1, 1, 1, 0)
PlottingRecipes.parse_color(color::NTuple{3, Real}) = RGB(color...)
PlottingRecipes.parse_color(color::NTuple{4, Real}) = RGBA(color...)
PlottingRecipes.parse_color(color::Symbol) = parse(Colorant, color)



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


function _gr_setlinecolor(color::GRColor)
    GR.settransparency(color.alpha)
    GR.setlinecolorind(color.colorindex)
end

function _gr_setfillcolor(color::GRColor)
    GR.settransparency(color.alpha)
    GR.setfillcolorind(color.colorindex)
end

function _gr_setmarkercolor(color::GRColor)
    GR.settransparency(color.alpha)
    GR.setmarkercolorind(color.colorindex)
end

function _gr_settextcolor(color::GRColor)
    GR.settransparency(color.alpha)
    GR.settextcolorind(color.colorindex)
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


function _gr_setfillstyle(fillstyle::GRFillStyle)
    fillstyle_index = _gr_fillstyle_index(fillstyle)
    GR.setfillintstyle(fillstyle.mode)
    if fillstyle.pattern >= 0
        GR.setfillstyle(convert(Int, fillstyle.pattern))
    end
end
