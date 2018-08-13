function [ result ] = test()
clc
allfv=[];
track=0;
sector=0;
load('allfv.mat','allfv');
path = 'C:\Users\MRM\Documents\MATLAB\ComputerVision\HOG\Test\1_7.png';
img=imread(path);
f_v = Main(img);
f_t = train;
dist=[];
min_dist=15;
result=1;
for i=1:40
    temp1=f_t(:,i);
    temp2=f_v;
    dist = temp1 - temp2;
    dist = power(dist,2);
    dist = sum(dist);
    dist = sqrt(dist);
    if(dist<min_dist)
        min_dist = dist;
        result=0;
    end
end
% min_dist
% position
% strcat('this number dont matched with any number',32,floor((position-1)/10)+48)
end

