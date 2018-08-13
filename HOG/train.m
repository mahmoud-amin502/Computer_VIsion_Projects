function [ allfv ] = Untitled3( input_args )
allfv=[];
label=[];
hh=8;
nn=5;

for i=1 :hh
    for j=1:nn
        f=[num2str(i-1),'_',num2str(j),'.png'];
        filename = strcat('C:\Users\MRM\Documents\MATLAB\ComputerVision\HOG\TestingData\',f);
        I = imread(filename);
        [fv]=Main(I);
        allfv=[allfv fv];
        label=[label;i-1];
    end   
end



save('allfv.mat','allfv');
end
%allfv
%label
