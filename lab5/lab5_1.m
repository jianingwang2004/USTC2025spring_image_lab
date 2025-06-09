I = im2double(imread('flower1.jpg'));
psf = fspecial('motion', 30, 45); %生成运动模糊核

I_blurred = imfilter(I, psf, 'conv', 'circular'); %卷积模糊（边界处理为圆形扩展）
I1 = deconvwnr(I_blurred, psf); %无噪声时逆滤波与维纳滤波恢复

noise = 0.0001;
I_noisy = imnoise(I_blurred, 'gauss', 0, noise); %产生高斯噪声
I2 = deconvwnr(I_noisy, psf); %有噪声的逆滤波恢复
estimated_nsr = noise / var(I_blurred(:));
I3 = deconvwnr(I_noisy, psf, estimated_nsr); %有噪声的维纳滤波恢复

subplot(2,4,1); imshow(I); title('flower1'); 
subplot(2,4,2); imshow(I_blurred); title('运动模糊'); 
subplot(2,4,3); imshow(I1); title('运动模糊逆滤波'); 
subplot(2,4,4); imshow(I1); title('运动模糊维纳滤波'); 
subplot(2,4,6); imshow(I_noisy); title('高斯噪声'); 
subplot(2,4,7); imshow(I2); title('高斯噪声逆滤波'); 
subplot(2,4,8); imshow(I3); title('高斯噪声维纳滤波'); 