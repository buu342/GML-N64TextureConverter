/// dec_to_hex(dec)
//
//  Returns a string of hexadecimal digits (4 bits each)
//  representing the given decimal integer. Hexadecimal
//  strings are padded to byte-sized pairs of digits.

var dec, hex, h, byte, hi, lo;
dec = argument[0];
if (dec) hex = "" else hex="00";
h = "0123456789ABCDEF";
while (dec) {
    byte = dec & 255;
    hi = string_char_at(h, byte div 16 + 1);
    lo = string_char_at(h, byte mod 16 + 1);
    hex = hi + lo + hex;
    dec = dec >> 8;
}

// Pad extra 0's if asked to do so
if (argument_count > 1)
{
    var k, len;
    len = argument[1]-(string_length(hex)/2)
    for (k=0; k<len; k+=1)
        hex = string_insert("00", hex, 0)
}

return hex;
