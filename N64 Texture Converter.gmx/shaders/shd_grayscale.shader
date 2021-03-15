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
