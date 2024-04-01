function out = proximal_2x2_RGB(img, STEP = 0.1)
    % ============================================================== %
    % Apply Proximal Interpolation on the 2 x 2 image defined by img %
    %    with equidistant intermediate points, img is an image       %
    %              colored RGB - Red, Green, Blue                    %
    % ============================================================== %

    % Extract the red channel of the image
    R = img(:, :, 1);
    % Extract the green channel of the image
    G = img(:, :, 2);
    % Extract the blue channel of the image
    B = img(:, :, 3);

    % Apply the proximal function on the 3 image channels.
    Proximal_2x2_R = proximal_2x2(R, STEP);
    Proximal_2x2_G = proximal_2x2(G, STEP);
    Proximal_2x2_B = proximal_2x2(B, STEP);

    % Form the final image by concatenating the 3 color channels.
    out = cat(3 , Proximal_2x2_R, Proximal_2x2_G, Proximal_2x2_B);
end
