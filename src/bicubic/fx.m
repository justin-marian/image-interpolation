function r = fx(f, x, y)
    % ====================================================================== %
    % Approximates the derivative with respect to x of f at the point (x, y) %
    % ====================================================================== %

    % f - the pixel matrix written in the form of a function f
    [m, n] = size(f);

    % Calculate the derivative
    % In these 4 points (0,0), (0,1), (1,0) and (1,1)
    % the derivatives are known to be 0.

    % The maximum length of the image was exceeded x > m - 1
    % minimum image length exceeded x < 2
    if x > m - 1 || x  < 2
        r = 0;
        return;
    else
        r = (f(x + 1, y) - f(x - 1, y)) / 2;
        return;
    end
end
