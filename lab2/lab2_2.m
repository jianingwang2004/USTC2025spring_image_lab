I = imread('lena.bmp');
[max_x, max_y] = size(I);
output = zeros(max_x, max_y);

%输入三段线性变换控制点(x1, y1)和(x2, y2)，它们定义了灰度拉伸的分段区间
x1 = input("x1:");
y1 = input("y1:");
x2 = input("x2:");
y2 = input("y2:");

%遍历图像每个像素，根据其灰度值落入的区间进行拉伸变换。
%每段是一个线性函数，将原始灰度映射到新的灰度区间，实现对比度增强或压缩。
for i = 1 : max_x
    for j = 1 : max_y
        if(I(i, j) < x1)
            output(i, j) = y1 / x1 * I(i, j);%低灰度区
        else
            if(I(i, j) <= x2)
                output(i, j) = (y2 - y1)/(x2 - x1)*(I(i, j) - x1) + y1;%核心区域
            else
                output(i, j) = (255 - y2)/(255 - x2)*(I(i, j) - x2) + y2;%高灰度区
            end
        end
    end
end
subplot(1,2,1); imshow(I); 
subplot(1,2,2); imshow(uint8(output)); 