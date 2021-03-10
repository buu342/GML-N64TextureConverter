var i;
var spr, w, h;

spr = obj_sprite.sprite_index
w = obj_sprite.sprite_width
h = obj_sprite.sprite_height

// Draw the sprite to the surface
if (surface_exists(obj_sprite.surf))
    surface_free(obj_sprite.surf)
obj_sprite.surf = surface_create(w, h)
surface_set_target(obj_sprite.surf);
    draw_clear_alpha(background_colour, 0);
    draw_sprite(spr, 0, 0, 0)
surface_reset_target();

// Save the surface to a buffer
if (buffer_exists(obj_sprite.buff))
    buffer_delete(obj_sprite.buff)
obj_sprite.buff = buffer_create(w*h*4, buffer_fast, 1);
buffer_get_surface(obj_sprite.buff, obj_sprite.surf, 0, 0, 0);
buffer_seek(obj_sprite.buff, buffer_seek_start, 0);

// Convert it to the sprite array
var size = w*h*4
for (i=0; i<size; i+=4)
{
    var c;
    var red, green, blue, alpha;
    var ix, iy;
    
    // Get the coordinate
    ix = (i/4)%w;
    iy = floor((i/4)/w);
    
    // Get the color values
    blue  = buffer_read(obj_sprite.buff, buffer_u8)
    green = buffer_read(obj_sprite.buff, buffer_u8)
    red   = buffer_read(obj_sprite.buff, buffer_u8)
    alpha = buffer_read(obj_sprite.buff, buffer_u8)

    // Assign the values to our arrays
    c = make_color_rgba(red, green, blue, alpha)
    obj_sprite.sprite_color[ix, iy] = c
}
