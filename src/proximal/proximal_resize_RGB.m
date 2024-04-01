function out = proximal_resize_RGB(img, p, q)
    % ================================================== %
    % Resize the image img in such way to be size p x q  %
    %             The img image is colored               %
    % ================================================== %

    % Extract the red channel of the image
    R = img(:, :, 1);
    % Extract the green channel of the image
    G = img(:, :, 2);
    % Extract the blue channel of the image
    B = img(:, :, 3);

    % Apply the resize to each channel of the image
    Proximal_RES_R = proximal_resize(R, p, q);
    Proximal_RES_G = proximal_resize(G, p, q);
    Proximal_RES_B = proximal_resize(B, p, q);

    % Rebuild the final RGB image
    out = cat(3, Proximal_RES_R, Proximal_RES_G, Proximal_RES_B);
end
