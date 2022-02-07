vec3 NumberPlane(vec2 uv) {
    vec3 color = vec3(0.0);

    vec2 ceil = fract(uv);
    // fwidth 单位像素宽度
    if(ceil.x <= fwidth(uv.x)) {
        color = vec3(1.0);
    }
    if(ceil.y <= fwidth(uv.y)) {
        color = vec3(1.0);
    }

    return color;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = 3.0 * (2.0 * fragCoord - iResolution.xy) / min(iResolution.x, iResolution.y);

    fragColor = vec4(NumberPlane(uv), 1.0);
}