var file = argument0
var type = argument1
var wsize = argument2, hsize = argument3;
var append = "";

if (global.chunk)
    append = " (Split into "+string(global.chunkval[0])+"x"+string(global.chunkval[1])+" chunks)"

file_text_write(file, "// Generated by Nintendo 64 Texture Converter");
file_text_write(file, "\n");
file_text_write(file, "// By buu342");
file_text_write(file, "\n");
file_text_write(file, "// Size = "+string(wsize)+"x"+string(hsize)+append);
file_text_write(file, "\n");
file_text_write(file, "// Type = "+type);
