#version 330

uniform sampler2D u_Texture; // The texture to be read from by this shader

in vec3 fs_Nor;

layout(location = 0) out vec3 out_Col;

void main()
{
    // TODO Homework 4
    vec2 nUV;
    nUV.x = 0.5 + 0.5 * dot(fs_Nor, vec3(1, 0, 0));
    nUV.y = 0.5 + 0.5 * dot(fs_Nor, vec3(0, 1, 0));
    out_Col = vec3(texture(u_Texture, nUV).rgb);
}
