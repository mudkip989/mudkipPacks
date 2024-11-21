#version 150
uniform sampler2D DiffuseSampler;
uniform sampler2D ImgSampler;

uniform float Alphra;

in vec2 texCoord;

out vec4 fragColor;


void main(){

	


	
	vec3 Alp = vec3(Alphra, Alphra, Alphra);
    vec3 negAlp = vec3(1-Alphra, 1-Alphra, 1-Alphra);
    vec4 CurrTexel = texture(DiffuseSampler, texCoord);
    vec4 ImgTexel = texture(ImgSampler, texCoord);
    fragColor = vec4((ImgTexel.rgb * Alp + CurrTexel.rgb), 1);
	
}