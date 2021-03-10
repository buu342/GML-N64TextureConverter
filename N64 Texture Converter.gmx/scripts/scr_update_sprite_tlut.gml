// Updates the sprite after the TLUT changed

var i
var w = obj_sprite.sprite_width
var h = obj_sprite.sprite_height
var size = w*h

if (surface_exists(obj_sprite.surf))
    surface_free(obj_sprite.surf)

obj_sprite.surf = surface_create(w, h)
surface_set_target(obj_sprite.surf)
    for (i=0; i<size; i++)
    {
        var color;
        var ix = i%w;
        var iy = floor(i/w);
        var r,g,b;

        obj_sprite.sprite_color[ix, iy] = obj_sprite.sprite_tlut[obj_sprite.texel_tlut[ix, iy]]
        r = (obj_sprite.sprite_color[ix, iy]>>24)&$FF
        g = (obj_sprite.sprite_color[ix, iy]>>16)&$FF
        b = (obj_sprite.sprite_color[ix, iy]>>8)&$FF        
        draw_set_colour(make_color_rgb(r,g,b))
        draw_point(ix, iy)
    }
surface_reset_target()
scr_update_alpha()
