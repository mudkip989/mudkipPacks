#version 150
uniform sampler2D DiffuseSampler;
uniform vec4 ColorModulate;

uniform vec2 ScreenSize;
in vec2 texCoord;

out vec4 fragColor;
	
const float PI = 3.1415926535897932384626433832795;
const vec2 HALF = vec2(0.5);
const float degres = 1;


float deg2rad(float deg){ return deg * PI / 180.0; }

void main() {
  vec2 coord = texCoord.xy;

  float sin_factor = sin(deg2rad(degres));
  float cos_factor = cos(deg2rad(degres));

  // move rotation origin from upper left to centre of image
  coord -= HALF.xy;
  // rotate image around image centre
  coord *= mat2(cos_factor, sin_factor, -sin_factor, cos_factor);
  // compensate for skew
  coord *= vec2(1,1);
  // move origin back to upper left to read from texture
  coord += HALF.xy;

  vec4 color = texture2D(DiffuseSampler, coord);
  fragColor = vec4(color);
	
}