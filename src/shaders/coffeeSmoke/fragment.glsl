uniform sampler2D uPerlinTexture;
uniform float uTime;

varying vec2 vUv;

void main()
{
    vec2 smokeUv = vUv;
    smokeUv.x *= 0.5;
    smokeUv.y *= 0.3;
    //UV scrolling
    smokeUv.y -= uTime * 0.03;
    float smoke = texture(uPerlinTexture, smokeUv).r;

    // make larger dark areas
    smoke = smoothstep(0.4,1.0,smoke);


    // blur edges
    smoke *= smoothstep(0.0,0.1,vUv.x);
    smoke *= smoothstep(1.0,0.9,vUv.x);
    smoke *= smoothstep(0.0,0.1,vUv.y);
    smoke *= smoothstep(1.0,0.4,vUv.y);
    
    gl_FragColor = vec4(1.0,1.0,1.0,smoke);
    // gl_FragColor = vec4(1.0,0.0,0.0,smoke);
    #include <tonemapping_fragment>
    #include <colorspace_fragment>
}