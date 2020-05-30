-- This is a lua script for use in Conky.
-- TODO write a log when error
require 'cairo'
require 'imlib2'

local	cs, cr = nil

function conky_text (text, cr, font, font_size, xpos, ypos, red, green, blue, alpha, font_size, font_face)
    -- Put in conky
    cairo_select_font_face (cr, font, font_slant, font_face);
    cairo_set_font_size (cr, font_size)
    cairo_set_source_rgba (cr, red, green, blue, alpha)
    cairo_move_to (cr, xpos, ypos)
    cairo_show_text (cr, text)
    return cr
end

function conky_line (line_width, line_cap, red, green, blue, alpha, startx, starty, endx, endy, cr)
    cairo_set_line_width (cr, line_width)
    cairo_set_line_cap  (cr, line_cap)
    cairo_set_source_rgba (cr, red, green, blue, alpha)
    cairo_move_to (cr, startx, starty)
    cairo_line_to (cr, endx, endy)
    return cr
end

function retrieve_weather_fig (sym)
    tmp = nil
    car = 0
    if sym == "01d" then
        tmp ="\u{f185}" -- 1  sunny
        car = 1
    elseif sym == "01n" then
        tmp ="\u{f186}" -- 2  sunny
        car = 1
    elseif sym == "01m" then
        tmp ="\u{f185}" -- 3  sunny
        car = 1
    elseif sym == "02d" then
        tmp ="\u{f185}" -- 4  Fair
        car = 1
    elseif sym == "02n" then
        tmp ="\u{f186}" -- 5  Fair
        car = 1
    elseif sym == "02m" then
        tmp ="\u{f185}" -- 6  Fair
        car = 1
    elseif sym == "03d" then
        tmp ="\u{f6c4}" -- 7  Partly
        car = 1
    elseif sym == "03n" then
        tmp ="\u{f6c3}" -- 8  Partly
        car = 1
    elseif sym == "03m" then
        tmp ="\u{f6c4}" -- 9  Partly
        car = 1
    elseif sym == "04" then
        tmp ="\u{f0c2}" -- 10 Cloudy
        car = 1
    elseif sym == "40d" then
        tmp ="\u{f743}" -- 11 light rain
        car = 1
    elseif sym == "40n" then
        tmp ="\u{f73c}" -- 12 light rain
        car = 1
    elseif sym == "40m" then
        tmp ="\u{f743}" -- 13 light rain
        car = 1
    elseif sym == "05d" then
        tmp ="\u{f743}" -- 14 Rain / showers
        car = 1
    elseif sym == "05n" then
        tmp ="\u{f73c}" -- 15 Rain / showers
        car = 1
    elseif sym == "05m" then
        tmp ="\u{f743}" -- 16 Rain / showers
        car = 1
    elseif sym == "41d" then
        tmp ="\u{f740}" -- 17 Heavy rain
        car = 1
    elseif sym == "41n" then
        tmp ="\u{f740}" -- 18 Heavy rain
        car = 1
    elseif sym == "41m" then
        tmp ="\u{f740}" -- 19 Heavy rain
        car = 1
    elseif sym == "24d" then
        tmp ="\u{f743}\u{f0e7}" -- 20 light rain with thunder
        car = 2
    elseif sym == "24n" then
        tmp ="\u{f73c}\u{f0e7}" -- 21 light rain with thunder
        car = 2
    elseif sym == "24m" then
        tmp ="\u{f743}\u{f0e7}" -- 22 light rain with thunder
        car = 2
    elseif sym == "06d" then
        tmp ="\u{f740}\u{f0e7}" -- 23 Rain with thunder
        car = 2
    elseif sym == "06n" then
        tmp ="\u{f740}\u{f0e7}" -- 24 Rain with thunder
        car = 2
    elseif sym == "06m" then
        tmp ="\u{f740}\u{f0e7}" -- 25 Rain with thunder
        car = 2
    elseif sym == "25d" then
        tmp ="\u{f740}\u{f0e7}" -- 26 heavy rain with thunder
        car = 2
    elseif sym == "25n" then
        tmp ="\u{f740}\u{f0e7}" -- 27 heavy rain with thunder
        car = 2
    elseif sym == "25m" then
        tmp ="\u{f740}\u{f0e7}" -- 28 heavy rain with thunder
        car = 2
    elseif sym == "42d" then
        tmp ="\u{f743}\u{f2dc}" -- 29 light sleet shower
        car = 2
    elseif sym == "42n" then
        tmp ="\u{f73c}\u{f2dc}" -- 30 light sleet shower
        car = 2
    elseif sym == "42m" then
        tmp ="\u{f743}\u{f2dc}" -- 31 light sleet shower
        car = 2
    elseif sym == "07d" then
        tmp ="\u{f743}\u{f2dc}" -- 32 sleet shower
        car = 2
    elseif sym == "07n" then
        tmp ="\u{f73c}\u{f2dc}" -- 33 sleet shower
        car = 2
    elseif sym == "07m" then
        tmp ="\u{f743}\u{f2dc}" -- 34 sleet shower
        car = 2
    elseif sym == "43d" then
        tmp ="\u{f740}\u{f2dc}" -- 35 heavy sleet shower
        car = 2
    elseif sym == "43n" then
        tmp ="\u{f740}\u{f2dc}" -- 36 heavy sleet shower
        car = 2
    elseif sym == "43m" then
        tmp ="\u{f740}\u{f2dc}" -- 37 heavy sleet shower
        car = 2
    elseif sym == "26d" then
        tmp ="\u{f743}\u{f2dc}" -- 38 light sleet showers and thunder
        car = 2
    elseif sym == "26n" then
        tmp ="\u{f73c}\u{f2dc}" -- 39 light sleet showers and thunder
        car = 2
    elseif sym == "26m" then
        tmp ="\u{f743}\u{f2dc}" -- 40 light sleet showers and thunder
        car = 2
    elseif sym == "20d" then
        tmp ="\u{f743}\u{f2dc}" -- 41 sleet shower with thunder
        car = 2
    elseif sym == "20n" then
        tmp ="\u{f73c}\u{f2dc}" -- 42 sleet shower with thunder
        car = 2
    elseif sym == "20m" then
        tmp ="\u{f743}\u{f2dc}" -- 43 sleet shower with thunder
        car = 2
    elseif sym == "27d" then
        tmp ="\u{f740}\u{f2dc}" -- 44 heavy sleet shower with thunder
        car = 2
    elseif sym == "27n" then
        tmp ="\u{f740}\u{f2dc}" -- 45 heavy sleet shower with thunder
        car = 2
    elseif sym == "27m" then
        tmp ="\u{f740}\u{f2dc}" -- 46 heavy sleet shower with thunder
        car = 2
    elseif sym == "44d" then
        tmp ="\u{f73b}" -- 47 light snow shower
        car = 1
    elseif sym == "44n" then
        tmp ="\u{f73b}" -- 48 light snow shower
        car = 1
    elseif sym == "44m" then
        tmp ="\u{f73b}" -- 49 light snow shower
        car = 1
    elseif sym == "08d" then
        tmp ="\u{f73b}" -- 50 snow shower
        car = 1
    elseif sym == "08n" then
        tmp ="\u{f73b}" -- 51 snow shower
        car = 1
    elseif sym == "08m" then
        tmp ="\u{f73b}" -- 52 snow shower
        car = 1
    elseif sym == "45d" then
        tmp ="\u{f73b}" -- 53 heavy snow shower
        car = 1
    elseif sym == "45n" then
        tmp ="\u{f73b}" -- 54 heavy snow shower
        car = 1
    elseif sym == "45m" then
        tmp ="\u{f73b}" -- 55 heavy snow shower
        car = 1
    elseif sym == "28d" then
        tmp ="\u{f73b}\u{f0e7}" -- 56 light snow with thunder
        car = 2
    elseif sym == "28n" then
        tmp ="\u{f73b}\u{f0e7}" -- 57 light snow with thunder
        car = 2
    elseif sym == "28m" then
        tmp ="\u{f73b}\u{f0e7}" -- 58 light snow with thunder
        car = 2
    elseif sym == "21d" then
        tmp ="\u{f73b}\u{f0e7}" -- 59 snow shower with thunder
        car = 2
    elseif sym == "21n" then
        tmp ="\u{f73b}\u{f0e7}" -- 60 snow shower with thunder
        car = 2
    elseif sym == "21m" then
        tmp ="\u{f73b}\u{f0e7}" -- 61 snow shower with thunder
        car = 2
    elseif sym == "29d" then
        tmp ="\u{f73b}\u{f0e7}" -- 62 heavy snow shower with thunder
        car = 2
    elseif sym == "29n" then
        tmp ="\u{f73b}\u{f0e7}" -- 63 heavy snow shower with thunder
        car = 2
    elseif sym == "29m" then
        tmp ="\u{f73b}\u{f0e7}" -- 64 heavy snow shower with thunder
        car = 2
    elseif sym == "46" then
        tmp ="\u{f73d}" -- 65 light rain
        car = 1
    elseif sym == "09" then
        tmp ="\u{f73d}" -- 66 rain
        car = 1
    elseif sym == "10" then
        tmp ="\u{f740}" -- 67 heavy rain
        car = 1
    elseif sym == "30" then
        tmp ="\u{f73d}\u{f0e7}" -- 68 light rain thunder
        car = 2
    elseif sym == "22" then
        tmp ="\u{f73d}\u{f0e7}" -- 69 Rain thunder
        car = 2
    elseif sym == "11" then
        tmp ="\u{f740}\u{f0e7}" -- 70 Heavy rain thunder
        car = 2
    elseif sym == "47" then
        tmp ="\u{f73d}\u{f2dc}" -- 71 light sleet
        car = 2
    elseif sym == "12" then
        tmp ="\u{f73d}\u{f2dc}" -- 72 sleet
        car = 2
    elseif sym == "48" then
        tmp ="\u{f740}\u{f2dc}" -- 73 heavy sleet
        car = 2
    elseif sym == "31" then
        tmp ="\u{f73d}\u{f2dc}" -- 74 light sleet with thunder
        car = 2
    elseif sym == "23" then
        tmp ="\u{f73d}\u{f2dc}" -- 75 Sleet with thunder
        car = 2
    elseif sym == "32" then
        tmp ="\u{f740}\u{f2dc}" -- 76 Heavy sleet with thunder
        car = 2
    elseif sym == "49" then
        tmp ="\u{f73b}" -- 77 light snow
        car = 1
    elseif sym == "13" then
        tmp ="\u{f73b}" -- 78 snow
        car = 1
    elseif sym == "50" then
        tmp ="\u{f73b}" -- 79 heavy snow
        car = 1
    elseif sym == "33" then
        tmp ="\u{f73b}\u{f0e7}" -- 80 light snow with thunder
        car = 2
    elseif sym == "14" then
        tmp ="\u{f73b}\u{f0e7}" -- 81 snow with thunder
        car = 2
    elseif sym == "34" then
        tmp ="\u{f73b}\u{f0e7}" -- 82 heavy snow with thunder
        car = 2
    elseif sym == "15" then
        tmp ="\u{f75f}" -- 83 Fog
        car = 1
    else
        tmp ="\u{f005}" -- Other
        car = 1
    end
    return tmp,car
