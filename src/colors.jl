# This file is a part of PlottingGR.jl, licensed under the MIT License (MIT).


const AnyColor = Any

const RGBAColor = RGBA{Float64}


PlottingRecipes.parse_color(color::Colorant) = color
PlottingRecipes.parse_color(color::Integer) = color
PlottingRecipes.parse_color(color::Nothing) = RGBA{Float64}(1, 1, 1, 0)
PlottingRecipes.parse_color(color::NTuple{3, Real}) = RGB(color...)
PlottingRecipes.parse_color(color::NTuple{4, Real}) = RGBA(color...)
PlottingRecipes.parse_color(color::Symbol) = parse(Colorant, color)


_gr_iscolorless(color::Colorant) = alpha(color) ≈ 0
_gr_iscolorless(color::Integer) = false
_gr_iscolorless(color::Nothing) = true
_gr_iscolorless(color::Any) = _gr_iscolorless(_parsecolor(color))


function _gr_set_alpha_get_colorindex(color::Colorant)
    GR.settransparency(clamp(float(alpha(color)), 0, 1))
    convert(Int, GR.inqcolorfromrgb(red(color), green(color), blue(color)))
end


function _gr_set_alpha_get_colorindex(color::Integer)
    GR.settransparency(1.0)
    convert(Int, color)
end


function _gr_set_alpha_get_colorindex(color::Nothing)
    GR.settransparency(colorant"white")
    0
end


function _gr_set_alpha_get_colorindex(color::Any)
    _set_alpha_get_colorindex(_parsecolor(color))
end


_gr_setlinecolor(color::AnyColor) = GR.setlinecolorind(_gr_set_alpha_get_colorindex(color))
_gr_setfillcolor(color::AnyColor) = GR.setfillcolorind(_gr_set_alpha_get_colorindex(color))
_gr_setmarkercolor(color::AnyColor) = GR.setmarkercolorind(_gr_set_alpha_get_colorindex(color))
_gr_settextcolor(color::AnyColor) = GR.settextcolorind(_gr_set_alpha_get_colorindex(color))



const AnyFillStyle = Union{Integer,Bool,Nothing,Symbol}


const _gr_fillstyles = Dict{Symbol,Int}(
    :hollow => GR.INTSTYLE_HOLLOW,
    :solid => GR.INTSTYLE_SOLID,
    :pattern => GR.INTSTYLE_PATTERN,
    :hatch => GR.INTSTYLE_HATCH,
)


_gr_fillstyle_index(fillstyle::Bool) = fillstyle ? INTSTYLE_SOLID : GR.INTSTYLE_HOLLOW
_gr_fillstyle_index(fillstyle::Nothing) = GR.INTSTYLE_HOLLOW
_gr_fillstyle_index(fillstyle::Integer) = convert(Int, fillstyle)
_gr_fillstyle_index(fillstyle::Symbol) = _gr_fillstyles[fillstyle]


function _gr_setfillstyle(fillstyle::AnyFillStyle, pattern::Integer = 0)
    fillstyle_index = _gr_fillstyle_index(fillstyle)
    GR.setfillintstyle(fillstyle_index)
    if fillstyle_index in (GR.INTSTYLE_PATTERN, GR.INTSTYLE_HATCH)
        GR.setfillstyle(convert(Int, pattern))
    end
end
