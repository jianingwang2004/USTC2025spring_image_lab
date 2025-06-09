I1 = imread('Pout.bmp');
I2 = imread('Girl.bmp');
D = 10; %截止频率
n = 1;

subplot(2,4,1); imshow(I1, []); title('Pout'); 
subplot(2,4,2); imshow(IHPF(I1, D), []);    title('Pout IHPF'); 
subplot(2,4,3); imshow(BHPF(I1, D, n), []); title('Pout BHPF'); 
subplot(2,4,4); imshow(EHPF(I1, D, n), []); title('Pout EHPF');
subplot(2,4,5); imshow(I2); title('Girl'); 
subplot(2,4,6); imshow(IHPF(I2, D), []);    title('Girl IHPF');
subplot(2,4,7); imshow(BHPF(I2, D, n), []); title('Girl BHPF'); 
subplot(2,4,8); imshow(EHPF(I2, D, n), []); title('Girl EHPF'); 

function output = get_D(input)
    [max_x, max_y] = size(input);
    [X, Y] = meshgrid(-max_y/2 : max_y/2 - 1, -max_x/2 : max_x/2 - 1);
    output = hypot(X, Y); %计算每个点到频域中心的距离
end

%理想高通滤波器
function output = IHPF(input, D0)
    F = fftshift(fft2(input)); %傅里叶变换并将频率图像中心移到图像中央
    D = get_D(input);
    H = D > D0 ;
    output = abs(ifft2(ifftshift(F .* H)));
end

%巴特沃斯高通滤波器
function output = BHPF(input, D0, n)
    F = fftshift(fft2(input)); %傅里叶变换并将频率图像中心移到图像中央
    D = get_D(input);
    H = 1 ./ (1 + ((D0 ./ D) .^ (2 * n)));
    output = abs(ifft2(ifftshift(F .* H)));
end

%高斯高通滤波器
function output = EHPF(input, D0, n)
    F = fftshift(fft2(input)); %傅里叶变换并将频率图像中心移到图像中央
    D = get_D(input);
    H = exp(-(D0 ./ D) .^ n);
    output = abs(ifft2(ifftshift(F .* H)));
end