function A = bicubic_coef(f, Ix, Iy, Ixy, x1, y1, x2, y2)
    % ================================================================== %
    % Calculate Bicubic Interpolation coefficients for 4 adjacent points %
    % ================================================================== %

    % Calculate intermediate matrices.
    T = [1  0  0  0 ;
         0  0  1  0 ;
        -3  3 -2 -1 ;
         2 -2  1  1];

    % The 16 equations, which form a system of linear equations.
    I = [f(y1, x1),  f(y2, x1),   Iy(y1, x1), Iy(y2, x1)   ;
         f(y1, x2),  f(y2, x2),   Iy(y1, x2), Iy(y2, x2)   ;
         Ix(y1, x1), Ix(y2, x1), Ixy(y1, x1), Ixy(y2, x1)  ;
         Ix(y1, x2), Ix(y2, x2), Ixy(y1, x2), Ixy(y2, x2)];

    % Convert intermediate arrays to doubles.
    I = cast(I, "double");

    % Calculate final matrix.
    A =  T * I * T';
end
