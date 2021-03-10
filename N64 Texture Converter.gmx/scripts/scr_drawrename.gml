draw_set_color(c_black)
if (!instance_exists(obj_sprite))
{
    draw_set_halign(fa_center)
    draw_set_valign(fa_middle)
    draw_text(x+(self.width)/2, y+(self.height)/2, "No image loaded")
}
else
{
    draw_set_font(fnt_button)
    draw_text(self.x+10, self.y+32+8+3, "Filename:")
    draw_text(self.x+10, self.y+64+8+3, "Array name:")
    draw_set_font(fnt_default)
}

draw_set_valign(fa_top)
draw_set_halign(fa_left)
draw_set_color(c_white)
