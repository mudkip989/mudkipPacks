#version 150
uniform sampler2D DiffuseSampler;

uniform float Alphra;
uniform float Frequency;
uniform float Time;

const float PI = 3.1415926535897932384626433832795;

in vec2 texCoord;

out vec4 fragColor;


void main(){

	vec4 line = vec4(1, 1, 1, 1);


	float lineValue = (sin((Time*2 + texCoord.y*20)*PI) - 0.5)/16;
    if(lineValue < 0.0){
        lineValue = 0.0;
    }
	vec3 Alp = vec3(Alphra, Alphra, Alphra);
    vec3 negAlp = vec3(1-Alphra, 1-Alphra, 1-Alphra);
    vec4 CurrTexel = texture(DiffuseSampler, texCoord);
    vec3 rCurrTexel = CurrTexel.rgb + (line.rgb * lineValue);
    fragColor = vec4(rCurrTexel, 1);
	
}