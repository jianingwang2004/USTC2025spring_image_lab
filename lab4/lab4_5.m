I1 = imread('Pout.bmp');
I2 = imread('Girl.bmp');
D = 30; %截止频率
n = 1;

subplot(2,4,1); imshow(I1, []); title('Pout'); 
subplot(2,4,2); imshow(ILPF(I1, D), []);    title('Pout ILPF'); 
subplot(2,4,3); imshow(BLPF(I1, D, n), []); title('Pout BLPF'); 
subplot(2,4,4); imshow(ELPF(I1, D, n), []); title('Pout ELPF');
subplot(2,4,5); imshow(I2); title('Girl'); 
subplot(2,4,6); imshow(ILPF(I2, D), []);    title('Girl ILPF');
subplot(2,4,7); imshow(BLPF(I2, D, n), []); title('Girl BLPF'); 
subplot(2,4,8); imshow(ELPF(I2, D, n), []); title('Girl ELPF'); 

function output = get_D(input)
    [max_x, max_y] = size(input);
    [X, Y] = meshgrid(-max_y/2 : max_y/2 - 1, -max_x/2 : max_x/2 - 1);
    output = hypot(X, Y); %计算每个点到频域中心的距离
end

%理想低通滤波器
function output = ILPF(input, D0)
    F = fftshift(fft2(input)); %傅里叶变换并将频率图像中心移到图像中央
    D = get_D(input);
    H = D <= D0; %距离中心小于D0的保留，其它为0
    output = abs(ifft2(ifftshift(F .* H)));
end

%巴特沃斯低通滤波器
function output = BLPF(input, D0, n)
    F = fftshift(fft2(input)); %傅里叶变换并将频率图像中心移到图像中央
    D = get_D(input);
    H = 1 ./ (1 + ((D ./ D0) .^ (2 * n))); % n是阶数，控制过渡平滑程度
    output = abs(ifft2(ifftshift(F .* H)));
end

%高斯低通滤波器
function output = ELPF(input, D0, n)
    F = fftshift(fft2(input)); %傅里叶变换并将频率图像中心移到图像中央
    D = get_D(input);
    H = exp(-(D ./ D0) .^ n); %高斯函数（类似钟形曲线），无振铃效应
    output = abs(ifft2(ifftshift(F .* H)));
end