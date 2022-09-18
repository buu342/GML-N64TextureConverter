//
// Simple passthrough fragment shader
//

struct VS_INPUT
{
    float4 vPos   : POSITION;
    //float4 vNormal : NORMAL; // Unused in this shader
    float4 vColor : COLOR;
    float2 vTexCoord : TEXCOORD0;
 
};

struct PS_INPUT
{
    float4 Position : POSITION;  // interpolated vertex position (system value)
    float4 Color    : COLOR;     // interpolated diffuse color
    float2 TexCoord : TEXCOORD0;
};

PS_INPUT main(VS_INPUT input)
{
    PS_INPUT Output;
    Output.Position = mul(gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION], input.vPos);
    Output.Color = input.vColor;
    Output.TexCoord = input.vTexCoord; 
    return Output;
}

/** GLSL
//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    vec4 object_space_pos = vec4(in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION]*object_space_pos;
    
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
}
*/
//######################_==_YOYO_SHADER_MARKER_==_######################@~//
// Simple grayscale fragment shader
//

struct PS_INPUT
{
    float4 Color    : COLOR;
    float2 TexCoord : TEXCOORD0;
};

struct PS_OUTPUT {
    float4 Color : COLOR;
};

PS_OUTPUT main(PS_INPUT In)
{
    float brightness;
    PS_OUTPUT Output;
    Output.Color = In.Color*tex2D(gm_BaseTexture, In.TexCoord);
    brightness = dot(float3(0.2989, 0.5870, 0.1140), float3(Output.Color.rgb));
    Output.Color.rgba = float4(brightness, brightness, brightness, 1.0);
    return Output;
}

/** GLSL
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main() 
{
    vec4 source = v_vColour*texture2D(gm_BaseTexture, v_vTexcoord);
    float brightness = dot(vec3(0.2989, 0.5870, 0.1140), source.rgb);
    gl_FragColor = vec4(vec3(brightness), source.a);
}
*/
