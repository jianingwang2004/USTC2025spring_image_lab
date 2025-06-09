R = imread('alphabet1.jpg');
I = imread('alphabet2.jpg');
subplot(1,2,1); imshow(I);
subplot(1,2,2); imshow(R);
[x, y] = ginput(8);%手动取4组对应点
clf;%清空图像
movingPoints = [x(1) y(1); x(3) y(3); x(5) y(5); x(7) y(7)];
fixedPoints  = [x(2) y(2); x(4) y(4); x(6) y(6); x(8) y(8)];
tform = fitgeotform2d(movingPoints, fixedPoints, 'projective');
output = imwarp(I, tform);
subplot(1,2,1); imshow(R);
subplot(1,2,2); imshow(output);