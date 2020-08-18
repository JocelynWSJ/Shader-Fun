#version 150

in vec2 fs_UV;

out vec3 color;

uniform sampler2D u_RenderedTexture;

void grey_vignett(in float distance, inout vec3 color) {
    float grey = 0.21 * color.r + 0.72 * color.g + 0.07 * color.b;
    color = vec3(grey, grey, grey) * (0.8-distance);
}

void main()
{
    // TODO Homework 5
    color = texture(u_RenderedTexture, fs_UV).rgb;
    float distance = sqrt((fs_UV.x - 0.5) * (fs_UV.x - 0.5) + (fs_UV.y - 0.5) * (fs_UV.y - 0.5));
    grey_vignett(distance, color);


}
