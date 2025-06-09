I = imread('1.jpg');
[max_x, max_y, z] = size(I);
tx = input('tx:');%x轴放大倍数
ty = input('ty:');%y轴放大倍数
%适应缩放后新边界
new_x = round(max_x * ty);
new_y = round(max_y * tx);
%建立缩放后空白图
output1 = zeros(new_x, new_y, z);
output2 = zeros(new_x, new_y, z);
scaling_matrix = [tx 0 0; 0 ty 0; 0 0 1];%缩放矩阵
%最近邻插值
for i = 1 : new_y
	for j = 1 : new_x
		p = [i; j; 1];
		p = scaling_matrix \ p;
		x = round(p(1, 1));
		y = round(p(2, 1));
		if (x <= max_y) && (y <= max_x) && (x >= 1) && (y >= 1)
			for k = 1 : z
				output1(j, i, k) = I(y, x, k);
			end
		end
	end
end
%双线性插值
for i = 1 : new_y
	for j = 1 : new_x
		p = [i; j; 1];
		p = scaling_matrix \ p;
		x = p(1, 1);
		y = p(2, 1);
		fx = x - floor(x); 
        fy = y - floor(y);
		if (x <= max_y) && (y <= max_x) && (x >= 1) && (y >= 1)
			ul = [floor(x) floor(y)];
           	ur = [floor(x)  ceil(y)];
            dl = [ ceil(x) floor(y)];
            dr = [ ceil(x)  ceil(y)];
            to_ul = (1 - fx) * (1 - fy);
            to_ur = (1 - fx) *      fy ;
           	to_dl =      fx  * (1 - fy);
            to_dr =      fx  *      fy ;
			for k = 1 : z
				output2(j, i, k) =	to_ul * I(ul(1, 2), ul(1, 1), k) + ...
                                    to_ur * I(ur(1, 2), ur(1, 1), k) + ...
                                    to_dl * I(dl(1, 2), dl(1, 1), k) + ...
                                    to_dr * I(dr(1, 2), dr(1, 1), k);
			end
		end
	end
end
subplot(1,3,1); imshow(I);
subplot(1,3,2); imshow(uint8(output1));
subplot(1,3,3); imshow(uint8(output2));