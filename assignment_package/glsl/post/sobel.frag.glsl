#version 150

in vec2 fs_UV;

out vec3 color;

uniform sampler2D u_RenderedTexture;
uniform int u_Time;
uniform ivec2 u_Dimensions;

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

    color = vec3(sqrt(pow(sum_hor.x, 2)+pow(sum_ver.x, 2)),
                 sqrt(pow(sum_hor.y, 2)+pow(sum_ver.y, 2)),
                 sqrt(pow(sum_hor.z, 2)+pow(sum_ver.z, 2)));
}
