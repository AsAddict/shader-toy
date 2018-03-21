
uniform sampler2D texture; // E:\Projects\shader-toy\prefilter.png

#extension GL_OES_standard_derivatives : enable

float distfunc(vec2 pos, vec2 offset) {

    pos = pos - offset;
    return length(pos) - 0.5;

}

float sdfRoundBox(vec2 coord,  vec2 center, float width, float height, float r)
{
    vec2 d = vec2(abs(coord - center)) - vec2(width, height);
    return min(max(d.x,d.y),0.0) + length(max(d,0.0)) - r;
}

const vec3 eyeLum = vec3( 0.299, 0.587, 0.114 );


void main() {

    vec2 st = gl_FragCoord.xy / iResolution.xy;
    float aspect = iResolution.x / iResolution.y;

    vec4 texture = texture2D(texture, st);
    // texture.rgb = vec3();

    st = st * 2.0 - 1.0;
    st.x *= aspect;

    float dist = sdfRoundBox(st, vec2(0.0, 0.0), 0.4, 0.2, 0.01);
    vec4 color = vec4(0.0);

    vec3 strokeColor = vec3(0.5, 0.6, 0.8);
    vec3 outlineColor = vec3(0.3, 0.3, 0.3);
    vec3 backgroundColor = vec3(0.0);

    float fw = fwidth(dist);
    vec4 stroke = vec4(strokeColor, 1.0 - smoothstep(-fw, fw, dist));

    float outlineThickness = 0.1;
    vec4 outline = vec4(outlineColor, 1.0 - smoothstep(-fw, fw, dist - 0.04));

    gl_FragColor = vec4(mix(backgroundColor, mix(outline.rgb, stroke.rgb, stroke.a), outline.a) , 1.0);

    // gl_FragColor = dist > fw ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0);
    //gl_FragColor = vec4(vec3(fw) * 100.0, 1.0);
}
