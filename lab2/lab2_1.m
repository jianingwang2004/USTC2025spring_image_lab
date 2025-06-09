I = imread('lena.bmp');
[max_x, max_y] = size(I);
output = zeros(max_x, max_y);
fA = input("斜率:");
fB = input("截距:");
for i = 1 : max_x
    for j = 1 : max_y
        output(i, j) = I(i, j) * fA + fB; %对每个像素点实现灰度值线性变换
    end
end
subplot(1,2,1); imshow(I); 
subplot(1,2,2); imshow(uint8(output)); 