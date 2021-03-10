//argument0 = "In", "Out", "Reset"
if instance_exists(obj_sprite)
{
    if argument0 == "In" && global.zoom < 7
        global.zoom += 1
    else if argument0 == "Out" && global.zoom > 1
        global.zoom -= 1
    else if argument0 == "Reset"
    {
        global.zoom = 1
        view_xview[1] = view_wview[0]
        view_yview[1] = 0
    }

    view_wport[1] = obj_sprite.sprite_width*global.zoom
    view_wview[1] = obj_sprite.sprite_width
    if (obj_sprite.sprite_width*global.zoom > 640)
    {
        view_wview[1] = obj_sprite.sprite_width/(view_wport[1]/obj_sprite.sprite_width)
        view_wport[1] = 640
    }

    view_hport[1] = obj_sprite.sprite_height*global.zoom
    view_hview[1] = obj_sprite.sprite_height
    if (obj_sprite.sprite_height*global.zoom > 480)
    {
        view_hview[1] = obj_sprite.sprite_height/(view_hport[1]/obj_sprite.sprite_height)
        view_hport[1] = 480
    }
    
    // Prevent the view from escaping
    if (view_xview[1] < view_wview[0])
        view_xview[1] = view_wview[0]
    if (view_yview[1] < 0)
        view_yview[1] = 0 
    if ((view_xview[1]-view_wview[0])+view_wview[1] > obj_sprite.sprite_width)
        view_xview[1] = (view_wview[0]+obj_sprite.sprite_width)-view_wview[1]
    if (view_yview[1]+view_hview[1] > obj_sprite.sprite_height)
        view_yview[1] = obj_sprite.sprite_height-view_hview[1]
}
