function R = nn_resize(I, p, q)
    % ======================================================================= %
    % Upscaling the image using the nearest-neighbor interpolation algorithm  %
    %      Transforms the input image I from size m x n to size p x q         %
    %               m - number of rows, p - number of rows                    %
    %            n - number of columns, q - number of columns                 %
    % ======================================================================= %

    % The size of the image.
    [m, n, nr_colors] = size(I);

    % Convert the input image to grayscale if it has multiple color channels
    if nr_colors > 1
        R = -1;
        return
    end

    % Initialize the final matrix
    R = zeros(p, q);

    % Calculate the scaling factors
    s_x = (q - 1) / (n - 1);
    s_y = (p - 1) / (m - 1);

    % Define the transformation matrix for resizing
    T = zeros(2, 2);
    T(1, 1) = s_x;
    T(2, 2) = s_y;

    % Calculate the inverse transformation
    T1 = inv(T);

    % Traverse each pixel in the image
    for y = 0 : p - 1
        for x = 0 : q - 1
            % Apply the inverse transformation to (x, y) and calculate
            % x_p and y_p in the original image space
            v = zeros(2, 1);
            v = T1 * [x; y];
            x_p = v(1, 1);
            y_p = v(2, 1);

            % Convert (xp, yp) from the coordinate system from 0 to n - 1 to
            % the coordinate system from 1 to n in order to apply interpolation
            x_p = x_p + 1;
            y_p = y_p + 1;

            % Calculate the nearest neighbor
            closer_x = round(x_p);
            closer_y = round(y_p);

            % Calculate the value of the pixel in the final image
            R(y + 1 , x + 1) = I(closer_y, closer_x);
        end
    end
    % Convert the result matrix to uint8
    R = uint8(R);
end

% Note: When applying scaling, the pixel (0, 0) of the image will not move.
% In MATLAB/Octave, image pixels are indexed from 1 to n.
% If working with indices from 1 to n and scaling x and y by s_x and s_y,
% then the origin of the image will move from (1, 1) to (sx, sy)!
% Therefore, we need to work with indices in the interval [0, n - 1]!
% Note: when working with indices in the interval [0, n - 1], the last
% pixel of the image will move from (m - 1, n - 1) to (p, q).
