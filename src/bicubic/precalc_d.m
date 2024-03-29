function [Ix, Iy, Ixy] = precalc_d(I)
    % ============================================================= %
    %    Precalculates the matrices Ix, Iy and Ixy that contain     %
    %  the derivatives dx, dy, dxy of image I for each pixel of it  %
    % ============================================================= %

    % The size of the image.
    [m, n, nr_colors] = size(I);

    % Transform matrix I into double.
    I = cast(I, "double");

    % Calculate the derivative matrix with respect to x Ix.
    for x = 1 : m
        for y = 1 : n
            Ix(x, y) = fy(I, x, y);
        end
    end
    
    % Calculate the derivative matrix with respect to y Iy.
    for x = 1 : m
        for y = 1 : n
            Iy(x, y) = fx(I, x, y);
        end
    end
    
    % Calculate the derivative matrix with respect to xy Ixy.
    for x = 1 : m
        for y = 1 : n
            Ixy(x, y) = fxy(I, x, y);
        end
    end
end
