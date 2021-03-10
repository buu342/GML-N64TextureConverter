// Argument0 - The grid to add to
// Argument1 - The column to add to
// ...       - The values to add

var i;
for (i=0; i<argument_count-2; i+=1)
    ds_grid_add(argument[0], i, argument[1], argument[i+2])
