var i
var w = obj_sprite.sprite_width
var h = obj_sprite.sprite_height
var size = w*h

if (surface_exists(obj_sprite.surfa))
    surface_free(obj_sprite.surfa)

obj_sprite.surfa = surface_create(w, h)
surface_set_target(obj_sprite.surfa)
    for (i=0; i<size; i++)
    {
        var alpha;

        if (!global.usealpha)
            alpha = 255
        else if (global.alphatype == "SingleColor")
        {
            if (rgba_to_bgr(obj_sprite.sprite_color[i%w, floor(i/w)]) == global.alphacolor)
                alpha = 0
            else
                alpha = 255
        }
        else
             alpha = obj_sprite.import_alpha[i%w, floor(i/w)]
             
        obj_sprite.sprite_alpha[i%w, floor(i/w)] = alpha
        draw_set_colour(make_color_hsv(0, 0, alpha))
        draw_point(i%w, floor(i/w))
    }
surface_reset_target()
