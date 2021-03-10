var char;
var whitelist;

char = argument0;
whitelist[0] = '0'
whitelist[1] = '1'
whitelist[2] = '2'
whitelist[3] = '3'
whitelist[4] = '4'
whitelist[5] = '5'
whitelist[6] = '6'
whitelist[7] = '7'
whitelist[8] = '8'
whitelist[9] = '9'

var i;
for (i=0; i<9; i+=1)
    if (whitelist[i] == char)
        return true
return false
