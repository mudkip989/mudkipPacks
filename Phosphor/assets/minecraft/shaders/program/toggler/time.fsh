#version 150
uniform sampler2D DiffuseSampler;
uniform sampler2D PrevSampler;
uniform float[] data;
in vec2 texCoord;

out vec4 fragColor;


void main(){
    
    vec4 color = texture(DiffuseSampler, texCoord);

    float red = color.r * 255;
    float green = color.g * 255;
    float blue = color.b * 255;
    float alpha = color.b * 255;

    alpha += 1;
    if(alpha >255){
        alpha = 0;
        blue +=1;
    }
    if(blue >255){
        blue = 0;
        green +=1;
    }
    if(green >255){
        green = 0;
        red +=1;
    }
    if(red >255){
        red = 0;
    }

    vec4 colour = vec4(red/255.0, green/255.0, blue/255.0, alpha/255.0);

    fragColor = colour;
    
	
}