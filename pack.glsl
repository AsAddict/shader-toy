
vec4 packFloatToVec4i(const float value) {
    // value should be in the range [0.0, 1.0];

    float fract_256 = fract(value * 256.0);
    float fract_256_256 = fract(value * 256.0 * 256.0);
    float fract_256_256_256 = fract(value * 256.0 * 256.0 * 256.0);

    vec4 rgba;
    rgba.a = value - fract_256 / 256.0;
    rgba.b = fract_256 - fract_256_256 / 256.0;
    rgba.g = fract_256_256 - fract_256_256_256 / 256.0;
    rgba.r = fract(value * 256.0 * 256.0 * 256.0);
    return rgba;

}

float unpackFloatFromVec4i(const vec4 rgba) {
    float value = rgba.a +
                  rgba.b / 256.0 +
                  rgba.g / (256.0 * 256.0) +
                  rgba.r / (256.0 * 256.0 * 256.0);

    return value;
}

void main () {
    
    vec2 st = (gl_FragCoord.xy / u_resolution.xy);

    float testValue = 0.981;

    vec4 rgba = packFloatToVec4i(testValue);

    float error = abs(unpackFloatFromVec4i(rgba) - testValue);

    if (error < 1e-20) {

        gl_FragColor = vec4(1.0, 0.0, 0.0, 1.0);

    } else {

        gl_FragColor = vec4(0.0, 0.0, 0.0, 1.0);
    }

}
