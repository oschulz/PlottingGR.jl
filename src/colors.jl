# This file is a part of PlottingGR.jl, licensed under the MIT License (MIT).


const AnyColor = Union{Integer,Colorant,Symbol,Nothing}

const RGBAColor = RGBA{Float64}


function _gr_set_alpha_get_colorindex(color::Colorant)
    GR.settransparency(clamp(float(alpha(color)), 0, 1))
    convert(Int, GR.inqcolorfromrgb(red(color), green(color), blue(color)))
end


function _gr_set_alpha_get_colorindex(color::Symbol)
    _set_alpha_get_colorindex(parse(Colorant, color), gr_setcolor_f)
end


function _gr_set_alpha_get_colorindex(color::Integer)
    GR.settransparency(1.0)
    convert(Int, color)
end


function _gr_set_alpha_get_colorindex(color::Nothing)
    GR.settransparency(colorant"white")
    0
end


_gr_setlinecolor(color::AnyColor) = GR.setlinecolorind(_gr_set_alpha_get_colorindex(color))
_gr_setfillcolor(color::AnyColor) = GR.setfillcolorind(_gr_set_alpha_get_colorindex(color))
_gr_setmarkercolor(color::AnyColor) = GR.setmarkercolorind(_gr_set_alpha_get_colorindex(color))
_gr_settextcolor(color::AnyColor) = GR.settextcolorind(_gr_set_alpha_get_colorindex(color))


const _gr_fillstyles = Dict{Symbol,Int}(
    :hollow => INTSTYLE_HOLLOW,
    :solid => INTSTYLE_SOLID,
    :pattern => INTSTYLE_PATTERN,
    :hatch => INTSTYLE_HATCH,
)
