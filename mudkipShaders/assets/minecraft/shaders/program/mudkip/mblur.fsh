#version 150
uniform sampler2D DiffuseSampler;
uniform sampler2D PrevSampler;

uniform float Fade;

in vec2 texCoord;

out vec4 fragColor;


void main(){

	
    vec4 prev_color  = texture(DiffuseSampler, texCoord);
	fragColor = prev_color;

	
	vec3 Phosphor = vec3(Fade, Fade, Fade);
    vec4 CurrTexel = texture(DiffuseSampler, texCoord);
    vec4 PrevTexel = texture(PrevSampler, texCoord);
    fragColor = vec4(max(PrevTexel.rgb * Phosphor, CurrTexel.rgb), 1.0);
	
}