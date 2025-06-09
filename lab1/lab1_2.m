I = imread('1.jpg');
[max_x, max_y, z] = size(I);
output1 = zeros(max_x, max_y, z);
output2 = zeros(max_x, max_y, z);
t = input('t:');%顺时针旋转度数
theta = (-t) / 180.0 * pi ;%由于矩阵是靠从目标图向原点的映射，故方向取反
a = max_x / 2;
b = max_y / 2;
%旋转矩阵
rot_matrix = [1 0 a; 0 1 b; 0 0 1] * [cos(theta) -sin(theta) 0; sin(theta) cos(theta) 0; 0 0 1] * [1 0 -a; 0 1 -b; 0 0 1];
%最近邻插值
for i = 1 : max_x   %旋转不做坐标轴处理，原因是绕中心点没影响
	for j = 1 : max_y
		p = [i; j; 1];
		p = rot_matrix \ p;
		x = round(p(1, 1));
		y = round(p(2, 1));
		if (x <= max_x) && (y <= max_y) && (x >= 1) && (y >= 1)
			for k = 1 : z
				output1(i, j, k) = I(x, y, k);
			end
		end
	end
end
%双线性插值
for i = 1 : max_x
	for j = 1 : max_y
		p = [i; j; 1];
		p = rot_matrix \ p;
		x = p(1, 1);
		y = p(2, 1);
		fx = x - floor(x); 
        fy = y - floor(y);  
		if (x <= max_x) && (y <= max_y) && (x >= 1) && (y >= 1)
			ul = [floor(x) floor(y)];%左上
           	ur = [floor(x)  ceil(y)];%右上
            dl = [ ceil(x) floor(y)];%左下
            dr = [ ceil(x)  ceil(y)];%右下
            to_ul = (1 - fx) * (1 - fy);%到左上的权值
            to_ur = (1 - fx) *      fy ;%到右上的权值
           	to_dl =      fx  * (1 - fy);%到左下的权值
            to_dr =      fx  *      fy ;%到右下的权值
			for k = 1 : z
				output2(i, j, k) =	to_ul * I(ul(1, 1), ul(1, 2), k) + ...
                                    to_ur * I(ur(1, 1), ur(1, 2), k) + ...
                                    to_dl * I(dl(1, 1), dl(1, 2), k) + ...
                                    to_dr * I(dr(1, 1), dr(1, 2), k);
			end
		end
	end
end
subplot(1,3,1); imshow(I);
subplot(1,3,2); imshow(uint8(output1));
subplot(1,3,3); imshow(uint8(output2));