function out = proximal_rotate_RGB(img, rotation_angle)
    % ===================================================================== %
    % Apply Proximal Interpolation to rotate an RGB image by a given angle. %
    % ===================================================================== %

    % Extract the red channel of the image
    R = img(:, :, 1);
    % Extract the green channel of the image
    G = img(:, :, 2);
    % Extract the blue channel of the image
    B = img(:, :, 3);

    % Apply the rotation to each channel of the image
    Proximal_ROT_R = proximal_rotate(R, rotation_angle);
    Proximal_ROT_G = proximal_rotate(G, rotation_angle);
    Proximal_ROT_B = proximal_rotate(B, rotation_angle);

    % Rebuild the final RGB image
    out = cat(3, Proximal_ROT_R, Proximal_ROT_G, Proximal_ROT_B);
end
