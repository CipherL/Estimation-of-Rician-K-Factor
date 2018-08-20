function [ImagD] = cluster_4(data_I,data_Q,slice)
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明
  %ImagD = zeros(200,8);
  
    k = 0;
    l = 0;
    m = 0;
    n = 0;
    for p = 1:slice
        if (data_I(p)>0) && (data_Q(p)>0)
            k = k+1;
            ImagD(k,1) = data_I(p);
            ImagD(k,2) = data_Q(p);
        elseif (data_I(p)<0) && (data_Q(p)>0)
            l = l+1;
            ImagD(l,3) = data_I(p);
            ImagD(l,4) = data_Q(p);
        elseif (data_I(p)<0) && (data_Q(p)<0)
            m = m+1;
            ImagD(m,5) = data_I(p);
            ImagD(m,6) = data_Q(p);
        else
            n = n+1;
            ImagD(n,7) = data_I(p);
            ImagD(n,8) = data_Q(p);
        end
    end

end

