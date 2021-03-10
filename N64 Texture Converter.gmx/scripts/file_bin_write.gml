// Argument0 - The file to write to
// Argument1 - The value to write
// Argument2 - The size (in bytes) to write

if (argument1 == "\n")
    exit;

// Swap the endianness
var v = 0;
switch (argument2)
{
    case 4:
        v |= (argument1<<24)&$FF000000;
        v |= (argument1<<8)&$00FF0000;
        v |= (argument1>>8)&$0000FF00;
        v |= (argument1>>24)&$000000FF;
        break;
    case 2: 
        v |= (argument1<<8)&$FF00;
        v |= (argument1>>8)&$00FF;
        break;
    case 1: 
        v = argument1;
        break;
}
 
// Write to the binary file   
switch (argument2)
{
    case 1: FS_file_bin_write_byte(argument0, v) break;
    case 2: FS_file_bin_write_word(argument0, v) break;
    case 4: FS_file_bin_write_dword(argument0, v) break;
}
