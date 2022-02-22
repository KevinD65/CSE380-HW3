precision mediump float;

varying vec4 v_Position;

uniform vec4 circle_Color;
uniform vec4 circle_Color2;

// HOMEWORK 3 - TODO
/*
	The fragment shader is where pixel colors are decided.
	You'll have to modify this code to make the circle vary between 2 colors.
	Currently this will render the exact same thing as the gradient_circle shaders
*/
void main(){
	// Default alpha is 0
	float alpha = 0.0;

	// Radius is 0.5, since the diameter of our quad is 1
	float radius = 0.5;

	//USED TO SET A SIZE TO THE CIRCLE
	float dist_sq = v_Position.x*v_Position.x + v_Position.y*v_Position.y;

	//IF WE ARE WITHIN THE RANGE OF THE CIRCLE, SET ITS OPACITY TO FULL
	if(dist_sq < radius*radius){
		alpha = 1.0;
	}

	//HOLDS THE Y-VALUE OF THE POSITION OF THE PIXEL REALTIVE TO THE CENTER OF THE BULLET(CIRCLE)
	float distFromCircleBottom = v_Position.y + 0.5;
	float distFromCircleLeft = v_Position.x + 0.5;
	float avgOfPos = (distFromCircleBottom + distFromCircleLeft)/2.0;

	//HOLDS THE INITIAL RGB VALUES OF COLOR1 (EITHER PINK/MAGENTA OR YELLOW) OF THE CIRCLE
	float InitialRValueC1 = circle_Color.x;
	float InitialGValueC1 = circle_Color.y;
	float InitialBValueC1 = circle_Color.z;

	//HOLDS BLUE AND THE SECOND COLOR AS VECTORS
	vec3 BLUEC = vec3(0.0, 0.0, 255.0);
	vec3 SECONDCOLOR = vec3(InitialRValueC1, InitialGValueC1, InitialBValueC1);

	//MIXES THE RGB VALUES FOR INTERPOLATION
	float mixR = mix(BLUEC.x, SECONDCOLOR.x, avgOfPos);
	float mixG = mix(BLUEC.y, SECONDCOLOR.y, avgOfPos);
	float mixB = mix(BLUEC.z, SECONDCOLOR.z, avgOfPos);	
	
	if(InitialBValueC1 == 0.0){ //YELLOW
		mixB = mix(SECONDCOLOR.z, BLUEC.z, avgOfPos);
		mixB = 165.0 - mixB;
	}

	//USES THE RGBA VALUES WE CALCULATED
	gl_FragColor = vec4(circle_Color);
	gl_FragColor.a = alpha;
	gl_FragColor.r = mixR;
	gl_FragColor.g = mixG;
	gl_FragColor.b = mixB;
}