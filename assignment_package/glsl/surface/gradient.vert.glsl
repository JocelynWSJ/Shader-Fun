#version 150

uniform mat4 u_Model;
uniform mat3 u_ModelInvTr;
uniform mat4 u_View;
uniform mat4 u_Proj;
uniform vec3 u_Look;

in vec4 vs_Pos;
in vec4 vs_Nor;

out vec4 fs_Nor;
out vec4 fs_LightVec;

void main()
{
    // TODO Homework 4
    fs_Nor = vec4(normalize(u_ModelInvTr * vec3(vs_Nor)), 0);
    //fs_Nor = vs_Nor;

    vec4 modelposition = u_Model * vs_Pos;

    //fs_LightVec = vec4(0, 0, -1, 0);
    fs_LightVec = vec4(u_Look, 0);

    gl_Position = u_Proj * u_View * modelposition;
}
