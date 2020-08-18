#version 330

uniform sampler2D u_Texture; // The texture to be read from by this shader

in vec4 fs_Nor;
in vec4 fs_LightVec;

layout(location = 0) out vec3 out_Col;

void main()
{
    // TODO Homework 4
    float t = dot(fs_Nor, fs_LightVec);
    float PI = 3.141592653;
    out_Col.y = 0.5 + 0.5 * cos(4 * PI * (t + 0.33));
    out_Col.z = 0.5 + 0.5 * cos(4 * PI * (t + 0.67));
    out_Col.x = 0.5 + 0.5 * cos(4 * PI * t);

}
