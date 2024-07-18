/// pt_draw_path_trail(x, y, path, color, width, alpha, trail_length, out_color, out_size)
pa = instance_create(argument0, argument1, pt_obj_trail)
pa.pa = argument2
pa.color = argument3
pa.trail_width = argument4
pa.alpha = argument5
pa.long = argument6

if argument7 != noone and argument8 != noone {
    out_size = argument8
    out = instance_create(argument0, argument1, pt_obj_trail)
    out.pa = argument2
    out.color = argument7
    out.trail_width = argument4 + out_size
    out.long = argument6
    out.depth = pa.depth + 1
}
return pa
