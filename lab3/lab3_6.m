I1 = imread('lena.bmp');
I2 = imread('blood.bmp');
%Roberts算子
Roberts1 = edge(I1,'Roberts');
Roberts2 = edge(I2,'Roberts');
%Sobel算子
Sobel1 = edge(I1,'Sobel','horizontal');
Sobel2 = edge(I1,'Sobel','vertical');
Sobel3 = edge(I2,'Sobel','horizontal');
Sobel4 = edge(I2,'Sobel','vertical');
%Prewitt算子
Prewitt1 = edge(I1,'Prewitt','horizontal');
Prewitt2 = edge(I1,'Prewitt','vertical');
Prewitt3 = edge(I2,'Prewitt','horizontal');
Prewitt4 = edge(I2,'Prewitt','vertical');
%拉普拉斯算子
Laplacian1 = imfilter(I1,[ 0  1  0;  1 -4  1;  0  1  0]);
Laplacian2 = imfilter(I1,[-1 -1 -1; -1  8 -1; -1 -1 -1]);
Laplacian3 = imfilter(I2,[ 0  1  0;  1 -4  1;  0  1  0]);
Laplacian4 = imfilter(I2,[-1 -1 -1; -1  8 -1; -1 -1 -1]);
%Canny算子
Canny1 = edge(I1,'Canny');
Canny2 = edge(I2,'Canny');

subplot(6,4,1); imshow(I1); title('lena'); 
subplot(6,4,5); imshow(Roberts1); title('Roberts1'); 
subplot(6,4,6); imshow(Sobel1); title('Sobel1'); 
subplot(6,4,7); imshow(Sobel2); title('Sobel2'); 
subplot(6,4,8); imshow(Prewitt1); title('Prewitt1'); 
subplot(6,4,9); imshow(Prewitt2); title('Prewitt2'); 
subplot(6,4,10); imshow(Laplacian1); title('Laplacian1'); 
subplot(6,4,11); imshow(Laplacian2); title('Laplacian2'); 
subplot(6,4,12); imshow(Canny1); title('Canny1'); 

subplot(6,4,13); imshow(I2); title('blood'); 
subplot(6,4,17); imshow(Roberts2); title('Roberts2'); 
subplot(6,4,18); imshow(Sobel3); title('Sobel3'); 
subplot(6,4,19); imshow(Sobel4); title('Sobel4'); 
subplot(6,4,20); imshow(Prewitt3); title('Prewitt3'); 
subplot(6,4,21); imshow(Prewitt4); title('Prewitt4'); 
subplot(6,4,22); imshow(Laplacian3); title('Laplacian3'); 
subplot(6,4,23); imshow(Laplacian4); title('Laplacian4'); 
subplot(6,4,24); imshow(Canny2); title('Canny2'); 