var popup = scr_create_popup("", "Palette", 300, 350, snd_ding, -1)
with (popup)
{
    createextra = scr_createpalette
    stepspecial = scr_steppalette
    drawextra = scr_drawpalette
}
