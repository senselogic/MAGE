![](https://github.com/senselogic/MAGE/blob/master/LOGO/mage.png)

# Mage

Matrix code generator.

## Examples

```bash
mage "scaling_product_matrix" "x_scaling;y_scaling;z_scaling" "matrix:3:3"
```
```c++
scaling_product_matrix.XVector.X = x_scaling * matrix.XVector.X;
scaling_product_matrix.XVector.Y = x_scaling * matrix.XVector.Y;
scaling_product_matrix.XVector.Z = x_scaling * matrix.XVector.Z;
scaling_product_matrix.XVector.W = 0.0;

scaling_product_matrix.YVector.X = y_scaling * matrix.YVector.X;
scaling_product_matrix.YVector.Y = y_scaling * matrix.YVector.Y;
scaling_product_matrix.YVector.Z = y_scaling * matrix.YVector.Z;
scaling_product_matrix.YVector.W = 0.0;

scaling_product_matrix.ZVector.X = z_scaling * matrix.ZVector.X;
scaling_product_matrix.ZVector.Y = z_scaling * matrix.ZVector.Y;
scaling_product_matrix.ZVector.Z = z_scaling * matrix.ZVector.Z;
scaling_product_matrix.ZVector.W = 0.0;

scaling_product_matrix.WVector.X = 0.0;
scaling_product_matrix.WVector.Y = 0.0;
scaling_product_matrix.WVector.Z = 0.0;
scaling_product_matrix.WVector.W = 1.0;
```

```bash
mage "xy_z_rotation_matrix" "x_rotation_matrix" "y_rotation_matrix" "z_rotation_matrix"
```
```c++
xy_z_rotation_matrix.XVector.X = y_cosinus * z_cosinus;
xy_z_rotation_matrix.XVector.Y = y_cosinus * z_sinus;
xy_z_rotation_matrix.XVector.Z = -y_sinus;
xy_z_rotation_matrix.XVector.W = 0.0;

xy_z_rotation_matrix.YVector.X = x_sinus * y_sinus * z_cosinus - x_cosinus * z_sinus;
xy_z_rotation_matrix.YVector.Y = x_sinus * y_sinus * z_sinus + x_cosinus * z_cosinus;
xy_z_rotation_matrix.YVector.Z = x_sinus * y_cosinus;
xy_z_rotation_matrix.YVector.W = 0.0;

xy_z_rotation_matrix.ZVector.X = x_cosinus * y_sinus * z_cosinus + x_sinus * z_sinus;
xy_z_rotation_matrix.ZVector.Y = x_cosinus * y_sinus * z_sinus - x_sinus * z_cosinus;
xy_z_rotation_matrix.ZVector.Z = x_cosinus * y_cosinus;
xy_z_rotation_matrix.ZVector.W = 0.0;

xy_z_rotation_matrix.WVector.X = 0.0;
xy_z_rotation_matrix.WVector.Y = 0.0;
xy_z_rotation_matrix.WVector.Z = 0.0;
xy_z_rotation_matrix.WVector.W = 1.0;
```

```bash
mage --left "vector_z_yx_rotation_matrix" "vector_matrix" "z_rotation_matrix" "y_rotation_matrix" "x_rotation_matrix"
```
```c++
vector_z_yx_rotation_matrix.XVector.X = z_cosinus * y_cosinus;
vector_z_yx_rotation_matrix.XVector.Y = z_cosinus * y_sinus * x_sinus + z_sinus * x_cosinus;
vector_z_yx_rotation_matrix.XVector.Z = -z_cosinus * y_sinus * x_cosinus + z_sinus * x_sinus;
vector_z_yx_rotation_matrix.XVector.W = 0.0;

vector_z_yx_rotation_matrix.YVector.X = -z_sinus * y_cosinus;
vector_z_yx_rotation_matrix.YVector.Y = -z_sinus * y_sinus * x_sinus + z_cosinus * x_cosinus;
vector_z_yx_rotation_matrix.YVector.Z = z_sinus * y_sinus * x_cosinus + z_cosinus * x_sinus;
vector_z_yx_rotation_matrix.YVector.W = 0.0;

vector_z_yx_rotation_matrix.ZVector.X = y_sinus;
vector_z_yx_rotation_matrix.ZVector.Y = -y_cosinus * x_sinus;
vector_z_yx_rotation_matrix.ZVector.Z = y_cosinus * x_cosinus;
vector_z_yx_rotation_matrix.ZVector.W = 0.0;

vector_z_yx_rotation_matrix.WVector.X = vector.X * z_cosinus * y_cosinus - vector.Y * z_sinus * y_cosinus + vector.Z * y_sinus;
vector_z_yx_rotation_matrix.WVector.Y = vector.X * ( z_cosinus * y_sinus * x_sinus + z_sinus * x_cosinus ) + vector.Y * ( -z_sinus * y_sinus * x_sinus + z_cosinus * x_cosinus ) - vector.Z * y_cosinus * x_sinus;
vector_z_yx_rotation_matrix.WVector.Z = vector.X * ( -z_cosinus * y_sinus * x_cosinus + z_sinus * x_sinus ) + vector.Y * ( z_sinus * y_sinus * x_cosinus + z_cosinus * x_sinus ) + vector.Z * y_cosinus * x_cosinus;
vector_z_yx_rotation_matrix.WVector.W = 1.0;
```

```
mage "product_matrix_4_3" "first_matrix:4:3" "second_matrix:4:3"
```
```
product_matrix_4_3.XVector.X = first_matrix.XVector.X * second_matrix.XVector.X + first_matrix.XVector.Y * second_matrix.YVector.X + first_matrix.XVector.Z * second_matrix.ZVector.X;
product_matrix_4_3.XVector.Y = first_matrix.XVector.X * second_matrix.XVector.Y + first_matrix.XVector.Y * second_matrix.YVector.Y + first_matrix.XVector.Z * second_matrix.ZVector.Y;
product_matrix_4_3.XVector.Z = first_matrix.XVector.X * second_matrix.XVector.Z + first_matrix.XVector.Y * second_matrix.YVector.Z + first_matrix.XVector.Z * second_matrix.ZVector.Z;
product_matrix_4_3.XVector.W = 0.0;

product_matrix_4_3.YVector.X = first_matrix.YVector.X * second_matrix.XVector.X + first_matrix.YVector.Y * second_matrix.YVector.X + first_matrix.YVector.Z * second_matrix.ZVector.X;
product_matrix_4_3.YVector.Y = first_matrix.YVector.X * second_matrix.XVector.Y + first_matrix.YVector.Y * second_matrix.YVector.Y + first_matrix.YVector.Z * second_matrix.ZVector.Y;
product_matrix_4_3.YVector.Z = first_matrix.YVector.X * second_matrix.XVector.Z + first_matrix.YVector.Y * second_matrix.YVector.Z + first_matrix.YVector.Z * second_matrix.ZVector.Z;
product_matrix_4_3.YVector.W = 0.0;

product_matrix_4_3.ZVector.X = first_matrix.ZVector.X * second_matrix.XVector.X + first_matrix.ZVector.Y * second_matrix.YVector.X + first_matrix.ZVector.Z * second_matrix.ZVector.X;
product_matrix_4_3.ZVector.Y = first_matrix.ZVector.X * second_matrix.XVector.Y + first_matrix.ZVector.Y * second_matrix.YVector.Y + first_matrix.ZVector.Z * second_matrix.ZVector.Y;
product_matrix_4_3.ZVector.Z = first_matrix.ZVector.X * second_matrix.XVector.Z + first_matrix.ZVector.Y * second_matrix.YVector.Z + first_matrix.ZVector.Z * second_matrix.ZVector.Z;
product_matrix_4_3.ZVector.W = 0.0;

product_matrix_4_3.WVector.X = first_matrix.WVector.X * second_matrix.XVector.X + first_matrix.WVector.Y * second_matrix.YVector.X + first_matrix.WVector.Z * second_matrix.ZVector.X + second_matrix.WVector.X;
product_matrix_4_3.WVector.Y = first_matrix.WVector.X * second_matrix.XVector.Y + first_matrix.WVector.Y * second_matrix.YVector.Y + first_matrix.WVector.Z * second_matrix.ZVector.Y + second_matrix.WVector.Y;
product_matrix_4_3.WVector.Z = first_matrix.WVector.X * second_matrix.XVector.Z + first_matrix.WVector.Y * second_matrix.YVector.Z + first_matrix.WVector.Z * second_matrix.ZVector.Z + second_matrix.WVector.Z;
product_matrix_4_3.WVector.W = 1.0;
```

## Installation

Install the [DMD 2 compiler](https://dlang.org/download.html) (choosing the MinGW setup option on Windows).

Build the executable with the following command line :

```bash
dmd -m64 mage.d
```

## Command line

```bash
mage [options] first_matrix second_matrix ...
```

### Options

```
--reverse : compute the matrix product in reverse order
```

### Predefined matrices

* identity_matrix
* vector_matrix
* translation_matrix
* scaling_matrix
* x_scaling_matrix
* y_scaling_matrix
* z_scaling_matrix
* x_rotation_matrix
* y_rotation_matrix
* z_rotation_matrix

### Custom matrices

* w_vector_x, w_vector_y, w_vector_z
* x_vector_x; y_vector_y; z_vector_z
* x_vector_x; y_vector_y; z_vector_z;<br/>w_vector_x; w_vector_y; w_vector_z
* x_vector_x; x_vector_y; x_vector_z;<br/>y_vector_x; y_vector_y; y_vector_z;<br/>z_vector_x; z_vector_y; z_vector_z
* x_vector_x; x_vector_y; x_vector_z;<br/>y_vector_x; y_vector_y; y_vector_z;<br/>z_vector_x; z_vector_y; z_vector_z;<br/>w_vector_x; w_vector_y; w_vector_z
* x_vector_x; x_vector_y; x_vector_z; x_vector_w;<br/>y_vector_x; y_vector_y; y_vector_z; y_vector_w;<br/>z_vector_x; z_vector_y; z_vector_z; z_vector_w;<br/>w_vector_x; w_vector_y; w_vector_z; w_vector_w

## Named matrices

* matrix_name<br/>
  matrix_name:4<br/>
  matrix_name:4:4
* matrix_name:4:3
* matrix_name:3<br/>
  matrix_name:3:3

## Version

1.0

## Author

Eric Pelzer (ecstatic.coder@gmail.com).

## License

This project is licensed under the GNU General Public License version 3.

See the [LICENSE.md](LICENSE.md) file for details.
