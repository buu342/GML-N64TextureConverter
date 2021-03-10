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
    scr_clear_basepal()
    for (i=0; i<256; i++)
    {
        var j, k;
        if (file_text_eof(fid))
            break;
        file_text_readln(fid);
        global.basetlut[cols] = hex_to_dec(file_text_read_string(fid))
        cols = cols+1;
    }
    
    // Close the file
    file_text_close(fid);
    global.basetlutnum = cols
}
