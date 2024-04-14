shader_type canvas_item;
uniform int onoff = 0;
render_mode blend_mix;

uniform vec2 offset = vec2(20.0, 25.0);
uniform vec4 modulate : source_color;

void fragment() {
    if (onoff == 1) {
   	    vec2 ps = TEXTURE_PIXEL_SIZE;
        vec4 shadow = vec4(0.99, 0.82, 0.3, texture(TEXTURE, UV - offset * ps).a * modulate.a);
   	    // = vec4(modulate.rgb, texture(TEXTURE, UV - offset * ps).a * modulate.a);
   	    vec4 col = texture(TEXTURE, UV);
   	    COLOR = mix(shadow, col, col.a);
    }
}