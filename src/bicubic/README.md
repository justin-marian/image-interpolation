# Bicubic Interpolation

## Table of Contents

- [Bicubic Coeficients](bicubic_coef)
- [Bicubic Resize RGB](bicubic_resize_RGB)
  - [fx](fx)
  - [fy](fy)
  - [fxy](fxy)
- [Precalcualte Derivates](precalc_d)
- [Bicubic Resize](bicubic_resize)

## bicubic_coef

The intermediate matrix **T** is offered in the final form of the matrix solution, of the **Bicubic** interpolation coefficients.
Next to the matrix which forms the system of **16 equations**:

- **4** - from the condition that the function has known values f;
- **8** - from the derivatives of the 1st order in x & Y;
- **4** - mixed derivative;

Each equation resulted from the Bicubic interpolation form: $f(x, y), fx(x, y), fy(x, y), fxy(x, y)$.

## bicubic_resize_RGB

Similar to the **_RGB** functions from **Proximal**, only the 3 function calls for transforming images containing only the color filter (RED, GREEN, BLUE) are changed with **bicubic_resize**.
**fx , fy, fxy -** approximation of derivatives of the 1st order in x,y and of the 2nd order in xy.
For the 12 points in the matrix that form the system of equations, I will only apply a derivative approximation method to 12 equations.
In these *4 points (0,0), (0,1), (1,0) and (1,1) the derivatives are known as 0*.

### fx

- Check if the coordinates of x exceed the maximum length of the image 2 & n-1 (2 because we do not change the first pixel from the Ox axis)
- Use the approximation provided for the derivative of f as a function of x:
$$\small f_x = \frac{f(x + 1, y) - f(x - 1, y)}{2}$$

### fy

- Check if the y coordinates exceed the maximum length of the image 2 & m-1 (2 because we do not change the first pixel from the Oy axis)
- Use the approximation provided for the derivative of f as a function of y:
$$\small f_y = \frac{f(x, y + 1) - f(x, y - 1)}{2}$$

### fxy

- Apply both verification conditions as for fx & fy
- Use the approximation offered to the derivative of f of order 2 depending on x and y:
$$\small f_{xy} = \frac{f(x - 1, y - 1) + f(x + 1, y + 1) - f(x + 1, y - 1) - f(x - 1, y + 1)}{4}$$

## precalc_d

At the beginning of the program, I transform the **I** image into a double and apply the derivation functions on the **I** image, it will be useful to have the pixels in the "real form" when we will have to find the image interpolation coefficients with the Bicubic method.

Calculate the derivatives of the image $I_x, I_y, I_{xy}$ depending on $f_x, f_y, f_{xy}$ because I went through the pixel matrix **I** with the first force x from 1 to m followed by the second y from 1 to n.

It would have been the derivatives of the image $I_x, I_y, I_{xy}$ depending on $f_x, f_y, f_{xy}$ if the first force had been y from 1 to n followed by the second force x from 1 to m. At the end, get 3 pixel matrices obtained as derivatives of $I \space dx, dy, dx(dy)$.

## bicubic_resize

The method to resize the image is approximative like ***proximal_resize*** method only that the interpolation value of the pixel $(x, y)$ is different.

The first step I had to implement was to initialize the resulting matrix, **R**, the interpolation function written in matrix form. As well as casting the matrix-image to the double data type, so that there are no inconsistencies between the data types for **R** and **I** when I work with them.

**!** Scaling is applied from the next point, not from (0,0), it remains unchanged after scaling. Since the pixel indexing is from 1 to n the pixels multiply $s_x, s_y$ the origin of the image (1,1) moves to $(s_x, s_y)$ therefore. Indexing from 0 must be done **!**

Thus, the shape of the scaling factors would also change, because the indexing starts from 1, again we need the new one from 0, we subtract one unit each from the numerator and denominator, thus the formulas become:

$$ s_x = \frac{q - 1}{n - 1} \space\space\space\space s_y = \frac{p - 1}{m - 1}$$

The Bicubic transformation matrix, for resizing, is obtained as a consequence for rescaling the pixels following the Bicubic transformation.

$$x_o = x_i \cdot s_x \space\space\space\space y_o = y_i \cdot s_y$$

It will be applied like this, for the entire image $x_o, y_o$ are in each pixel of the image $x_p, y_p$, as a result of the transformation on all the pixels in the initial image **I**.

To calculate the inverse of the transformation matrix being a quadratic matrix of order 2, the inverse was simply determined. We kept the inverse in the same **T** transformation matrix, we only need the inverse to calculate the coordinates of each scaled pixel.

I go through the "whole" image, pixel by pixel from the **R** matrix, being the scaled matrix **I**, of size **m x n**, and apply the **T** transform, the Bicubic transformation matrix, the new coordinates are calculated as follows:

We applied the inverse of the T transformation on the column vector **[x, y]'**.
The coordinates of the scaled pixel, resulted as the multiplication of $T^{-1}$ with the vector $[x, y]'$. To obtain the coordinates of the similarly scaled vector. I applied the transpose of the vector with the coordinates of the scaled pixel.
After that, took over the coordinates of the scaled pixel and added +1 to the abscissa and ordinate, enough to make the transition from indexing from 0 to 1. The coordinates of the points that delimit the 4 zones, of a square, of replication of the function f.

**The conditions that ensure that it doesn't leave the unit square**
**y1** - on the last line, **m**, decrease one unit to **y1, y2** to return to the pixel matrix.
**x1** - on the last column, **n**, decrease one unit to **x1, x2** to return to the pixel matrix.
After applying the scaling procedure for the respective pixel, we obtained $(x_p, y_p)$ after calculating the coordinates of the vertices of the **L = 1** square in which it is located this scaled point, the coordinates of the square are integer values:

**(floor(xp), floor(yp)),
  (floor(xp)+1, floor(yp)),
  (floor(xp), floor(yp)+1),
  (floor(xp)+1, floor(yp)+1)**

peak on the last line - **floor(xp) = m**, get back to previous line in the I matrix.
peak on the last column -  **floor(yp) = n**, get back to previous column in the I matrix.
I pass the point (xp,yp) from the unit square, subtracting from $x_p-x_1$ and $y_p-y_1$.

The result of the transformation of the pixel following the Bicubic transformation is obtained by multiplying:

***LINE***:

- vector with coordinates x, as a degree 4 polynomial $[ 1x x^2 x^3 x^4 ]$, the matrix of coefficients of size 4x4 similar to the matrix **I** from the function **bicubic_coef**.

***COLUMN***:

- vector with coordinates y, as a polynomial of degree 4 $[ 1 y y^2 y^3 y^4 ]$, similar with **LINE**.

This form was obtained by rewriting the function $f(x, y)$ as a matrix product, solving the system of 16 equations. At the end of the program, after exiting the instructions. I return to the *8-bit unsigned integer data* type to confirm the conditions of a valid image.
