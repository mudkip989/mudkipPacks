#version 150

uniform sampler2D DiffuseSampler;
uniform sampler2D DiffuseDepthSampler;
uniform sampler2D ControlSampler;
uniform sampler2D PrevSampler;
uniform vec2 OutSize;
uniform float Time;


in vec2 texCoord;
in vec2 oneTexel;

out vec4 fragColor;


float noise(vec2 pos, float evolve) {
    
    // Loop the evolution (over a very long period of time).
    float e = fract((evolve*0.01));
    
    // Coordinates
    float cx  = pos.x*e;
    float cy  = pos.y*e;
    
    // Generate a "random" black or white value
    return fract(23.0*fract(2.0/fract(fract(cx*2.4/cy*23.0+pow(abs(cy/22.4),3.3))*fract(cx*evolve/pow(abs(cy),0.050)))));
}

// float texTime(vec4 colore){
//     float red = colore.r * 255 * 255 * 255 * 255;
//     float green = colore.g * 255 * 255 * 255;
//     float blue = colore.b * 255 * 255;
//     float alpha = colore.b * 255;
//     return (red + green + blue + alpha)/10000;
// }

void main() {
    vec4 prev_color  = texture(DiffuseSampler, texCoord);
    vec4 overlay;
	fragColor = prev_color;

    // Channel #1
    vec4 control_color = texelFetch(ControlSampler, ivec2(0, 1), 0);
    switch(int(control_color.b * 255.)) {
            

        case 1:
            // Phosphor
            vec3 Phosphor = vec3(1,1,1);
            vec4 CurrTexel = texture(DiffuseSampler, texCoord);
            vec4 PrevTexel = texture(PrevSampler, texCoord);
            vec4 color = vec4((Phosphor - PrevTexel.rgb + CurrTexel.rgb) / 2.0, 1.0);
            float gray = (color.r + color.g + color.b)/3.0;

            int intensity = 1;
    
            vec3 colour;
            for (int i = 0; i < intensity; i++)
            {
                // Generate a black to white pixel
                colour = vec3(noise(texCoord + vec2(-1.5, -1.0), Time*79));
            }
            
            vec3 rescolor = vec3(gray,gray,gray) * vec3(1, 0.7, 0.7) * 0.5 + (colour * 0.2);
            

            fragColor = vec4(rescolor.xyz,1);
            break;

        
        
    }

    // Channel #2
//    control_color = texelFetch(ControlSampler, ivec2(0, 2), 0);
//    switch(int(control_color.b * 255.)) {
//        case 1:
//            fragColor.g += 0.5;
//            break;
//    }

    // Overlay the Overlay on top of other pixels, by default overlay has nothing.
    // Import an overlay sampler to set it.
//    if(overlay.a > 0.0) {
//        fragColor.rgb = mix(fragColor.rgb, overlay.rgb, overlay.a).rgb;
//    }
}
