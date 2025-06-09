I = imread('lena.bmp');

subplot(1, 3, 1); imshow(I); title('原图'); 
T1 = OSTU(I);
subplot(1, 3, 2); imshow(imbinarize(I, T1)); title('OTSU');
T2 = graythresh(I);
subplot(1, 3, 3); imshow(imbinarize(I, T2)); title('graythresh');

function output = OSTU(input)
    N = numel(input); %计算像素个数
    counts = imhist(input); %计算灰度直方图
    P = counts / N; %每个灰度值出现概率
    
    w = zeros(1, 257); %累积概率
    u = zeros(1, 257); %累积均值
    
    for i = 1:256
        w(i + 1) = w(i) + P(i); %概率和
        u(i + 1) = u(i) + (i - 1) * P(i); %加权均值和
    end
    
    % 总均值
    uT = u(end);
    
    % 计算类间方差
    g = zeros(1, 256); %类间方差
    for t = 1 : 256
        if w(t) == 0 || (1 - w(t)) == 0
            g(t) = 0;
        else
            g(t) = (uT * w(t) - u(t)) ^ 2 / (w(t) * (1 - w(t)));
        end
    end
    
    output = (find(g == max(g)) - 2) / 255;
end