end

function image (im)--
	x = nil
	x = (im.x or 0)
	y = nil
	y = (im.y or 0)
	w = nil
	w = (im.w or 0)
	h = nil
	h = (im.h or 0)
	--file = nil
    file = tostring (im.file)
	if file == nil then print ("set image file") end
    ---------------------------------------------
	show = imlib_load_image (file)

	if show == nil then return end
	imlib_context_set_image (show)
	if tonumber (w) == 0 then
		width = imlib_image_get_width ()
	else
		width = tonumber (w)
	end

	if tonumber (h) == 0 then
		height = imlib_image_get_height ()
	else
		height = tonumber (h)
	end

	imlib_context_set_image (show) 
	local scaled = imlib_create_cropped_scaled_image (0, 0,
			imlib_image_get_width (), imlib_image_get_height (), width, height) 
	imlib_free_image ()
	imlib_context_set_image (scaled)
	imlib_render_image_on_drawable (x, y)
	imlib_free_image ()
	show = nil
end

function conky_main ()
    red, green, blue, alpha = 1, 1, 1, 1
    font_slant = CAIRO_FONT_SLANT_NORMAL
    font_face = CAIRO_FONT_WEIGHT_NORMAL

    if conky_window == nil then return end
    if cs == nil then cairo_surface_destroy(cs) end
    if cr == nil then cairo_destroy(cr) end

    local cs = cairo_xlib_surface_create (
        conky_window.display,
        conky_window.drawable,
        conky_window.visual,
        conky_window.width,
        conky_window.height)
    
    cr = cairo_create (cs)

    server_symbol = "\u{f233}"

    ----------------------------
    -- Create CPU line
    ----------------------------
    cairo_new_path(cr)
    line_width    = 1.5
    line_cap      = CAIRO_LINE_CAP_ROUND
    red, green, blue, alpha = 1, 1, 1, 1
    startx    = 5
    endx      = 6
    starty    = 191.5
    endy      = 191.5
    ----------------------------
    conky_line (line_width, line_cap, red, green, blue, alpha, startx, starty, endx, endy, cr)
    ----------------------------
    startx    = 115
    endx      = 425
    ----------------------------
    conky_line (line_width, line_cap, red, green, blue, alpha, startx, starty, endx, endy, cr)

    cairo_stroke (cr)
    center_x    = 105
    center_y    = starty
    radius      = 10
    start_angle = -90 * math.pi /180
    end_angle   = 90 * math.pi /180 -- Same thing as 360 degrees.
    cairo_arc (cr, center_x, center_y, radius, start_angle,     end_angle)

    center_x    = 17
    start_angle = 90 * math.pi /180
    end_angle   = -90 * math.pi /180 -- Same thing as 360 degrees.
    cairo_arc (cr, center_x, center_y, radius, start_angle,     end_angle)
    cpu_center = center_y
    -- draw
    cairo_close_path(cr)
    cairo_stroke (cr)

    ----------------------------
    -- Create GPU line
    ----------------------------
    line_width    = 1.5
    line_cap      = CAIRO_LINE_CAP_ROUND
    red, green, blue, alpha = 1, 1, 1, 1
    startx    = 5
    endx      = 6
    starty    = 350
    endy      = 350
    ----------------------------
    conky_line (line_width, line_cap, red, green, blue, alpha, startx, starty, endx, endy, cr)
    ----------------------------
    startx    = 115
    endx      = 425
    ----------------------------
    conky_line (line_width, line_cap, red, green, blue, alpha, startx, starty, endx, endy, cr)

    cairo_stroke (cr)
    center_x    = 105
    center_y    = starty
    radius      = 10
    start_angle = -90 * math.pi /180
    end_angle   = 90 * math.pi /180 -- Same thing as 360 degrees.
    cairo_arc (cr, center_x, center_y, radius, start_angle,     end_angle)

    center_x    = 17
    start_angle = 90 * math.pi /180
    end_angle   = -90 * math.pi /180 -- Same thing as 360 degrees.
    cairo_arc (cr, center_x, center_y, radius, start_angle,     end_angle)

    -- draw
    cairo_close_path(cr)
    cairo_stroke (cr)
    ----------------------------
    -- Create CPU text
    ----------------------------
    font        = "la-solid-900"
    font_size   = 20
    xpos, ypos  = 9, cpu_center + 7
    cr          = conky_text (server_symbol, cr, font, font_size, xpos, ypos, red, green, blue, alpha, font_size, font_face)
    font        = "GeosansLight"
    font_size   = 19
    xpos, ypos  = 35, cpu_center + 6
    cr = conky_text ("CPU Info", cr, font, font_size, xpos, ypos, red, green, blue, alpha, font_size, font_face)

    ----------------------------
    -- Weather figures
    char_today,num_c_today    = retrieve_weather_fig("01d")
    char_day1,num_c_day1      = retrieve_weather_fig("01d")
    char_day2,num_c_day2      = retrieve_weather_fig("25d")
    char_day3,num_c_day3      = retrieve_weather_fig("01d")
    loc_symbol    = "\u{f3c5}"
    rain_symbol   = "\u{f043}"
    rain          = '/home/Dimitris/.conky/png/tint-solid.png'
    -- Weather Text
    font          = "GeosansLight"
    temp_today    = "00°C"
    dateDay1      = "Day 1"
    dateDay2      = "Day 2"
    dateDay3      = "Day 3"
    temoD1        = "01°C"
    temoD2        = "02°C"
    temoD3        = "03°C"
    text_loc      = "Stockholm"
    text_rain     = "10%"

    --image ({x=270, y=15, h = 60, w = 60, file = image_today})

    font_size = 30
    xpos, ypos = 350, 50
    cr = conky_text (temp_today, cr, font, font_size, xpos, ypos, red, green, blue, alpha, font_size, font_face)


    yoff = 30

    xpos                      = 270
    font_size                 = 14
    ypos                      = 100 + yoff
    font_size                 = 15
    red, green, blue, alpha   = 1, 1, 1, 1
    font_slant                = CAIRO_FONT_SLANT_NORMAL
    font_face                 = CAIRO_FONT_WEIGHT_NORMAL

    cr = conky_text (dateDay1, cr, font, font_size, xpos, ypos, red, green, blue, alpha, font_size, font_face)

    font_size   = 15
    ypos        = 100+yoff
    xpos        = 325
    cr          = conky_text (dateDay2, cr, font, font_size, xpos, ypos, red, green, blue, alpha, font_size, font_face)

    xpos        = 380
    cr          = conky_text (dateDay3, cr, font, font_size, xpos, ypos, red, green, blue, alpha, font_size, font_face)

    font_slant  = CAIRO_FONT_SLANT_ITALIC
    xpos, ypos  = 270, 145+yoff
    cr          = conky_text (temoD1, cr, font, font_size, xpos, ypos, red, green, blue, alpha, font_size, font_face)

    xpos        = 325
    cr          = conky_text (temoD2, cr, font, font_size, xpos, ypos, red, green, blue, alpha, font_size, font_face)

    xpos        = 380
    cr          = conky_text (temoD3, cr, font, font_size, xpos, ypos, red, green, blue, alpha, font_size, font_face)

    xoff        = 10

    --image ({x=270+xoff , y=72, h = 20, w = 20, file = location})

    font_size   = 16
    xpos, ypos  = 294+xoff, 80.4
    cr = conky_text (text_loc, cr, font, font_size, xpos, ypos, red, green, blue, alpha, font_size, font_face)

    --image ({x=270+xoff, y=93, h = 20, w = 20, file = rain})
    xpos, ypos = 294+xoff, 101.4
    cr = conky_text (text_rain, cr, font, font_size, xpos, ypos, red, green, blue, alpha, font_size, font_face)

    font = "la-solid-900"

    ----- Weather icons -------

    --------- Today -----------
    if num_c_today == 1 then
        xpos, ypos  = 290, 55
    elseif num_c_today == 2 then
        xpos, ypos  = 258, 55
    else
        print("ERROR wrong number of char")
    end
    font_size   = 45
    cr = conky_text (char_today, cr, font, font_size, xpos, ypos, red, green, blue, alpha, font_size, font_face)

    --------- day1 -----------
    if num_c_day1 == 1 then
        xpos, ypos  = 273, 156
    elseif num_c_day1 == 2 then
        xpos, ypos  = 264, 156
    else
        print("ERROR wrong number of char")
    end
    font_size   = 25
    cr = conky_text (char_day1, cr, font, font_size, xpos, ypos, red, green, blue, alpha, font_size, font_face)

    --------- day2 -----------
    if num_c_day2 == 1 then
        xpos, ypos  = 327, 156
    elseif num_c_day2 == 2 then
        xpos, ypos  = 317.5, 156
    else
        print("ERROR wrong number of char")
    end
    cr = conky_text (char_day2, cr, font, font_size, xpos, ypos, red, green, blue, alpha, font_size, font_face)

    --------- day3 -----------
    if num_c_day3 == 1 then
        xpos, ypos  = 382.5, 156
    elseif num_c_day3 == 2 then
        xpos, ypos  = 374, 156
    else
        print("ERROR wrong number of char")
    end
    cr = conky_text (char_day3, cr, font, font_size, xpos, ypos, red, green, blue, alpha, font_size, font_face)

    -- Symbols for location and rainfall
    font_size   = 20
    xpos, ypos  = 281, 82.4
    cr = conky_text (loc_symbol, cr, font, font_size, xpos, ypos, red, green, blue, alpha, font_size, font_face)
    xpos, ypos = 281, 103.4
    cr = conky_text (rain_symbol, cr, font, font_size, xpos, ypos, red, green, blue, alpha, font_size, font_face)

    cairo_surface_destroy(cs)
    cairo_destroy(cr)

end
