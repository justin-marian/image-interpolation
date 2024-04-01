function out = nn_resize_RGB(img, STEP = 0.1)
    % ======================================================================== %
    % Apply Nearest Neighbours Interpolation on the 2 x 2 image defined by img %
    %          with equidistant intermediate points, img is an image           %
    %                    colored RGB - Red, Green, Blue                        %
    % ======================================================================== %

    % Extract the red channel of the image
    R = img(:, :, 1);
    % Extract the green channel of the image
    G = img(:, :, 2);
    % Extract the blue channel of the image
    B = img(:, :, 3);

    % Apply the nn function on the 3 image channels.
    NN_2x2_R = nn_resize(R, STEP);
    NN_2x2_G = nn_resize(G, STEP);
    NN_2x2_B = nn_resize(B, STEP);

    % Form the final image by concatenating the 3 color channels.
    out = cat(3 , NN_2x2_R, NN_2x2_G, NN_2x2_B);
end
