var i;
var cols = 0;

// Open a file
fname = get_open_filename("N64 Palette files (*.npl)|*.npl", "")

// If we opened a file
if fname != ""
{
    var fid = file_text_open_read(fname);
    
    // Read the header
    var head = file_text_read_string(fid);
    if (head != "NPL")
    {
        with(obj_popup) instance_destroy()
        scr_create_popup("This is not an NPL Palette file.", "Error", 232, 126, snd_criticalerror, 2);
        exit;
    }
    
    // Read the palette colors into the tlut array
    for (i=0; i<256; i++)
    {
        if (file_text_eof(fid))
            break;
        file_text_readln(fid);
        obj_sprite.sprite_tlut[i] = hex_to_dec(file_text_read_string(fid));
        cols = cols+1;
    }
    
    // Close the file
    file_text_close(fid);
    scr_update_sprite_tlut()
    
    // Warn if the number of colors mismatch
    if (obj_sprite.ntlut < cols)
    {
        with(obj_popup) instance_destroy()
        scr_create_popup("The imported palette is smaller than the current image.", "Warning", 300, 126, snd_error, 1);
    }
    if (obj_sprite.ntlut > cols)
    {
        with(obj_popup) instance_destroy()
        scr_create_popup("The imported palette is larger than the current image.", "Warning", 300, 126, snd_error, 1);
    }
    
    // Modify the image so that the colors match
}
