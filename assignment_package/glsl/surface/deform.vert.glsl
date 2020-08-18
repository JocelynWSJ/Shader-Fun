#version 150

uniform mat4 u_Model;
uniform mat3 u_ModelInvTr;
uniform mat4 u_View;
uniform mat4 u_Proj;

uniform int u_Time;

in vec4 vs_Pos;
in vec4 vs_Nor;

out vec3 fs_Nor;

void main()
{
    // TODO Homework 4
    vec3 pos_dir = 2*normalize(vec3(vs_Pos)) - vec3(vs_Pos);
    vec4 d_Pos = smoothstep(0, 1, 0.5*(1+cos(u_Time*0.015))) * vec4(pos_dir, 0) + vs_Pos;

    fs_Nor = normalize(u_ModelInvTr * vec3(vs_Nor));

    vec4 modelposition = u_Model * d_Pos;
//    vec3 pos;
    gl_Position = u_Proj * u_View * modelposition;
//    vec3 dir = vec3(gl_Position);
//    //gl_Position = smoothstep(0, 1, 0.5*(1+cos(u_Time*0.015))) * vec4((normalize(dir) - dir), 0) + gl_Position;
//    gl_Position = smoothstep(gl_Position, vec4(fs_Nor*2, 1), normalize(u_Time*0.0015*vec4(1, 1, 1, 0)));
//    gl_Position = u_Proj * u_View * modelposition;


}
