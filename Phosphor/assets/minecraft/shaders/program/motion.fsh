#version 150
uniform sampler2D DiffuseSampler;
uniform sampler2D PrevSampler;

in vec2 texCoord;

out vec4 fragColor;


void main(){

	
    vec4 prev_color  = texture(DiffuseSampler, texCoord);
	fragColor = prev_color;

	
	vec3 Phosphor = vec3(1,1,1);
    vec4 CurrTexel = texture(DiffuseSampler, texCoord);
    vec4 PrevTexel = texture(PrevSampler, texCoord);
    vec4 color = vec4((Phosphor - PrevTexel.rgb + CurrTexel.rgb) / 2.0, 1.0);

    fragColor = vec4(color.rgb * vec3(0.5, 0.5, 0.5), 1.0);
	
}