clear;

root_dir = 'C:\Users\dell\Desktop\新建文件夹\datapro1';

med = load('newdata.mat');
% if ~exist(fullfile(root_dir,'logdata'), 'dir')
%     mkdir(fullfile(root_dir,'logdata'));
% end
data = med.newdata;
Data_complex = data(:,1)+1j*data(:,2);
Std_data = std(abs(Data_complex));
Mean_data = mean(abs(Data_complex));
Max_data = max(abs(Data_complex));
Min_data = min(abs(Data_complex));
RESIZE = 1;

 slice = 600;
for i = 1:floor(length(data(:,1))/slice)
    Data_I = data(slice*(i-1)+1:slice*i,1);
    Data_Q = data(slice*(i-1)+1:slice*i,2);
    Data_IQ(:,1) = Data_I;
    Data_IQ(:,2) = Data_Q;
   
    sample = Data_I + 1j*Data_Q;
    sample_scale = sample.*(Max_data-Min_data)./Min_data;
        
        %------log data------
        for j = 1:slice
            if real(sample_scale(j))< 0
                Data_log_I(j) = -log10(-real(sample_scale(j)));
            else
                Data_log_I(j) = log10(real(sample_scale(j)));
            end
            if imag(sample_scale(j)) <0
                Data_log_Q(j) = -log10(-imag(sample_scale(j)));
            else
                Data_log_Q(j) = log10(imag(sample_scale(j)));
            end
        end
        
        % ------cluster to four classes------
   Data_8 = cluster_4(Data_log_I,Data_log_Q,slice);
%    data_mat = fullfile(root_dir, 'logdata', [sprintf('%05d', i), '.mat']);
%    save(data_mat, 'Data_8');
   
        %------image a 28*28*4 array-------
    Image=format_data(Data_8);
        
end
    

                
%  Image=Image4D(Data_8);
% 
%   u = Image(:,:,1);
%   v = Image(:,:,2);
%   x = Image(:,:,3);
%   y = Image(:,:,4);
%   figure
%   mesh(u);
%   figure(2)
%   mesh(v);
%   figure(3)
%   mesh(x);
%   figure(4)
%   mesh(y);
