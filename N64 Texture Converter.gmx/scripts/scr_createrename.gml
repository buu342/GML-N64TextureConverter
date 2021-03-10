if (instance_number(obj_sprite) == 0)
    exit;

var obj = instance_create(self.x+88, self.y+32+8, obj_inputbox)
with (obj)
{
    width = 200
    text = global.filename
    execute = scr_input_filename
    popup = true
}

var obj = instance_create(self.x+88, self.y+64+8, obj_inputbox)
with (obj)
{
    width = 200
    text = global.arrayname
    execute = scr_input_arrayname
    popup = true
    dependonexecute = true
}
