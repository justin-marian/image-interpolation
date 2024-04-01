function R = proximal_rotate(I, rotation_angle)
    % The size of the image.
    [m, n, nr_colors] = size(I);

    % Cast I to double
    I = cast(I, "double");

    % If the image is black and white, ignore it
    if nr_colors > 1
        R = -1;
        return
    end

    % Calculate cos and sine of rotation_angle
    COS = cos(rotation_angle);
    SIN = sin(rotation_angle);
    % Initialize finale matrix
    R = zeros(m, n);
    % Initialize the rotation matrix
    T_rot = [COS -SIN;
             SIN COS];
    % Calculate the inverse of the rotation matrix
    T_rot = inv(T_rot);

    for y = 0 : m - 1
        for x = 0 : n - 1
            % Apply the inverse transformation on (x, y) and calculate
            % x_p and y_p from the initial image space
            % x_0 = x_i * s_x
            % y_0 = y_i * s_y
            V = T_rot * [x; y];
            V = V';

            % Switch (xp, yp) from the coordinate system from 0 to n - 1
            % in the coordinate system from 1 to n to apply the interpolation
            xp = V(1); yp = V(2);
            xp = xp + 1; yp = yp + 1;

            % If xp or yp is outside the image
            % put a pixel black in the image and move on
            if (xp < 1) || (yp < 1)
                R(y + 1, x + 1) = 0;
                continue;
            end
            if (xp > n) || (yp > m)
                R(y + 1, x + 1) = 0;
                continue;
            end

            % Find the points surrounding the point (xp, yp)
            % If x1, y1 are on the last line-column
            % x2, y2 will not leave the pixel matrix

            % I : verify the width
            y1 = floor(yp);
            y2 = floor(yp) + 1;
            if y1 == m %% y - last row
                y1--; y2--;
            end
            % II : verify the height
            x1 = floor(xp);
            x2 = floor(xp) + 1;
            if x1 == n %% x - last column
                x1--; x2--;
            end

            % Calculate the interpolation coefficients := a
            a = proximal_coef(I, x1, y1, x2, y2);

            % Calculate the interpolated value of the pixel (x, y)
            R(y + 1, x + 1) = a(1) +...
                              a(2) * xp +...
                              a(3) * yp +...
                              a(4) * xp * yp;
        end
    end
    % Transform the resulting array into uint8 to be a valid image
    R = cast(R, "uint8");
end

% Note: In Octave, image pixels are indexed from 1 to n by default.
% When scaling is applied, the point (0, 0) of the image will not travel.
% If you work in indices from 1 to n and multiply x and y by s_x and s_y,
% then the origin of the image will move from (1, 1) to (sx, sy)!
% Therefore, you must work with indices in the range from 0 to n - 1!
% Note: for writing in the image, x and y are in coordinates of
% to 0 to n - 1 and must be brought in coordinates from 1 to n
