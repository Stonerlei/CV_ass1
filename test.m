clear all
image = imread('d.png');
% image = double(mean(image, 3));
size_filter = 7;
%%
%高斯滤波
filter = Gen_Gauss_filter(50, size_filter);
filter = conv(filter, filter);
filter = filter/sum(filter, 'all');
% tic
G = conv(image, filter);
G = conv(G, filter);
t2 = clock;
% toc
% disp(['运行时间: ',num2str(toc)]);
imshow(G)
%%
%%高斯核之差进行滤波
filter1 = Gen_Gauss_filter(100, size_filter);
filter2 = Gen_Gauss_filter(50, size_filter);
% filter1 = filter1/sum(filter1, 'all');
% filter2 = filter2/sum(filter2, 'all');
filter = filter1 - filter2;
G_D = conv(image, filter);
% imshow(G_D)
%%
%双边滤波
B = bilateral_filter(image, 100, 100, 13);
% imshow(B)
%%
%两个一维高斯核相继卷积
var1 = 100;
var2 = 100;
center = floor(size_filter/2) +1;
filter1 = zeros(1, size_filter);
filter2 = zeros(size_filter, 1);
for i = 1:size_filter
        filter1(i,1) = 1/(2*pi*var1)^0.5*exp(-(i-center)^2/(2*var1));
        filter2(1,i) = 1/(2*pi*var2)^0.5*exp(-(i-center)^2/(2*var2));
end
% tic
G_F = conv(image, filter2);
imshow(G_F)
G_F = conv(G_F, filter2);
% toc
% disp(['运行时间: ',num2str(toc)]);
% imshow(G_F)
%%
%傅里叶变换
gauss_filter = Gen_Gauss_filter(100, size_filter);
F_G = conv(image, gauss_filter);
size = size(image);
% transformed = zeros(size);
transformed = fft2(image);
transformed_b = fft2(F_G);
% for u = 1:size(1)
%     for v = 1:size(2)
%         for x = 1:size(1)
%             for y = 1:size(2)
%                 transformed(u,v) = transformed(u,v) + exp(-2i*pi*(u*x/size(1)+v*y/size(2)));
%             end
%         end
%     end
% end
amp = log(abs(transformed));
amp = amp/max(amp,[],'all');
phase = angle(transformed);
phase = log(phase*180/pi);
% imshow(amp, [])

% amp = log(abs(transformed_b));
% amp = amp/max(amp,[],'all');
% phase = angle(transformed_b);
% phase = log(phase*180/pi);
% imshow(amp, [])

% imshow(floor(0.2*F_G+image),[])

%%
figure(1)
imshow(B)
figure(2)
imshow(G_F)
figure(3)
imshow(G)
figure(4)
imshow(G_D)
figure(5)
imshow(amp, [])