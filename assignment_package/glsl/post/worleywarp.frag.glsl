#version 150

uniform ivec2 u_Dimensions;
uniform int u_Time;

in vec2 fs_UV;

out vec3 color;

uniform sampler2D u_RenderedTexture;

vec2 random2(vec2 p) {
    return fract(sin(vec2(dot(p, vec2(327.1, 211.7)),
                          dot(p, vec2(229.5,83.3)))) * 13758.5453);
}


float WorleyNoise(vec2 uv) {
    uv *= 350.0; // Now the space is 10x10 instead of 1x1. Change this to any number you want.
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
    // TODO Homework 5
    color = vec3(0, 0, 0);
    float h[9] = float[](3, 0, -3, 10, 0, -10, 3, 0, -3);
    float v[9] = float[](3, 10, 3, 0, 0, 0, -3, -10, -3);

    float dx = 1.0 / u_Dimensions.x;
    float dy = 1.0 / u_Dimensions.y;

    vec3 sum_hor = vec3(0, 0, 0);
    vec3 sum_ver = vec3(0, 0, 0);
    vec2 start_uv = fs_UV;
    start_uv.x = fs_UV.x - dx;
    start_uv.y = fs_UV.y - dy;

    for (int r = 0; r < 3; r++) {
        for (int c = 0; c < 3; c++) {
            //clamp to [0,1]
            if (start_uv.x < 0) {
                start_uv.x = 0;
            }
            if (start_uv.x > 1) {
                start_uv.x = 1;
            }
            if (start_uv.y < 0) {
                start_uv.y = 0;
            }
            if (start_uv.y > 1) {
                start_uv.y = 1;
            }
            vec3 v_color = texture(u_RenderedTexture, start_uv).rgb;
            sum_hor += v_color * h[3*r+c];
            sum_ver += v_color * v[3*r+c];

            start_uv.y += dy;
        }
        start_uv.x += dx;
        start_uv.y = fs_UV.y - dy;
    }

    vec3 sobel_color = vec3(sqrt(pow(sum_hor.x, 2)+pow(sum_ver.x, 2)),
                 sqrt(pow(sum_hor.y, 2)+pow(sum_ver.y, 2)),
                 sqrt(pow(sum_hor.z, 2)+pow(sum_ver.z, 2)));

    float dis = WorleyNoise(fs_UV);
    if (dis < 0.4) {
        vec3 real_color = texture(u_RenderedTexture, fs_UV).rgb;
        float temp = (real_color.x + real_color.y + real_color.z)/3;
        color = vec3(temp, temp, temp);
    } else if ((sobel_color.x + sobel_color.y + sobel_color.z) > 0.99) {
        float temp = 1- (sobel_color.x + sobel_color.y + sobel_color.z)/3;
        color = vec3(temp, temp, temp);
    } else {
        color = vec3(1, 1, 1);
    }



}
