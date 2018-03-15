precision highp float;

float almostIdentity ( float x, float m, float n )
{
    if( x>m ) return x;
    float a = 2.0*n - m;
    float b = 2.0*m - 3.0*n;
    float t = x/m;
    return (a*t + b)*t*t + n;
}

float impulse( float k, float x )
{
    float h = k*x;
    return h*exp(1.0-h);
}

float plot (float y0, float y) {

    return smoothstep(y0 - 0.01, y0, y) - smoothstep(y0, y0 + 0.01, y);

}

void main() {

    vec2 st = gl_FragCoord.xy / u_resolution.xy;

    // float y = st.x;

    float y = almostIdentity(st.x, 0.1, 0.1);
    y = impulse(4.0, st.x);

    float plotLine = plot(y, st.y);

    gl_FragColor = vec4(vec3(plotLine), 1.0);

}
