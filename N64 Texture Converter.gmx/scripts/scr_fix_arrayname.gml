var i;
var str, final;
str = argument0
str = string_replace_all(str, ' ', '_')
str = string_replace_all(str, '-', '_')

if (string_digits(str) == str)
    return "image"
else
{
    while (scr_isnumber(string_char_at(str, 0)))
        str = string_replace(str, string_char_at(str, 0), "")
}

final = string_copy(str, 0, string_length(str))

for (i=0; i<string_length(str); i+=1)
{
    var char_at, validity;
    char_at = string_char_at(str, i);
    validity = scr_validcharacter(char_at)
    if (validity != "" && validity != "_")
        final = string_replace_all(final, validity, '')
}

if final == ""
    return "image"
return final
