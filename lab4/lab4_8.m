I = imread('Pout.bmp');
D = 30; %截止频率
n = 1;
a = 4;
b = 1;
subplot(2,4,1); imshow(I, []); title('Pout'); 
subplot(2,4,2); imshow(histeq(uint8(IHPF(I, D, a, b))), []);    title('Pout IHPF-直方图'); 
subplot(2,4,3); imshow(histeq(uint8(BHPF(I, D, n, a, b))), []); title('Pout BHPF-直方图'); 
subplot(2,4,4); imshow(histeq(uint8(EHPF(I, D, n, a, b))), []); title('Pout EHPF-直方图');
subplot(2,4,6); imshow(IHPF(histeq(I), D, a, b), []);           title('Pout 直方图-IHPF'); 
subplot(2,4,7); imshow(BHPF(histeq(I), D, n, a, b), []);        title('Pout 直方图-BHPF'); 
subplot(2,4,8); imshow(EHPF(histeq(I), D, n, a, b), []);        title('Pout 直方图-EHPF');

function output = get_D(input)
    [max_x, max_y] = size(input);
    [X, Y] = meshgrid(-max_y/2 : max_y/2 - 1, -max_x/2 : max_x/2 - 1);
    output = hypot(X, Y); %计算每个点到频域中心的距离
end

%理想高通滤波器
function output = IHPF(input, D0, a, b)
    F = fftshift(fft2(input)); %傅里叶变换并将频率图像中心移到图像中央
    D = get_D(input);
    H = D > D0 ;
    H = a * H + b;
    output = abs(ifft2(ifftshift(F .* H)));
end

%巴特沃斯高通滤波器
function output = BHPF(input, D0, n, a, b)
    F = fftshift(fft2(input)); %傅里叶变换并将频率图像中心移到图像中央
    D = get_D(input);
    H = 1 ./ (1 + ((D0 ./ D) .^ (2 * n)));
    H = a * H + b;
    output = abs(ifft2(ifftshift(F .* H)));
end

%高斯高通滤波器
function output = EHPF(input, D0, n, a, b)
    F = fftshift(fft2(input)); %傅里叶变换并将频率图像中心移到图像中央
    D = get_D(input);
    H = exp(-(D0 ./ D) .^ n);
    H = a * H + b;
    output = abs(ifft2(ifftshift(F .* H)));
end