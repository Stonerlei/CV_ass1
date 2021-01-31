function modified = conv(image, filter)
    size_image = size(image);
    size_filter = size(filter);
    size_modified = size_image;
    modified = zeros(size_modified);
    for m = 1:size_image(3)
        image_ch = image(:,:,m);
        %padding
        pad_image = zeros(size_image(1)+floor(size_filter(1))-1, size_image(2)+floor(size_filter(2))-1);
        
        pad_image(1:floor(size_filter(1)/2), 1:floor(size_filter(2)/2)) = image_ch(1:floor(size_filter(1)/2), 1:floor(size_filter(2)/2));
        pad_image(end-floor(size_filter(1)/2):end,1:floor(size_filter(2)/2)) = image_ch(end-floor(size_filter(1)/2):end,1:floor(size_filter(2)/2));
        pad_image(end-floor(size_filter(1)/2):end,end-floor(size_filter(2)/2):end) = image_ch(end-floor(size_filter(1)/2):end,end-floor(size_filter(2)/2):end);
        pad_image(1:floor(size_filter(1)/2), end-floor(size_filter(2)/2):end) = image_ch(1:floor(size_filter(1)/2), end-floor(size_filter(2)/2):end);

        pad_image(floor(size_filter(1)/2)+1:end-floor(size_filter(1)/2), 1:floor(size_filter(2)/2)) = image_ch(:, 1:floor(size_filter(2)/2));
        pad_image(end-floor(size_filter(1)/2):end, floor(size_filter(2)/2)+1:end-floor(size_filter(2)/2)) = image_ch(end-floor(size_filter(1)/2):end, :);
        pad_image(floor(size_filter(1)/2)+1:end-floor(size_filter(1)/2), end-floor(size_filter(2)/2):end) = image_ch(:, end-floor(size_filter(2)/2):end);
        pad_image(1:floor(size_filter(1)/2), floor(size_filter(2)/2)+1:end-floor(size_filter(2)/2)) = image_ch(1:floor(size_filter(1)/2), :);

        pad_image(floor(size_filter(1)/2)+1:end-floor(size_filter(1)/2), floor(size_filter(2)/2)+1: end-floor(size_filter(2)/2)) = image_ch;

        image_ch = pad_image;
        %convolving
        for i = 1:size_modified(1)
            for j = 1:size_modified(2)
                modified(i,j,m) =  sum(image_ch(i:i+size_filter(1)-1, j:j+size_filter(2)-1).*filter, 'all');
            end
        end
        modified(:,:,m) = modified(:,:,m)/max(modified(:,:,m),[], 'all');
    end
%     modified = modified/max(modified, 'all');
%     modified = im2uint8(modified);
end