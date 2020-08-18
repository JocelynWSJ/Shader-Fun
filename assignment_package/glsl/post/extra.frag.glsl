#version 150

in vec2 fs_UV;

out vec3 color;

uniform sampler2D u_RenderedTexture;
uniform int u_Time;
uniform ivec2 u_Dimensions;

vec2 random2(vec2 p) {
    return fract(sin(vec2(dot(p, vec2(327.1, 211.7)),
                          dot(p, vec2(229.5,83.3)))) * 13758.5453);
}


float WorleyNoise(vec2 uv) {
    uv *= 200.0; // Now the space is 10x10 instead of 1x1. Change this to any number you want.
    vec2 uvInt = floor(uv);
    vec2 uvFract = fract(uv);
    float minDist = 1.0; // Minimum distance initialized to max.
    for(int y = -1; y <= 1; ++y) {
        for(int x = -1; x <= 1; ++x) {
            vec2 neighbor = vec2(float(x), float(y)); // Direction in which neighbor cell lies
            vec2 point = random2(uvInt + neighbor); // Get the Voronoi centerpoint for the neighboring cell
            vec2 diff = neighbor + point - uvFract; // Distance between fragment coord and neighbor’s Voronoi point
            float dist = length(diff);
            minDist = min(minDist, dist);
        }
    }
    return minDist;
}


void main()
{
    float dis = WorleyNoise(fs_UV);
    vec2 dir = vec2(0.5, 0.5) - fs_UV;
    vec2 new_UV = fs_UV + dis*sin(u_Time*0.01)*dir/2;
    color = texture(u_RenderedTexture, new_UV).rgb;

}
