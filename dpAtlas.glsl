
uniform sampler2D texture; // E:\Projects\ShaderToy\prefilter.png

vec3 decodeRGBM(vec4 rgbm) {

    vec3 color = (8.0 * rgbm.a) * rgbm.rgb;
    return color * color;

}

void main () {

    vec2 uv = gl_FragCoord.xy / iResolution;
    vec3 color = decodeRGBM(texture2D(texture, uv));

    // color.r = 1.0;

    gl_FragColor = vec4(color, 1.0);

}
