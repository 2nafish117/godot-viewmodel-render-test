# godot-viewmodel-render-test

Demo project to test out viewmodel rendering in godot.

## I want this
Copy these uniforms to where your uniforms are.
```
const float PI = 3.1415926;

uniform float viewmodel_fov = 50.0f;
```

Copy this at the end of your vertex shader
```
float onetanfov = 1.0f / tan(0.5f * (viewmodel_fov * PI / 180.0f));
float aspect = VIEWPORT_SIZE.x / VIEWPORT_SIZE.y;
// modify projection matrix
PROJECTION_MATRIX[1][1] = onetanfov;
PROJECTION_MATRIX[0][0] = onetanfov / aspect;

// draws the viewmodel over everything (disable if you want dof near on viewmodel)
POSITION = PROJECTION_MATRIX * MODELVIEW_MATRIX * vec4(VERTEX.xyz, 1.0);
POSITION.z = mix(POSITION.z, 0, 0.99);
```

See `/Assets/Viewmodel.gdshader` for the complete shader code.

## How it works

The viewmodel shader modifies its projection matrix to render the viewmodel at a different fov than the main camera.

![](https://github.com/2nafish117/godot-viewmodel-render-test/blob/master/images/Screenshot2.png)
*camera fov 40 and viewmodel fov 60*
![](https://github.com/2nafish117/godot-viewmodel-render-test/blob/master/images/Screenshot3.png)
*camera fov 90 and viewmodel fov 60*
![](https://github.com/2nafish117/godot-viewmodel-render-test/blob/master/images/Screenshot1.png)
*money shot with dof*
![](https://github.com/2nafish117/godot-viewmodel-render-test/blob/master/images/Screenshot4.png)
*doesnt clip into nearby geometry*