vec3 Grid(vec2 uv) {
    vec3 color = vec3(0.0);
    vec2 fraction = 1.0 - 2.0 * abs(fract(uv) - 0.5);

    // fwidth 单位像素宽度
    if(abs(uv.x) <= 2.0 * fwidth(uv.x)) {
        color.g = 1.0;
    } else if(abs(uv.y) <= 2.0 * fwidth(uv.y)) {
        color.r = 1.0;
    } else if(fraction.x < 2.0 * fwidth(uv.x) || fraction.y < 2.0 * fwidth(uv.y)) {
        color = vec3(1.0);
    }

    return color;
}

vec2 fixUV(in vec2 c) {
    return 3.0 * (2.0 * c - iResolution.xy) / min(iResolution.x, iResolution.y);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fixUV(fragCoord);

    fragColor = vec4(Grid(uv), 1.0);
}