#version 330

uniform sampler2D u_Texture; // The texture to be read from by this shader
uniform int u_Time;
uniform vec3 u_Look;

in vec3 fs_Nor;

layout(location = 0) out vec3 out_Col;

void main()
{
    // TODO Homework 4
    float t = dot(fs_Nor, u_Look);
    float PI = 3.141592653;
    out_Col.x = 0.5 + 0.5 * cos(4 * PI * (t + u_Time*0.0015 + 0.1));
    out_Col.y = 0.5 + 0.5 * cos(4 * PI * (t + u_Time*0.0015 + 0.3));
    out_Col.z = 0.5 + 0.5 * cos(4 * PI * (t + u_Time*0.0015 + 0.5));



}
