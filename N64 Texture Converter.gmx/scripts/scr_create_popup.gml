var popup;
popup = instance_create(room_width/2-argument2/2, room_height/2-argument3/2, obj_popup)
with (popup)
{
    text = argument0
    title = argument1
    width = argument2
    height = argument3
    sound = argument4
    icon = argument5
}
return popup;
