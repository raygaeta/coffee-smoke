uniform float uTime;
uniform sampler2D uPerlinTexture;

varying vec2 vUv;

#include ../includes/rotate2D.glsl


void main()
{
    // Model matrix
    //Model Matrix: This matrix positions, scales, and rotates the model in the 3D world. It converts the model’s local coordinates (its own space) to world coordinates.
    //View MatrixView Matrix: This matrix positions and orients the camera in the world. It transforms world coordinates into the camera's view, essentially moving the whole world relative to the camera's position.
    vec3 newPosition = position;
    float perlinTwist = texture(uPerlinTexture,vec2(0.5, uv.y * 0.2- uTime * 0.005)).r;
    vec2 windOffset = vec2(
        texture(uPerlinTexture, vec2(0.25, uTime * 0.01)).r - 0.5,
        texture(uPerlinTexture, vec2(0.75, uTime * 0.01)).r - 0.5
    );      
    float angle = perlinTwist * 10.0;

    newPosition.xz = rotate2D(newPosition.xz,angle);
    windOffset *= 10.0 * pow(uv.y, 2.0);
    newPosition.xz += windOffset;

    gl_Position = projectionMatrix * viewMatrix * modelMatrix * vec4(newPosition,1.0);

    vUv = uv;
}