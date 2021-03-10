// Argument0 - The file to write to
// Argument1 - The text to write

if (argument1 == "\n")
    FS_file_text_writeln(argument0)
else
    FS_file_text_write_string(argument0, argument1)
