I = imread('lena.bmp');
min = input("下限:");
max = input("上限:");

%使用 MATLAB 的 histogram 函数，绘制灰度图像中像素灰度值的分布直方图
%'BinLimits'：设定直方图统计的灰度值区间为 [min, max]
histogram(I,'BinLimits',[min, max]);