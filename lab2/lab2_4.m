I = imread('pout.bmp');
subplot(3,2,1); imshow(I); title('原图'); 

%使用 histogram 显示其灰度值分布
subplot(3,2,2); histogram(I);title('原图直方图');

%使用 histeq(I) 自动对原图进行均衡处理；
output1 = histeq(I);
subplot(3,2,3); imshow(output1);title('直方图均衡增强后图像');

%显示均衡后直方图，观察对比度提升效果。
subplot(3,2,4); histogram(output1);title('增强后直方图');

%使用 normpdf 生成正态分布概率密度函数（μ=60, σ=10）
%用 histeq(I, targetPDF) 实现灰度值的匹配
output2 = histeq(I,normpdf((0:1:255),60,10));
subplot(3,2,5); imshow(output2);title('直方图规定化');

%显示规定化处理后的图像与其直方图，可观察图像亮度向目标分布偏移。
subplot(3,2,6); histogram(output2);title('规定化后直方图');