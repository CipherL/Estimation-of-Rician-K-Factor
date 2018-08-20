clear;

Med = load('direct01_16-09-07_0724_001.mat');
Data = Med.x;
% stastic the number of raw data
c = 0;
j = 0;
slice = 600;
temp = Data(1,4);
midata = zeros(slice,4);
newdata = zeros(2056800,4);
count = zeros(3428,1);

for i=1:length(Data(:,1))
    if temp==Data(i,4)
        c=c+1;
        if c<601
            midata(c,1) = Data(i,2);
            midata(c,2) = Data(i,3);
            midata(c,3) = sqrt(power(midata(c,1),2)+power(midata(c,2),2));
            midata(c,4) = Data(i,4);
        end
    else
        j = j+1;
        count(j) = c;
       
  % reshape the same length newdata
      
        for m = 1:slice
            newdata(slice*(j-1)+m,1)=midata(m,1);
            newdata(slice*(j-1)+m,2)=midata(m,2);
            newdata(slice*(j-1)+m,3)=midata(m,3);
            newdata(slice*(j-1)+m,4)=midata(m,4);
        end
        c=0;
        temp=Data(i,4);
     end
        
    
    
end

% calculate the MLE of each package
result = zeros(length(count),3);
for n=1:length(count)
    phat = mle(newdata(slice*(n-1)+1:slice*n,3), 'distribution','Rician');
    result(n,1)=phat(1);
    result(n,2)=phat(2);
    result(n,3)=(phat(1)^2)/(2*(phat(2)^2));
end
