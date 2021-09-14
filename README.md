# godot-viewmodel-render-test

Demo project to test out viewmodel rendering in godot.

## I want this
Copy these uniforms to where your uniforms are.
```
const float PI = 3.1415926;

uniform float viewmodel_fov = 50.0f;
uniform float screen_width = 16.0f;
uniform float screen_height = 9.0f;
```

Copy this at the end of your vertex shader
```
float onetanfov = 1.0f / tan(0.5f * (viewmodel_fov * PI / 180.0f));
float aspect = screen_width / screen_height;
// modify projection matrix
PROJECTION_MATRIX[1][1] = onetanfov;
PROJECTION_MATRIX[0][0] = onetanfov / aspect;

// draws the viewmodel over everything (disable if you want dof near on viewmodel)
POSITION = PROJECTION_MATRIX * MODELVIEW_MATRIX * vec4(VERTEX.xyz, 1.0);
POSITION.z = mix(POSITION.z, 0, 0.99);
```

See `/Assets/Viewmodel.gdshader` for the shader code

## How it works

The viewmodel shader modifies its projection matrix to render the viewmodel at a different fov than the main camera.

![alt text](https://github.com/2nafish117/godot-viewmodel-render-test/blob/master/images/Screenshot1.png)

![alt text](https://github.com/2nafish117/godot-viewmodel-render-test/blob/master/images/Screenshot2.png)

![alt text](https://github.com/2nafish117/godot-viewmodel-render-test/blob/master/images/Screenshot3.png)

![alt text](https://github.com/2nafish117/godot-viewmodel-render-test/blob/master/images/Screenshot3.png)
