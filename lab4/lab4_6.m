I = imread('Girl.bmp');
D = 30; %截止频率
n = 1;

%添加噪声
I_p = imnoise(I,'salt & pepper', 0.03);
I_g = imnoise(I,'gaussian');

figure();
subplot(3,3,1); imshow(I, []); title('Girl'); 
subplot(3,3,2); imshow(I_p, []); title('Girl椒盐'); 
subplot(3,3,3); imshow(I_g, []); title('Girl高斯'); 
subplot(3,3,4); imshow(ILPF(I_p, D), []);    title('Girl椒盐ILPF'); 
subplot(3,3,5); imshow(BLPF(I_p, D, n), []); title('Girl椒盐BLPF'); 
subplot(3,3,6); imshow(ELPF(I_p, D, n), []); title('Girl椒盐ELPF');
subplot(3,3,7); imshow(ILPF(I_g, D), []);    title('Girl高斯ILPF'); 
subplot(3,3,8); imshow(BLPF(I_g, D, n), []); title('Girl高斯BLPF'); 
subplot(3,3,9); imshow(ELPF(I_g, D, n), []); title('Girl高斯ELPF');

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