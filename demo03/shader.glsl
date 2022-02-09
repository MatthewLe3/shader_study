// SDF

// 圆形   中心点在（0，0）
float sdfCircle(in vec2 p, float r) {
    return length(p) - r;
}

// 长方形   中心点在（0，0）
float sdfBox(in vec2 p, in vec2 b) {
    // p:坐标中的任意点
    // b：长方形右上角顶点的坐标

    // 将p点转移到第一象限
    // d为BP向量
    vec2 d = abs(p) - b;

    // p点在长方形外部：length(max(d,0.0)) + min(max(d.x,d.y),0.0) = length(max(d,0.0))
    // p点在长方形内部: length(max(d,0.0)) + min(max(d.x,d.y),0.0) = min(max(d.x,d.y),0.0)
    return length(max(d, 0.0)) + min(max(d.x, d.y), 0.0);
}

// 菱形   中心点在（0，0），四个顶点在坐标轴上
// b.x = 与x轴正半轴交点    b.y = 与y轴正半轴交点

float ndot(vec2 a, vec2 b) {
    return a.x * b.x - a.y * b.y;
}

float sdRhombus(in vec2 p, in vec2 b) {

    // 坐标轴对称

    // p点转移到第一象限
    vec2 q = abs(p);

    // 计算线段b（AB）的中点到p点的向量，在b上的的投影，限制在 -1到1
    // 负数偏向于y轴，正数偏向于x轴
    float h = clamp((-2.0 * ndot(q, b) + ndot(b, b)) / dot(b, b), -1.0, 1.0);

    // 实际上h从-1到1的滑动过程，[0.5*b*vec2(1.0-h,1.0+h)] 表示一条从原点出发，终点在向量b上由左上到右下的滑动的向量
    float d = length(q - 0.5 * b * vec2(1.0 - h, 1.0 + h));

    // 符号：可计算(b.x, -b.y)和(p.x, p.y-b.y)的叉积，得两向量的相对位置
    return d * sign(q.x * b.y + q.y * b.x - b.x * b.y);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {

    vec3 color = vec3(0.0, 0.0, 0.0);

    fragColor = vec4(color, 1.0);
}