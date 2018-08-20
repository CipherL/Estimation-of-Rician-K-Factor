function [Image] = format_data(Data_8)
%UNTITLED4 此处显示有关此函数的摘要
%   此处显示详细说明
Maxin = zeros(3,8);

for i = 1:8 
    count = Data_8(:,i)~=0;
    Maxin(3,i) = sum(count); 
    Maxin(1,i) = max(Data_8(1:Maxin(3,i),i));
    Maxin(2,i) = min(Data_8(1:Maxin(3,i),i));
end

for j = 1:4
   
    for k = 1:Maxin(3,2*j)
        Data_8(k,2*j-1) = round(27*(Data_8(k,2*j-1)-Maxin(2,2*j-1))/(Maxin(1,2*j-1)-Maxin(2,2*j-1)))+1;
        Data_8(k,2*j) = round(27*(Data_8(k,2*j)-Maxin(2,2*j))/(Maxin(1,2*j)-Maxin(2,2*j)))+1;
    end       

end
Image = zeros(28,28,4);
for m = 1:4
    for n = 1:Maxin(3,2*m)
        p = Data_8(n,2*m-1);
        q = Data_8(n,2*m);
        Image(p,q,m) = Image(p,q,m)+1;
    end
end
end

