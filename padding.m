function pad_image = padding(image, pad_type, size_filter)
    size_image = size(image);
    size_filter = [size_filter, size_filter];
    pad_image = zeros(size_image(1)+floor(size_filter(1))-1, size_image(2)+floor(size_filter(2))-1,size_image(3));
    for ch = 1:size_image(3)
        image_ch = image(:,:,ch);
        pad_image_ch = zeros(size_image(1)+floor(size_filter(1))-1, size_image(2)+floor(size_filter(2))-1);
        size_image_ch = size(image_ch);
        size_pad = size(pad_image_ch);
        if strcmp(pad_type, 'reflect')
            pad_image_ch(1:floor(size_filter(1)/2), 1:floor(size_filter(2)/2)) = image_ch(floor(size_filter(1)/2):-1:1, floor(size_filter(2)/2):-1:1);
            pad_image_ch(end-floor(size_filter(1)/2):end,1:floor(size_filter(2)/2)) = image_ch(end:-1:end-floor(size_filter(1)/2),floor(size_filter(2)/2):-1:1);
            pad_image_ch(end-floor(size_filter(1)/2):end,end-floor(size_filter(2)/2):end) = image_ch(end:-1:end-floor(size_filter(1)/2),end:-1:end-floor(size_filter(2)/2));
            pad_image_ch(1:floor(size_filter(1)/2), end-floor(size_filter(2)/2):end) = image_ch(floor(size_filter(1)/2):-1:1, end:-1:end-floor(size_filter(2)/2));

            pad_image_ch(floor(size_filter(1)/2)+1:end-floor(size_filter(1)/2), 1:floor(size_filter(2)/2)) = image_ch(:, floor(size_filter(2)/2):-1:1);
            pad_image_ch(end-floor(size_filter(1)/2):end, floor(size_filter(2)/2)+1:end-floor(size_filter(2)/2)) = image_ch(end:-1:end-floor(size_filter(1)/2), :);
            pad_image_ch(floor(size_filter(1)/2)+1:end-floor(size_filter(1)/2), end-floor(size_filter(2)/2):end) = image_ch(:, end:-1:end-floor(size_filter(2)/2));
            pad_image_ch(1:floor(size_filter(1)/2), floor(size_filter(2)/2)+1:end-floor(size_filter(2)/2)) = image_ch(floor(size_filter(1)/2):-1:1, :);

            pad_image_ch(floor(size_filter(1)/2)+1:end-floor(size_filter(1)/2), floor(size_filter(2)/2)+1: end-floor(size_filter(2)/2)) = image_ch;
        elseif strcmp(pad_type, 'zero')
            pad_image_ch(1:floor(size_filter(1)/2), 1:floor(size_filter(2)/2)) = 0;
            pad_image_ch(end-floor(size_filter(1)/2):end,1:floor(size_filter(2)/2)) = 0;
            pad_image_ch(end-floor(size_filter(1)/2):end,end-floor(size_filter(2)/2):end) = 0;
            pad_image_ch(1:floor(size_filter(1)/2), end-floor(size_filter(2)/2):end) = 0;

            pad_image_ch(floor(size_filter(1)/2)+1:end-floor(size_filter(1)/2), 1:floor(size_filter(2)/2)) = 0;
            pad_image_ch(end-floor(size_filter(1)/2):end, floor(size_filter(2)/2)+1:end-floor(size_filter(2)/2)) = 0;
            pad_image_ch(floor(size_filter(1)/2)+1:end-floor(size_filter(1)/2), end-floor(size_filter(2)/2):end) = 0;
            pad_image_ch(1:floor(size_filter(1)/2), floor(size_filter(2)/2)+1:end-floor(size_filter(2)/2)) = 0;

            pad_image_ch(floor(size_filter(1)/2)+1:end-floor(size_filter(1)/2), floor(size_filter(2)/2)+1: end-floor(size_filter(2)/2)) = image_ch;
        elseif strcmp(pad_type, 'wrap')
            for i = 1:size_pad(1)
                for j = 1:size_pad(2)
                    mapi = mod(i-(floor(size_filter(1))-1)/2,size_image(1));
                    mapj = mod(j-(floor(size_filter(2))-1)/2,size_image(2));
                    if mapi == 0
                        mapi = size_image(1);
                    end
                    if mapj ==0
                        mapj = size_image(2);
                    end
                    pad_image_ch(i,j) = image_ch(mapi, mapj);
                end
            end
        elseif strcmp(pad_type, 'copyedge')
            for i = 1:size_pad(1)
                for j = 1:size_pad(2)
                    if i <= (floor(size_filter(1))-1)/2
                        if j <= (floor(size_filter(2))-1)/2
                            pad_image_ch(i,j) = image_ch(1,1);
                        elseif j > size_image_ch(2)+(floor(size_filter(2))-1)/2
                            pad_image_ch(i,j) = image_ch(1,end);
                        else
                            pad_image_ch(i,j) = image_ch(1, j-(floor(size_filter(2))-1)/2);
                        end
                    elseif i > size_image_ch(1)+(floor(size_filter(1))-1)/2
                        if j <= (floor(size_filter(2))-1)/2
                            pad_image_ch(i,j) = image_ch(end,1);
                        elseif j > size_image_ch(2)+(floor(size_filter(2))-1)/2
                            pad_image_ch(i,j) = image_ch(end,end);
                        else
                            pad_image_ch(i,j) = image_ch(end, j-(floor(size_filter(2))-1)/2);
                        end
                    else
                        if j <= (floor(size_filter(2))-1)/2
                            pad_image_ch(i,j) = image_ch(i-(floor(size_filter(1))-1)/2,1);
                        elseif j > size_image_ch(2)+(floor(size_filter(2))-1)/2
                            pad_image_ch(i,j) = image_ch(i-(floor(size_filter(1))-1)/2,end);
                        else
                            pad_image_ch(i,j) = image_ch(i-(floor(size_filter(1))-1)/2, j-(floor(size_filter(2))-1)/2);
                        end
                    end
                end
            end
        end
        pad_image(:,:,ch) = pad_image_ch;
        pad_image(:,:,ch) = pad_image(:,:,ch)/max(pad_image(:,:,ch),[],'all');
    end
end