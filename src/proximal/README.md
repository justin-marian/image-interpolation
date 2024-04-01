# Proximal Interpolation

## proximal_2x2

On the ***Proximal*** interpolation problem applied to an image of size ***2x2***, we determined at the beginning the vectors for the abscissas and ordinates, each point is at the same distance one to the other, the distance being provided by the parameter **STEP = 0.1** to determine my equidistant points, this is how I get the coordinates to each point inside the square, the intermediate points.

Now that I have obtained the abscissa & ordinate vectors I can find the number of intermediate points of the 2 x 2 square, which is equal to **n** *(the number of points on the abscissa is the same as the number of points on the ordinate)*.

I know precisely the coordinates of the 4 points, it is enough to know only certain ones 2 points, vertices of the square. As far as I can know the other 2 extremities of the square, namely the top left point and the bottom right point.

I initialize the result of the interpolation matrix, *".out"*, all elements with 0, a null matrix.

I go through all the pixels in number of **n x n**, the initial image is given to me as a matrix square 2 x 2 size, the resulting matrix after interpolation will have the same 2x2 size only that now I know how many pixels I have to travel from the image matrix.

Because we work in 2D dimension, each pixel resulting from the image must be found in this way, so that it is CLOSEST to the pixel in the source image. We cannot apply direct interpolation on a function provided as a two-dimensional array, thus, I apply two 1D interpolations for each Ox & Oy axis, that is, for each element of the (x, y) vectors.

We working with values real & coordinates of the points of the initial image being whole, and we need the closest one pixel from the initial image either on the left or on the right, we will make simple roundings throughout the whole part or with addition. To make my work easier, I directly applied a predefined "round" function. The coordinates of the pixel are obtained in the ***pixel*** variable that holds its coordinates.

Now, we can get the pixel from the resulting final image by applying the ***fm*** function that respects a certain law of composition $f(x,y) = a_0 + a_1x + a_2y + a_3xy$, thus, we will obtain the shape of the final pixel of whole coordinates, after rounding the initial coordinates.
The process continues like this until it finishes transforming every pixel of the 2x2 picture.

## proximal_2x2_RGB

Within this function 3 images, obtained by extracting the 3 color channels from which any ***R-red, G-green, B-blue*** image is made up. I used predefined operations in ***Octave*** for extraction.

``` Matlab
% image colors, from the "img" image:
img(:,:,1) % equivalent to 255.0.0 - RED
img(:,:,2) % equivalent to 0.255.0 - GREEN
img(:,:,3) % equivalent to 0.0.255 - BLUE
```

Thus, after applying the **imp(:,:,)** function, I get the images:

- *R, G, B - which hold an image that has only one color channel*

I applied ***Proximal interpolation*** on each image, with its respective color channel, on a 2x2 image.

I therefore obtain 3 new modified images ***(Proximal_2x2_R , Proximal_2x2_G , Proximal_2x2_B)*** following the transformation process applied to ***proximal_2x2.*** I repeat the process for each color channel, image (R, G, B).

Finally, all I have left to do is to combine the 3 color filters (images after interpolation) in one. To be sure that I combined the 3 images correctly, I put them in RGB order. All this process was done by the predefined function **cat**.

## proximal_coef

At this stage of the interpolation, I calculated the result of the Proximal interpolation written in the form of a function $f(x,y) = a_0 + a_1x + a_2y + a_3xy$, in matrix form. Thus, the coefficients on the Proximal interpolation method (a) are determined by calculating the inverse of A, $A^{-1}$, and multiplying it to the left of b. $a = A^{-1} \cdot b = A / b$. I have to pay attention to the data type double for the elements of b, the values of the functions and points are known.

$$
\begin{pmatrix}
1 & x_1 & y_1 & x_1y_1\\
1 & x_1 & y_2 & x_1y_2\\
1 & x_2 & y_1 & x_2y_1\\
1 & x_2 & y_2 & x_2y_2\\
\end{pmatrix} \cdot
\begin{pmatrix} a_0\\ a_1\\ a_2\\ a_3\end{pmatrix} =
\begin{pmatrix} f(A_{11})\\ f(A_{12})\\ f(A_{21})\\ f(A_{22})
\end{pmatrix}
$$

### proximal_resize_RGB

It is similar to ***proximal_2x2_RGB***, only that I call the ***proximal_resize*** function to resize the 3 images that contain filters R, G, B separately. At the end, I combine them similarly by combining all 3 images with their respective filters R, G, B in this order.

### proximal_resize

The first step I had to implement was to initialize the resulting matrix, **R**, the interpolation function written in matrix form. As well as casting the matrix-image to the double data type, so that there are no inconsistencies between the data types for **R** and **I** when I work with them.

