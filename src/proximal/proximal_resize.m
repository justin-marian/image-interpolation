function R = proximal_resize(I, p, q)
    % =============================================================== %
    % The image is scaled using the Proximal Interpolation algorithm. %
    %        Transform image I from m x n size to p x q size.         %
    % =============================================================== %

    % The size of the image.
    [m, n, nr_colors] = size(I);

    % The input image is converted to black and white, if necessary.
    if nr_colors > 1
        R = -1;
        return
    end

    % Initialize the final array as a null array.
    I = cast(I, "double");
    R = zeros(p, q);

    % Calculate the scaling factors.
    % resize image of size m X n in q X p, p > m & q > n ,
    % we perform the transformation of the coordinate system
    % by using the scaling constants s_x = q/n & s_y = p/m
    sx = (q - 1) / (n - 1);
    sy = (p - 1) / (m - 1);

    % Defines the transformation matrix for resizing.
    T = [sx 0;
         0 sy];
    % Invert the transformation matrix
    T = inv(T);

    % Go through every pixel in the coordinate system image.
    for y = 0 : p - 1
        for x = 0 : q - 1
            % Apply the inverse transformation on (x, y)
            % and calculate x_p and y_p of the initial image space.
            % x_0 = x_i * s_x
            % y_0 = y_i * s_y
            V = T * [x; y];
            V = V';

            % Pass (xp, yp) from coordinate system [0, n - 1] in
            % coordinate system [1, n] to apply the interpolation.
            % take x_0 & y_0 which will be used for
            xp = V(1); yp = V(2);
            xp = xp + 1;
            yp = yp + 1;

            % Calculate the nearest pixel.
            xp = round(xp);
            yp = round(yp);

            % Calculates the pixel value in the final image.
            R(y + 1, x + 1) = I(yp, xp);
        end
    end
    % Convert the resulting array to uint8 to be a valid image.
    R = cast(R, "uint8");
end

% Note: Same observation as to "proximal_rotate" about indexation
% If you work with indices from 1 to n and multiply x and y by
% s_x & s_y respectively, then the origin of the image will move
% from (1, 1) to (sx, sy)!
