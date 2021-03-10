var result=0;

for (var i=1; i<=string_length(argument0); i++)
{
    var c = ord(string_char_at(string_upper(argument0), i));
    result = result<<4;
    switch (c)
    {
        case ord("0"):
        case ord("1"):
        case ord("2"):
        case ord("3"):
        case ord("4"):
        case ord("5"):
        case ord("6"):
        case ord("7"):
        case ord("8"):
        case ord("9"):
            result = result + (c-ord("0"))
            break;
        case ord("A"):
        case ord("B"):
        case ord("C"):
        case ord("D"):
        case ord("E"):
        case ord("F"):
            result = result + (c-ord("A")+10);
            break;
    }
}
 
return result;
