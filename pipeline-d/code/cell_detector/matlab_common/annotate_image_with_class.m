function image = annotate_image_with_class(image, points, colour, strength)
    disp("Annotating images function 2...");
    if size(image, 3)~=3
        error('Please input an RGB image');
    end
    disp("...1")
    image = im2double(image);
    disp("...2")
    label = zeros(size(image,1), size(image,2));
    disp("...3")
    points(:, 1) = min(max(points(:, 1), 1), size(image, 2));
    disp("...4")
    points(:, 2) = min(max(points(:, 2), 1), size(image, 1));
    disp("...5")
    linearInd = sub2ind(size(label), points(:,2), points(:,1));
    disp("...6")
    label(linearInd) = 1;
    disp("...7")
    label = imdilate(label, strel('disk', strength))>0;
    %     label = logical(repmat(label, [1, 1, 3]));
    disp("...8")    
    image1 = image(:,:,1);
    disp("...9")
    image2 = image(:,:,2);
    disp("...10")
    image3 = image(:,:,3);
    disp("...11")
    image1 = image1(:);
    disp("...12")
    image2 = image2(:);
    disp("...13")
    image3 = image3(:);
    disp("...14")
    image1(label(:)) = colour(1);
    disp("...15")
    image2(label(:)) = colour(2);
    disp("...16")
    image3(label(:)) = colour(3);
    disp("...17")
    image1 = reshape(image1, size(label));
    disp("...18")
    image2 = reshape(image2, size(label));
    disp("...19")
    image3 = reshape(image3, size(label));
    disp("...20")
    image = cat(3, image1, image2, image3);
end