**!** *Scaling is applied from the next point, not from (0,0), it remains unchanged after scaling. Since the pixel indexing is from 1 to n the pixels multiply $s_x, s_y$ the origin of the image (1,1) moves to $(s_x, s_y)$ therefore* **!**

Indexing from 0 must be done. Thus, the shape of the scaling factors would also change, because the indexing starts from 1, again we need the new one from 0, we subtract one unit each from the numerator and denominator, thus the formulas become:

$$ s_x = \frac{q - 1}{n - 1} \space\space\space\space s_y = \frac{p - 1}{m - 1}$$

The Proximal transformation matrix, for resizing, is obtained as a consequence for the rescaling of pixels following the Proximal transformation.

$$x_o = x_i \cdot s_x \space\space\space\space y_o = y_i \cdot s_y$$

Will be applied like this, for the entire image $x_o, y_o$ are in each pixel of the image $x_p, y_p$, as a result of the transformation on all the pixels in the initial image **I**.

To calculate the inverse of the transformation matrix being a quadratic matrix of order 2, the inverse was simply determined. We kept the inverse in the same **T** transformation matrix, we only need the inverse to calculate the coordinates of each scaled pixel.

I go through the "whole" image, pixel by pixel from the **R** matrix, being the scaled matrix **I**, of size **m x n**, and apply the T transform, the Proximal transformation matrix, the new coordinates are calculated as follows:

I applied the inverse of the T transformation on the column vector **[x, y]'** (the coordinates of a single pixel). The coordinates of the scaled pixel, resulted as the multiplication of $T^{-1}$ with the vector $[x, y]'$. To obtain the coordinates of the similarly scaled vector as in the relation expressed explained at **proximal_resize**. I applied the transpose of the vector with the coordinates of the scaled pixel.

I took over the coordinates of the scaled pixel and added +1 to the abscissa and ordinate, enough to make the transition from indexing from 0 to 1. And I rounded to a whole number by addition or whole part.

After applying the scaling procedure for the respective pixel, it ends up being $(x_p, y_p)$ from the initial matrix. In order to correctly calculate the size of column V with the coordinates of the scaled pixel. At the end of the program, after exiting the for instructions, I return to the 8-bit unsigned integer data type to confirm the conditions of a valid image.

## proximal_rotate_RGB

Similar to **proximal_resize_RGB**, only I apply rotations on each pixel depending on the theta angle provided, in our case **rotation angle**. At the end, I get an image rotated with the given angle, obtained as 3 images **Proximal_ROT_R, Proximal_ROT_G, Proximal_ROT_B** united into one.

## proximal rotate

I calculate the cosine and sine of the angle **rotation_angle**, it will help us to build the rotation matrix **T_rot**. I initialize the final array with 0, all elements in the array become 0.
The transformation matrix for Proximal type rotations is obtained after rewriting the system of equations:

$x0=rcosθ$
$y0=rsinθ=>x1=r(cosθcosφ−sinθsinφ)=x0cosφ−y0sinφ=>|cosφ−sinφ|*|x0|=|x1|$
$x1=rcos(θ+φ)=>y1=r(sinθcosφ+cosθsinφ)=y0cosφ+x0sinφ=>|sinφ-cosφ|*|y0|=|y1|$
$y1 = rsin(θ+φ)$
$T_{rot} - radiens(φ)$

To calculate the inverse of the transformation matrix **T** we applied a function predefined in Octave **inv()**, since we have no restrictions here in applying an inverse calculation method.

I go through the entire image, pixel by pixel from the matrix **I**, of size **m x n**, and apply the transformation **T**, the Proximal transformation matrix, the new coordinates are calculated as follows:

We applied the same method of calculating the coordinates of the scaled pixel $(x_p, y_p)$  as in **proximal_resize**. I immediately took the coordinates of the scaled pixel and added +1 to the abscissa and ordinate, enough to make the transition from indexing from 0 to 1.

If the image dimensions exceed:
$xp < 1 \space\space yp < 1 \\ xp > n \space\space yp > m$

The respective pixel ***(x, y)*** is made black and I move on. The coordinates of the points that delimit the 4 zones, of a square of size 2 x 2, of replication of the function ***f***.

**The conditions that ensure that it doesn't leave the unit square**
**y1** - on the last line, **m**, decrease one unit to **y1, y2** to return to the pixel matrix.
**x1** - on the last column, **n**, decrease one unit to **x1, x2** to return to the pixel matrix.
Calculate the interpolation coefficients by calling the **proximal_coef** program.

The following coordinate transformation is applied to each pixel: $f(x,y) = a_0 + a_1x + a_2y + a_3xy$. the program ended, after the confirmation of the validation conditions of a image.
