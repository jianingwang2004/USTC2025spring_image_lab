I = imread('1.jpg');
[max_x, max_y, z] = size(I);%取边界
output = zeros(max_x, max_y, z);%构造空白图
tx = input('tx:');%x轴平移量
ty = input('ty:');%y轴平移量
trans_matrix = [1 0 tx; 0 1 -ty; 0 0 1];%由于MATLAB坐标轴是x轴正方向向下，
                                        %y轴正方向向右，所以要实现传统意义
                                        %的平移，本题中x为实际的y，y为实际
                                        %的x，-ty实际上是将向下的“x轴”变成
                                        %向上的“y轴”。以后题目同理。
for i = 1 : max_y
	for j = 1 : max_x
		p = [i; j; 1];
		p = trans_matrix * p;%矩阵变换
		x1 = p(1, 1);
		y1 = p(2, 1);
		if (x1 <= max_y) && (y1 <= max_x) && (x1 >= 1) && (y1 >= 1)
			for k = 1 : z
				output(y1, x1, k) = I(j, i, k);
			end
		end
	end
end
subplot(1,2,1); imshow(I);
subplot(1,2,2); imshow(uint8(output));