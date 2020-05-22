-- This is a lua script for use in Conky.
require 'cairo'

function conky_main ()
    if conky_window == nil then
        return
    end
    local cs = cairo_xlib_surface_create (conky_window.display,
        conky_window.drawable,
        conky_window.visual,
        conky_window.width,
        conky_window.height)
    cr = cairo_create (cs)
    --local updates = tonumber (conky_parse ('${updates}'))
    --if updates > 5 then
    --    print ("Lua is working")
    --end
    --[[ Conky variables
    font = "Mono"
    font_size = 12
    xpos, ypos = 100, 100
    red, green, blue, alpha = 1, 1, 1, 1
    font_slant = CAIRO_FONT_SLANT_NORMAL
    font_face = CAIRO_FONT_WEIGHT_NORMAL
    -- Read cpu usage from conky
    cpu_perc = conky_parse ("${cpu}")
    -- Create a cpu text
    cpu_text = "cpu usage: " .. cpu_perc .. "%"
    -- Put in conky
    cairo_select_font_face (cr, font, font_slant, font_face);
    cairo_set_font_size (cr, font_size)
    cairo_set_source_rgba (cr, red, green, blue, alpha)
    cairo_move_to (cr, xpos, ypos)
    cairo_show_text (cr, cpu_text)]]
    -- Create a line
    line_width = 1.5
    line_cap = CAIRO_LINE_CAP_ROUND
    red, green, blue, alpha = 1, 1, 1, 1
    startx = 272
    endx   = 272
    starty = 27
    endy   = 200
    ----------------------------
    cairo_set_line_width (cr, line_width)
    cairo_set_line_cap  (cr, line_cap)
    cairo_set_source_rgba (cr, red, green, blue, alpha)
    cairo_move_to (cr, startx, starty)
    cairo_line_to (cr, endx, endy)
    -- draw
    cairo_stroke (cr)

    --Destroy
    cairo_surface_destroy(cs)
    cairo_destroy(cr)
end
