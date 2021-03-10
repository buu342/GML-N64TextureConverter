self.stepspecial = scr_steppalette

var obj;
obj = instance_create(self.x+self.width/2, self.y+self.height-54, obj_button)
with (obj)
{
    width = 150
    popup = true
}
self.special[0] = obj
self.specialcount = 1

if (instance_number(obj_sprite) > 0 && obj_sprite.sprite_tlut[0] != -1)
{
    var obj;
    obj = instance_create(self.x+80, self.y+self.height-85, obj_button)
    with obj
    {
        icon = 1
        width = 112
        text = "Import Palette"
        popup = true
        execute = scr_import_pal_file
    }
    self.special[1] = obj
    
    var obj;
    obj = instance_create(self.x+self.width-80, self.y+self.height-85, obj_button)
    with obj
    {
        icon = 2
        width = 112
        text = "Export Palette"
        popup = true
        execute = scr_export_pal_file
    }
    self.special[2] = obj
    self.specialcount = 3
}
