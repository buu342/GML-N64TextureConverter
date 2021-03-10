var popup = scr_create_popup("", "Rename", 300, 144, snd_ding, -1)
with (popup)
{
    createextra = scr_createrename
    drawextra = scr_drawrename
}
