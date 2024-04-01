function a = proximal_coef(f, x1, y1, x2, y2)
    % ============================================================================= %
    % Calculates the coefficients 'a' for Proximal Interpolation between the points %
    %              (x1, y1), (x1, y2), (x2, y1), and (x2, y2).                      %
    % ============================================================================= %

    % Calculate the matrix A.
    % f(x, y) = a0 + a1*x + a2*y + a3*x*y
    % The form of f(x,y) can be reduced to a linear system of equations
    A = [1 x1 y1 x1 * y1;
         1 x1 y2 x1 * y2;
         1 x2 y1 x2 * y1;
         1 x2 y2 x2 * y2];

    % Calculate the right-hand side vector 'b' of the linear system
    b = double([f(y1, x1), f(y2, x1), f(y1, x2), f(y2, x2)]');

    % Solve the linear system to calculate the coefficients 'a'
    a = A \ b;
end
