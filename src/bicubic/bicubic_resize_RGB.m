function out = bicubic_resize_RGB(img, p, q)
    % ========================================================== %
    % Resize the img image so that this save is of p x q size    %
    %            The img image is colored                        %
    % ========================================================== %

    % Extract the red channel of the image.
    R = img(:, :, 1);
    % Extract the green channel of the image.
    G = img(:, :, 2);
    % Extract the blue channel of the image.
    B = img(:, :, 3);

    % Apply the bicubic function to the 3 channels of the image.
    Bicubic_R = bicubic_resize(R, p, q);
    Bicubic_G = bicubic_resize(G, p, q);
    Bicubic_B = bicubic_resize(B, p, q);

    % Form the final image by concatenating the 3 color channels.
    out = cat(3, Bicubic_R, Bicubic_G, Bicubic_B);
end
