var width, height, num=0, size=0, i;
width = 192
height = width
draw_set_color(c_black)
draw_set_halign(fa_center)
draw_set_valign(fa_middle)

if (global.exporttype == "8B-CI")
{
    size = width/16
    num = 256
}
else if (global.exporttype == "4B-CI")
{
    size = width/4
    num = 16
}

if (!instance_exists(obj_sprite))
    draw_text(x+54+(width+2)/2, y+79+(height+1)/2, "No image loaded")
else if (num == 0)
    draw_text(x+54+(width+2)/2, y+79+(height+1)/2, "Palette unsupported in this color mode")
else if (obj_sprite.sprite_tlut[0] == -1 && global.basetlutnum == 0)
    draw_text(x+54+(width+2)/2, y+79+(height+1)/2, "No palette generated")
else
{
    var array = obj_sprite.sprite_tlut
    if (global.basetlutnum != 0)
        array = global.basetlut
    draw_rectangle(x+54, y+54, x+54+width, y+54+height, true)
    for (i=0; i<num; i+=1)
    {
        var posx, posy, r,g,b,a;
        if (array[i] == -1)
            break;
            
        // Get the coordinates
        posx = x+54+(i*size)%width
        posy = y+54+(floor(i/sqrt(num))*size)
        
        // Get the color
        r = (array[i] >> 24)&$000000FF
        g = (array[i] >> 16)&$000000FF
        b = (array[i] >> 8) &$000000FF
        a = (array[i])&$000000FF
        
        // Draw stuff
        draw_set_color(make_colour_rgb(r, g, b))
        if (!global.usealpha || a > 127)
            draw_rectangle(posx, posy, posx+size, posy+size, false)
        else
            draw_triangle(posx, posy, posx+size, posy, posx+size, posy+size, false)
        draw_set_color(c_black) 
        draw_rectangle(posx, posy, posx+size, posy+size, true)
        draw_set_color(c_white)
    }
}

draw_set_valign(fa_top)
draw_set_halign(fa_left)
draw_set_color(c_white)
