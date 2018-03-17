
float plot (float x, float y, float funcY, float width) {

    return smoothstep(funcY - width, funcY, y) - smoothstep(funcY, funcY + width, y);

}

const vec3 purple = vec3(108, 93, 142) / 255.0;
const vec3 orange = vec3(228, 80, 14) / 255.0;
const float PI = 3.1415926;

void main() {

    vec2 st = gl_FragCoord.xy / iResolution.xy;
    float aspect = iResolution.x / iResolution.y;

    vec3 gradientBackgournd = vec3(st.x);
    float funcY = sin(st.x * 7.0) / 7.0 + 0.44;

    vec3 color1 = step(funcY, st.y) * mix(orange, purple, smoothstep(funcY, 1.0, st.y));
    vec3 color2 = mix(orange, purple, 0.0);

    float boundary = plot(st.x, st.y, funcY, 0.05);
    vec3 color = mix(color1, vec3(0.2, 0.0, 0.0), boundary);

    //vec4(mix(gradientBackgournd, vec3(1.0, 0.0, 0.0), , 1.0);

    gl_FragColor = vec4(color, 1.0);
}
