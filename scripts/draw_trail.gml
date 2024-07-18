#define draw_trail
///draw_trail(length,width,color,sprite,slim,alpha)
//Ex. draw_trail(32,32,c_white,-1,1,1)
var Length,Width,Color,Sprite,Slim,Alpha,AlphaT,Texture,Dir,Dim,Min,Height;
//Preparing variables
Length = argument0; //How many previous coordinates will use the trail
Width = argument1; //How wide will the trail be
Color = argument2; //Which color will be used to tint the trail
Sprite = argument3; //Which sprite's texture must be used for the trail. Must have "Used for 3D" marked. -1 for no sprite 
Slim = argument4; //Whether the trail will slim down at the end
Alpha = argument5; //The alpha to draw the trail with (0-1), optional
ArrayTrail[0,0] = x;
ArrayTrail[0,1] = y;
Height = array_height_2d(ArrayTrail);
//Getting distance between current and past coordinates
if (Height > 1) ArrayTrail[0,2] = point_distance(ArrayTrail[0,0],ArrayTrail[0,1],ArrayTrail[1,0],ArrayTrail[1,1]) + ArrayTrail[1,2];
else ArrayTrail[0,2] = 0;
//Setting the texture
if (Sprite >= 0) {
Texture = sprite_get_texture(Sprite,0);
Dim = sprite_get_width(Sprite)/sprite_get_width(Sprite)
}
else {
Texture = -1;
Dim = 1
}
texture_set_repeat(1);
//Drawing the primitive
draw_primitive_begin_texture(pr_trianglestrip,Texture);
AlphaT = 1;
Dir = 0;
Min = min(Height - 1,Length);
for(var i = 0; i < Min; i++){
  if (ArrayTrail[i,0] != ArrayTrail[i+1,0] || ArrayTrail[i,1] != ArrayTrail[i+1,1])
    Dir = point_direction(ArrayTrail[i,0],ArrayTrail[i,1],ArrayTrail[i+1,0],ArrayTrail[i+1,1]);
  var Len = Width / 2 - ((i + 1) / Min * Width / 2) * Slim;
  var XX = lengthdir_x(Len,Dir + 90); 
  var YY = lengthdir_y(Len,Dir + 90);
  AlphaT = (Min - i) / (Min / 2) * Alpha;
  draw_vertex_texture_color(ArrayTrail[i,0] + XX,ArrayTrail[i,1] + YY,ArrayTrail[i,2] / Width/Dim,0,Color,AlphaT);
  draw_vertex_texture_color(ArrayTrail[i,0] - XX,ArrayTrail[i,1] - YY,ArrayTrail[i,2] / Width/Dim,1,Color,AlphaT);
}
draw_primitive_end();
//Replacing the coordinates positions within the array
Min = min(Height,Length);
for (var i = Min; i > 0; i--){
  ArrayTrail[i,0] = ArrayTrail[i - 1,0];
  ArrayTrail[i,1] = ArrayTrail[i - 1,1];
  ArrayTrail[i,2] = ArrayTrail[i - 1,2];
}


#define draw_trail_ext
///draw_trail_ext(Width,Color,Sprite,Slim,Alpha)
//Ex. draw_trail(32,c_white,-1,1,1)
var Width,Color,Sprite,Slim,Alpha,AlphaT,Texture,Dir,Dim,Lenght;
//Preparing variables
Width = argument0; //How wide will the trail be
Color = argument1; //Which color will be used to tint the trail
Sprite = argument2; //Which sprite's texture must be used for the trail. Must have "Used for 3D" marked. -1 for no sprite 
Slim = argument3; //Whether the trail will slim down at the end
Alpha = argument4; //The alpha to draw the trail with (0-1), optional
//Setting the texture
if (Sprite >= 0){
Texture = sprite_get_texture(Sprite,0);
Dim = sprite_get_width(Sprite)/sprite_get_width(Sprite)
}
else {
Texture = -1;
Dim = 1
}
texture_set_repeat(1);
//Drawing the primitive
draw_primitive_begin_texture(pr_trianglestrip,Texture);
AlphaT = 1;
Dir = 0;
Lenght = ds_grid_width(GridTrail)-1;
for(var i = 0; i < Lenght; i++){
  if (GridTrail[# i,0] != GridTrail[# i+1,0] || GridTrail[# i,1] != GridTrail[# i+1,1])
    Dir = point_direction(GridTrail[# i,0],GridTrail[# i,1],GridTrail[# i+1,0],GridTrail[# i+1,1]);
  var Len = Width / 2 - ((i + 1) / Lenght * Width / 2) * Slim;
  var XX = lengthdir_x(Len,Dir + 90);
  var YY = lengthdir_y(Len,Dir + 90);
  AlphaT = (Lenght - i) / (Lenght / 2) * Alpha;
  draw_vertex_texture_colour(GridTrail[# i,0] + XX,GridTrail[# i,1] + YY,GridTrail[# i,2] / Width/Dim,0,Color,AlphaT);
  draw_vertex_texture_colour(GridTrail[# i,0] - XX,GridTrail[# i,1] - YY,GridTrail[# i,2] / Width/Dim,1,Color,AlphaT);
}
draw_primitive_end();


#define trail_calculate
///trail_calculate(length)
//Ex. calculate_trail(32)
var Length,Dir,Min,Width;
//Preparing variables
Length = argument0; //How many previous coordinates will use the trail
Width = ds_grid_width(GridTrail);
if !ds_exists(GridTrail,ds_type_grid) GridTrail = ds_grid_create(1,3);
//Replacing previous coordinates positions within the array
Min = min(Width,Length);
if (Min == Width) ds_grid_resize(GridTrail,Width+1,3);
for (var i = Min; i > 0; i--){
  GridTrail[# i,0] = GridTrail[# i - 1,0];
  GridTrail[# i,1] = GridTrail[# i - 1,1];
  GridTrail[# i,2] = GridTrail[# i - 1,2];
}
GridTrail[# 0,0] = x;
GridTrail[# 0,1] = y;
//Getting distance between current and past coordinates
if (Width > 1) GridTrail[# 0,2] = point_distance(GridTrail[# 0,0],GridTrail[# 0,1],GridTrail[# 1,0],GridTrail[# 1,1]) + GridTrail[# 1,2];
else GridTrail[# 0,2] = 0;


#define trail_destroy
///trail_destroy()
//It destroys the grid of the trail effect
ds_grid_destroy(GridTrail);


#define trail_init
///trail_init()
//It creates the grid used to store the coordinates for the effect
GridTrail = ds_grid_create(0,3);