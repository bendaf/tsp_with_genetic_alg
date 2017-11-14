F_t1 = [1, 3, 5, 7, 6, 2, 5, 9, 9, 9];
F_t2 = [1, 3, 6, 6, 6, 6, 7, 7, 7, 7];
F1 = 1:100;
F2 = 1:0.5:50.5;
F3 = 1:0.2:20.8;

Y = zeros(3, size(F_t1, 2));
leg_string = ['E1_T1'; 'E2_T1'; 'E3_T1'; 'E1_T2'; 'E2_T2'; 'E3_T2'];

for i = 1:size(F3, 2)
%     Y(1, i) = max(F3(1:i));
%     Y(2, i) = (1/i) * sum(F3(1:i));
    Y(1, i) = (1/i) * max(F1(1:i));
    Y(2, i) = (1/i) * max(F2(1:i));
    Y(3, i) = (1/i) * max(F3(1:i));
%     Y(4, i) = max(F_t2(1:i));
%     Y(5, i) = (1/i) * sum(F_t2(1:i));
%     Y(6, i) = (1/i) * max(F_t2(1:i));
end

size(F1)
size(F2)
size(F3)
plot(1:100, Y);   
% legend(leg_string);
set(findall(gca, 'Type', 'Line'),'LineWidth',4);