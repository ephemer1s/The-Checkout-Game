shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
    if (COLOR.a > 0.0) {
         COLOR = vec4(1,0.78,0, COLOR.a);
    }
}

void light() {
	// Called for every pixel for every light affecting the CanvasItem.
}
