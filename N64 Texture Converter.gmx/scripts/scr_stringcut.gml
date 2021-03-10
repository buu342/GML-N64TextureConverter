var str, len, final;
str = argument0
len = argument1
final = ""

var i;
for (i=0; i<string_length(str)+1; i+=1)
{
    final = string_copy(str, 0, i)
    if (string_width(final) > (len+string_width("...")))
    {
        final = string_copy(final, 0, i-1)+"..."
        return final;
    }
}
return final;
