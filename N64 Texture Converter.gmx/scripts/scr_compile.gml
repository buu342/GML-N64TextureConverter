// Check if the button works
if (argument_count != 0 && argument[0] == 1)
{
    if (!instance_exists(obj_sprite))
        return -1
    return 0
}

var i, j;
var func_open, func_close, func_write; 
var img_write, byte_size, writetlut = false;
var file, extension, type, block, blockcount;
var outputw, outputh;

// Check if in CI mode
if ((global.exporttype == "8B-CI" || global.exporttype == "4B-CI") && (obj_sprite.sprite_tlut[0] == -1 && global.basetlutnum == 0))
{
    scr_create_popup("Missing image palette.", "Error", 232, 126, snd_criticalerror, 2)
    exit;
}

// Check if there is a color mismatch with the base TLUT
if ((global.exporttype == "8B-CI" || global.exporttype == "4B-CI") && global.basetlutnum != 0)
{
    for (j=0; j<obj_sprite.sprite_height; j++)
    {
        for (i=0; i<obj_sprite.sprite_width; i++)
        {
            if (find_basetlut(i, j) == -1)
            {
                scr_create_popup("Base palette color mismatch.", "Error", 232, 126, snd_criticalerror, 2)
                exit;
            }
        }
    }
}

// Ask for the directory to save the file to
if (global.exportlocation == -1)
    global.exportlocation = GMSF_open_directory("Save Location", program_directory)
if (global.exportlocation == "")
{
    scr_create_popup("Unable to open file path", "Error", 232, 126, snd_criticalerror, 2)
    global.exportlocation = -1
    exit;
}

// Get the save types
switch(global.exporttype)
{
    case ("32B-RGBA"):
        byte_size = 4
        img_write = scr_write_rgba32
        type = "32-Bit RGBA (G_IM_FMT_RGBA | G_IM_SIZ_32b)"
        break;
    case ("16B-RGBA"):
        byte_size = 2
        img_write = scr_write_rgba16
        type = "16-Bit RGBA (G_IM_FMT_RGBA | G_IM_SIZ_16b)"
        break;
    case ("8B-CI"):
        writetlut = true;
        byte_size = 1
        img_write = scr_write_ci8
        type = "8-Bit CI (G_IM_FMT_CI | G_IM_SIZ_8b)"
        break;
    case ("4B-CI"):
        writetlut = true;
        byte_size = 1
        img_write = scr_write_ci4
        type = "4-Bit CI (G_IM_FMT_CI | gDPLoadTexture*_4b)"
        break;
    case ("16B-IA"):
        byte_size = 2
        img_write = scr_write_ia16
        type = "16-Bit IA (G_IM_FMT_IA | G_IM_SIZ_16b)"
        break;
    case ("8B-IA"):
        byte_size = 1
        img_write = scr_write_ia8
        type = "8-Bit IA (G_IM_FMT_IA | G_IM_SIZ_8b)"
        break;
    case ("8B-I"):
        byte_size = 1
        img_write = scr_write_i8
        type = "8-Bit I (G_IM_FMT_I | G_IM_SIZ_8b)"
        break;
    case ("4B-IA"):
        byte_size = 1
        img_write = scr_write_ia4
        type = "4-Bit IA (G_IM_FMT_IA | gDPLoadTexture*_4b)"
        break;
    case ("4B-I"):
        byte_size = 1
        img_write = scr_write_i4
        type = "4-Bit I (G_IM_FMT_I | gDPLoadTexture*_4b)"
        break;
    case ("16B-YUV"):
        byte_size = 4
        img_write = scr_write_yuv16
        type = "16-Bit YUV (G_IM_FMT_YUV | G_IM_SIZ_16b)"
        break;
}

// Set the file extension and script pointers
switch (global.exportfile)
{
    case "H": 
        extension = "h"
        func_open = file_text_start
        func_write = file_text_write
        func_close = file_text_finish
        break;
    case "CH": 
        extension = "c"
        func_open = file_text_start
        func_write = file_text_write
        func_close = file_text_finish
        break;
    case "B": 
        extension = "bin"
        func_open = file_bin_start
        func_write = file_bin_write
        func_close = file_bin_finish
        break;
}

// Calculate the final size
if (global.powertwo)
{
    outputw = power(2, ceil(log2(obj_sprite.sprite_width)))
    outputh = power(2, ceil(log2(obj_sprite.sprite_height)))
}
else
{
    outputw = obj_sprite.sprite_width
    outputh = obj_sprite.sprite_height
}

// Calculate the number of blocks to write
if (global.chunk)
{
    var count = 0;
    var wcount = 1;
    var hcount = 1;
    blockcount = ceil((outputw*outputh)/(global.chunkval[0]*global.chunkval[1]))
    block = ds_grid_create(5, blockcount)
    for (j=0; j<outputh; j+=global.chunkval[1])
    {
        for (i=0; i<outputw; i+=global.chunkval[0])
        {
            var filename = global.arrayname+string(wcount)+"_"+string(hcount)
            if (global.exportfile == "B")
                filename = global.filename+string(wcount)+"_"+string(hcount)
            ds_grid_add_multiple(block, count, filename, i, j, i+global.chunkval[0], j+global.chunkval[1])
            count += 1;
            wcount += 1
        }
        wcount = 1;
        hcount += 1;
    }
}
else
{
    var filename = global.arrayname;
    blockcount = 1
    block = ds_grid_create(5, blockcount)
    if (global.exportfile == "B")
        filename = global.filename;
    ds_grid_add_multiple(block, 0, filename, 0, 0, outputw, outputh)
}

