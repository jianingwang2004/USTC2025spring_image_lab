I = imread('lena.bmp');
%添加噪声
I_1 = imnoise(I,'salt & pepper',0.03);
I_2 = imnoise(I,'gaussian');
a = 0.2;
noise = a * (2 * rand(size(I)) - 1);
I_3 = double(I) + noise * 255;
I_3 = uint8(max(0, min(I_3, 255)));
%超限邻域平均滤波器

function [output] = filter1(input,T)
    output = input;
    [max_x, max_y] = size(output);
    for i = 2 : (max_x - 1)
        for j = 2 : (max_y - 1)
            mean_value = mean(mean(input(i - 1 : i + 1, j - 1 : j + 1)));%计算均值
            if(abs(double(input(i,j)) - mean_value) > T)%超限滤波
                output(i,j) = mean_value;
            end
        end
    end
end
%超限中值滤波器
function [output] = filter2(input,T)
    output = input;
    [max_x, max_y] = size(output);
    for i = 2 : (max_x - 1)
        for j = 2 : (max_y - 1)
            temp = input(i - 1 : i + 1, j - 1 : j + 1);
            middle_value = median(temp(:));
            if(abs(double(input(i,j)) - double(middle_value)) > T)
                output(i,j) = middle_value;
            end
        end
    end
end
%均值滤波
I_1out_1 = imfilter(I_1, fspecial('average',3));
I_2out_1 = imfilter(I_2, fspecial('average',3));
I_3out_1 = imfilter(I_3, fspecial('average',3));
%超限邻域平均滤波
I_1out_2 = filter1(I_1,35);
I_2out_2 = filter1(I_2,35);
I_3out_2 = filter1(I_3,35);
%中值滤波
I_1out_3 = medfilt2(I_1);
I_2out_3 = medfilt2(I_2);
I_3out_3 = medfilt2(I_3);
%超限中值滤波
I_1out_4 = filter2(I_1,35);
I_2out_4 = filter2(I_2,35);
I_3out_4 = filter2(I_3,35);
subplot(5,4, 1); imshow(       I); title('原图'); 
subplot(5,4, 2); imshow(     I_1); title('3%椒盐噪声'); 
subplot(5,4, 3); imshow(     I_2); title('高斯噪声'); 
subplot(5,4, 4); imshow(     I_3); title('随机噪声'); 
subplot(5,4, 6); imshow(I_1out_1); title('3%椒盐噪声均值滤波'); 
subplot(5,4, 7); imshow(I_2out_1); title('高斯噪声均值滤波'); 
subplot(5,4, 8); imshow(I_3out_1); title('随机噪声均值滤波'); 
subplot(5,4,10); imshow(I_1out_2); title('3%椒盐噪声超限邻域平均滤波'); 
subplot(5,4,11); imshow(I_2out_2); title('高斯噪声超限邻域平均滤波'); 
subplot(5,4,12); imshow(I_3out_2); title('随机噪声超限邻域平均滤波'); 
subplot(5,4,14); imshow(I_1out_3); title('3%椒盐噪声中值滤波'); 
subplot(5,4,15); imshow(I_2out_3); title('高斯噪声中值滤波'); 
subplot(5,4,16); imshow(I_3out_3); title('随机噪声中值滤波'); 
subplot(5,4,18); imshow(I_1out_4); title('3%椒盐噪声超限中值滤波'); 
subplot(5,4,19); imshow(I_2out_4); title('高斯噪声超限中值滤波'); 
subplot(5,4,20); imshow(I_3out_4); title('随机噪声超限中值滤波'); 