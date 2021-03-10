var i;

// Open a file
fname = get_save_filename("N64 Palette files (*.npl)|*.npl", "")

// If we opened a file
if fname != ""
{
    var fid = file_text_open_write(fname);
    
    // Write the header
    file_text_write_string(fid, "NPL");
    
    // Write the palette colors to it
    for (i=0; i<256; i++)
    {
        if (obj_sprite.sprite_tlut[i] == -1)
            break;
        file_text_writeln(fid);
        file_text_write_string(fid, dec_to_hex(obj_sprite.sprite_tlut[i]));
    }
    
    // Close the file
    file_text_close(fid);
}
