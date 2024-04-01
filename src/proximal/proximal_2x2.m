function out = proximal_2x2(f, STEP = 0.1)
    % ================================================================== %
    % Apply Proximal Interpolation to the 2 x 2 f image with equidistant %
    %      intermediate points, f has known values at the points:        %
    %                 (1, 1), (1, 2), (2, 1) and (2, 2)                  %
    % ================================================================== %

    % Defines the x and y coordinates of the intermediate points.
    x_ = 1 : STEP : 2;
    y_ = 1 : STEP : 2;

    % Number of points.
    n = length(x_);

    % The 4 bounding points will be the same for all points inside.
    x1 = 1; y1 = 1; x2 = 2; y2 = 2;

    % Initialize the result with a null n x n matrix.
    out = zeros(n);

    % Each pixel in the final image is scanned.
    for i = 1 : n
        for j = 1 : n
            % Find the closest pixel in the initial image.
            % the closest pixel in the initial image is given
            % of the rounding of the coordinate (x,y)
            pixel = round([x_(i), y_(j)]);
            % Calculate the pixel in the final image.
            out(i, j) = f(pixel(x1), pixel(y1));
        end
    end
end
