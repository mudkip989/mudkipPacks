#version 150
uniform sampler2D DiffuseSampler;

in vec2 texCoord;

out vec4 fragColor;


void main(){


	
    vec4 CurrTexel = texture(DiffuseSampler, texCoord);
    vec3 color = CurrTexel.rgb;
    float gray = (color.r + color.g + color.b)/3.0;


    fragColor = vec4(gray, gray, gray,1);
	
}