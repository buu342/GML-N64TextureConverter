// Argument0 - The X coordinate in the sprite_color array
// Argument1 - The Y coordinate in the sprite_color array
        
var texel1, texel2, nextx;
var R1, G1, B1, R2, G2, B2;
var V1, V2, U1, U2;
var U, Y1, V, Y2;

// Grab the first texel
texel1 = obj_sprite.sprite_color[argument0, argument1]
nextx = argument0+1
if (argument0%2 != 0)
{
    texel1 = obj_sprite.sprite_color[argument0-1, argument1]
    nextx = argument0
}
    
// Grab the second texel
if (nextx > obj_sprite.sprite_width-1)
    texel2 = 0
else
    texel2 = obj_sprite.sprite_color[nextx, argument1]

// Extract the RGB values from the texels
R1 = (texel1>>24)&$FF
G1 = (texel1>>16)&$FF
B1 = (texel1>>8)&$FF
R2 = (texel2>>24)&$FF
G2 = (texel2>>16)&$FF
B2 = (texel2>>8)&$FF

// Calculate the Y values
Y1 = clamp(round((0.257 * R1) + (0.504 * G1) + (0.098 * B1) + 16), 0, 255);
Y2 = clamp(round((0.257 * R2) + (0.504 * G2) + (0.098 * B2) + 16), 0, 255);

// Calculate the helper values for UV
V1 =  (0.439*R1) - (0.368*G1) - (0.071*B1) + 128;
U1 = -(0.148*R1) - (0.291*G1) + (0.439*B1) + 128;
V2 =  (0.439*R2) - (0.368*G2) - (0.071*B2) + 128;
U2 = -(0.148*R2) - (0.291*G2) + (0.439*B2) + 128;

// Calculate the final UV values
U = clamp(round((U1 + U2)/2.0), 0, 255);
V = clamp(round((V1 + V2)/2.0), 0, 255);

// Return the calculated YUV value
return (U<<24)|(Y1<<16)|(V<<8)|Y2