// Open a file for writing
if (global.exportfile == "B")
    file = script_execute(func_open, global.exportlocation+"\"+ds_grid_get(block, 0, 0)+"."+extension);
else
    file = script_execute(func_open, global.exportlocation+"\"+global.filename+"."+extension);

// Write the header
if (global.exportfile != "B")
{
    scr_write_headercomment(file, type, outputw, outputh);
    if (global.exportfile == "CH")
    {
        script_execute(func_write, file, "\n");
        script_execute(func_write, file, "\n");
        script_execute(func_write, file, "#include <ultra64.h>");
        script_execute(func_write, file, "\n");
        script_execute(func_write, file, "#include "+chr(34)+global.filename+".h"+chr(34));
    }
}

// Write the image to the file
for (i=0; i<ds_grid_height(block); i+=1)
{
    var finalname = ds_grid_get(block, 0, i);
    if (global.exportfile != "B")
    {
        switch(byte_size)
        {
            case 1: finalname = "u8 "+finalname break;
            case 2: finalname = "u16 "+finalname break;
            case 4: finalname = "u32 "+finalname break;
        }
            
        // Store the name for later (Exporting the .h if needed)
        ds_grid_set(block, 0, i, finalname);
    }

    // Write the array name
    if (global.exportfile != "B")
    {       
        finalname = finalname+"[] = {"
        script_execute(func_write, file, "\n");
        script_execute(func_write, file, "\n");
        if (global.usedummy)
        {
            script_execute(func_write, file, "static Gfx "+ds_grid_get(block, 0, i)+"_C_dummy_aligner1[] = { gsSPEndDisplayList() };");
            script_execute(func_write, file, "\n");
        }
        script_execute(func_write, file, finalname);
        script_execute(func_write, file, "\n");
    }
    
    // Dump the image block
    script_execute(img_write, file, func_write, ds_grid_get(block, 1, i), ds_grid_get(block, 2, i), ds_grid_get(block, 3, i), ds_grid_get(block, 4, i), byte_size);
    
    // Close and open a new binary file, or write the end of the array
    if (global.exportfile == "B" && i+1 < ds_grid_height(block))
    {
        script_execute(func_close, file);
        file = script_execute(func_open, global.exportlocation+"\"+ds_grid_get(block, 0, i+1)+".bin");   
    }
    else if (global.exportfile != "B")
    {
        script_execute(func_write, file, "};");
    }
}

// Write the TLUT
if (writetlut)
{
    var tlut = obj_sprite.sprite_tlut;
    if (global.basetlutnum != 0)
        tlut = global.basetlut;
    
    if (global.exportfile == "B")
    {
        script_execute(func_close, file);
        file = script_execute(func_open, global.exportlocation+"\"+global.filename+"_tlut.bin");   
    }
    else
    {
        script_execute(func_write, file, "\n");
        if (global.usedummy)
        {
            script_execute(func_write, file, "static Gfx "+global.arrayname+"_tlut_C_dummy_aligner1[] = { gsSPEndDisplayList() };");
            script_execute(func_write, file, "\n");
        }
        script_execute(func_write, file, "u16 "+global.arrayname+"_tlut[]= {");
        script_execute(func_write, file, "\n");
        script_execute(func_write, file, "    ");
    }
    
    for (i=0; i<256; i+=1)
    {
        if (tlut[i] == -1)
            break;
        
        if (global.exportfile == "B")
            script_execute(func_write, file, RGBA_32B_to_16B(tlut[i]), 2);
        else
            script_execute(func_write, file, "0x"+string(dec_to_hex(RGBA_32B_to_16B(tlut[i]), 2))+", ");
    }
    
    if (global.exportfile != "B")
    {
        script_execute(func_write, file, "\n");
        script_execute(func_write, file, "};");
    }
}

// Close the file
script_execute(func_close, file);

// Create the header file if needed
if (global.exportfile == "CH")
{
    file = script_execute(func_open, global.exportlocation+"\"+global.filename+".h");
    script_execute(func_write, file, "#ifndef "+global.arrayname+"_header");
    script_execute(func_write, file, "\n");
    script_execute(func_write, file, "#define "+global.arrayname+"_header");
    script_execute(func_write, file, "\n");
    script_execute(func_write, file, "\n");
    
    for (i=0; i<ds_grid_height(block); i+=1)
    {
        script_execute(func_write, file, "    extern "+ds_grid_get(block, 0, i)+"[];");
        script_execute(func_write, file, "\n");
    }
    
    if (writetlut)
    {
        script_execute(func_write, file, "\n");
        script_execute(func_write, file, "    extern u16 "+global.arrayname+"_tlut[];");
        script_execute(func_write, file, "\n");
    }
    
    script_execute(func_write, file, "\n");
    script_execute(func_write, file, "#endif");
    script_execute(func_close, file);
}

// Free the memory used by the grid
ds_grid_destroy(block);

scr_create_popup("Image exported successfully.", "Success", 232, 126, snd_ding, 0)
