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

// p：uv信息
// a:起点
// b:终点
// w:宽度
float segment(in vec2 p, in vec2 a, in vec2 b, in float w) {
    float f = 0.0;

    // 向量ba
    vec2 ba = b - a;
    // 向量pa
    vec2 pa = p - a;

    // dot(pa, ba) / dot(ba, ba) = pa 在ab上的投影的长度
    // proj 取 0到1 的部分，限制在起始点和终止点之间
    float proj = clamp(dot(pa, ba) / dot(ba, ba), 0.0, 1.0);

    // d 为 p到p’的距离
    float d = length(proj * ba - pa);
    if(d <= w) {
        f = 1.0;
    }
    return f;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fixUV(fragCoord);

    vec3 color = Grid(uv);
    
    vec3 line = vec3(segment(uv, vec2(1.0, 2.0), vec2(-2.0, -2.0), fwidth(uv.x)));

    vec3 red = vec3(1.0,0.0,0.0);

    color = mix(color,red,line);

    fragColor = vec4(color, 1.0);
}