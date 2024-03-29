function [score] = checker_nearest_neighbours()
    NN_points = 30;

    [NN_4point, NN_4point_max] = runtests("checker_props/checker-nearest_4point.m");
    printf("Interpolate 4 points: %d / %d teste trecute.\n", NN_4point, NN_4point_max);

    [NN_resize, NN_resize_max] = runtests("checker_props/checker-nearest_resize.m");
    printf("Resize image: %d / %d teste trecute.\n", NN_resize, NN_resize_max);

    [NN_4point_RGB, NN_4point_RGB_max] = runtests("checker_props/checker-nearest_4point_RGB.m");
    printf("Interpolate 4 points RGB: %d / %d teste trecute.\n", NN_4point_RGB, NN_4point_RGB_max);

    [NN_resize_RGB, NN_resize_RGB_max] = runtests("checker_props/checker-nearest_resize_RGB.m");
    printf("Resize RGB image: %d / %d teste trecute.\n", NN_resize_RGB, NN_resize_RGB_max);

    score = NN_points * (NN_4point / NN_4point_max / 4 + NN_resize / NN_resize_max / 4 +...
                         NN_4point_RGB / NN_4point_RGB_max / 4 + NN_resize_RGB / NN_resize_RGB_max / 4);
    printf("Punctaj total: %.2f\n", score);

    fout = fopen("results", "w");
    fprintf(fout, "%.2f", score);
    fclose(fout);
end
