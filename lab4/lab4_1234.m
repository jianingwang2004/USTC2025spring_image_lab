I1 = imread('Rect1.bmp');
I2 = imread('Rect2.bmp');
I3 = imread('lena.bmp');

%傅里叶变换
F1 = fft2(I1);
F2 = fft2(I2);
F3 = fft2(I3);
%移动低频至中心并对数增强
spectrum1 = log(abs(fftshift(F1)) + 1);
spectrum2 = log(abs(fftshift(F2)) + 1);
%幅度反变换
F1_mag = uint8(ifft2(abs(F1)));
F2_mag = uint8(ifft2(abs(F2)));
%相位反变换
F1_phase = abs( ifft2(exp(1i * angle(F1))));
F2_phase = uint8(abs(10000 * ifft2(exp(1i * angle(F2)))));
%共轭反变换
F3_conj = ifft2(conj(F3));

subplot(3,4, 1); imshow(I1, []); title('1'); 
subplot(3,4, 2); imshow(I2, []); title('2'); 
subplot(3,4, 3); imshow(I3, []); title('3'); 
subplot(3,4, 4); imshow(F3_conj, []); title('3共轭反变换');
subplot(3,4, 5); imshow(spectrum1, []); title('1幅度变换'); 
subplot(3,4, 7); imshow(spectrum2, []); title('2幅度变换');
subplot(3,4, 9); imshow(F1_mag, []);      title('1幅度反变换'); 
subplot(3,4,11); imshow(F2_mag, []);      title('2幅度反变换'); 
subplot(3,4, 6); imshow(F1_phase, []);    title('1相位反变换');
subplot(3,4, 8); imshow(F2_phase, []);    title('2相位反变换'); 