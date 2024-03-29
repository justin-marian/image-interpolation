function r = fy(f, x, y)
    % ====================================================================== %
    % Approximates the derivative with respect to y of f at the point (x, y) %
    % ====================================================================== %

    % f - the pixel matrix written in the form of a function f
    [m, n] = size(f);

    % Calculate the derivative
    % In these 4 points (0,0), (0,1), (1,0) and (1,1)
    % the derivatives are known to be 0.

    % The maximum length of the image was exceeded y > n - 1
    % minimum image length exceeded y < 2
    if y + 1 > n || y - 1 < 1
        r = 0;
        return;
    else
        % the value of the partial derivative depending on y
        r = (f(x, y + 1) - f(x, y - 1)) / 2;
        return;
    end
end
