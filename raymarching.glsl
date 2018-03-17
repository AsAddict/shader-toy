const int MAX_ITER = 100; // 100 is a safe number to use, it won't produce too many artifacts and still be quite fast
const float MAX_DIST = 20.0; // Make sure you change this if you have objects farther than 20 units away from the camera
const float EPSILON = 0.001; // At this distance we are close enough to the object that we have essentially hit it

float distfunc(vec3 pos) {

    return length(pos) - 1.0;

}

const vec3 cameraOrigin = vec3(0.0, 0.0, 10.0);
vec3 cameraTarget = vec3(0.0, 0.0, 0.0);
vec3 cameraUp = vec3(0.0, 1.0, 0.0);
const float near = 1.0;


vec3 getRay() {

    vec2 screenPos = (gl_FragCoord.xy / u_resolution.xy);

    float aspect = u_resolution.x / u_resolution.y;

    screenPos = screenPos * 2.0 - 1.0; // -1.0 to 1.0
    vec3 dir = normalize(cameraTarget - cameraOrigin);
    vec3 right = cross(dir, cameraUp);

    vec3 ray = right * screenPos.x * aspect + cameraUp * screenPos.y + dir * near;
    ray = normalize(ray);
    return ray;

}

void main () {

    float totalDist = 0.0;
    vec3 pos = cameraOrigin;
    float dist = EPSILON;
    vec3 rayDir = getRay();

    for (int i = 0; i < MAX_ITER; i++) {

        // Either we've hit the object or hit nothing at all, either way we should break out of the loop
        if (dist < EPSILON || totalDist > MAX_DIST)
            break; // If you use windows and the shader isn't working properly, change this to continue;

        dist = distfunc(pos); // Evalulate the distance at the current point
        totalDist += dist;
        pos += dist * rayDir; // Advance the point forwards in the ray direction by the distance

    }

    if (dist < EPSILON) {

        gl_FragColor = vec4(0.2, 0.34, 0.9, 1.0);

    } else {

        gl_FragColor = vec4(0.0);

    }

}
