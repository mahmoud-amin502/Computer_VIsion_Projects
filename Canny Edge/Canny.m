function [ output_args ] = Untitled( input_args )
lowThresholdRatio = 0.15;
highThresholdRatio = 0.2;
img=imread('lena.jpg');
img=rgb2gray(img);
img=imgaussfilt(img,1.4);
img=double(img);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [gx gy]=imgradientxy(img);
% [gmag,gdir] = imgradient(img);
% gdir=atan(gy./gx);
% gdir=rad2deg(gdir);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Gx = [-1 0 +1; -2 0 +2; -1 0 +1];
gx = imfilter(img, double(Gx), 'conv', 'replicate');
Gy = [-1 -2 -1; 0 0 0; +1 +2 +1];
gy = imfilter(img, double(Gy), 'conv', 'replicate');

gx = imgaussfilt(gx,1.4);
gy = imgaussfilt(gy,1.4);
% figure,imshow(uint8(gx));
% figure,imshow(uint8(gy));
gmag = sqrt(gx.^2 + gy.^2);
gdir = atan2(gy,gx)*180/pi;
% figure,imshow(uint8(gmag));
% figure,imshow(uint8(gdir));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[h,w] = size(img);
output = zeros(h,w);
for i=2:h-1
    for j=2:w-1
        % i --> y axis & j --> x axis
        if ((gdir(i,j)>=-22.5 && gdir(i,j)<=22.5)||(gdir(i,j)<-157.5 && gdir(i,j)>=-180))
            if ((gmag(i,j) >= gmag(i,j+1))&&(gmag(i,j) >= gmag(i,j-1)))
                output(i,j)= gmag(i,j);
            else
                output(i,j)=0;
            end
        elseif ((gdir(i,j)>=22.5 && gdir(i,j)<=67.5)||(gdir(i,j)<-112.5 && gdir(i,j)>=-157.5))
            if ((gmag(i,j) >= gmag(i+1,j+1))&&(gmag(i,j) >= gmag(i-1,j-1)))
                output(i,j)= gmag(i,j);
            else
                output(i,j)=0;
            end
        elseif ((gdir(i,j)>=67.5 && gdir(i,j)<=112.5)||(gdir(i,j)<-67.5 && gdir(i,j)>=-112.5))
            
            if ((gmag(i,j) >= gmag(i+1,j))&&(gmag(i,j) >= gmag(i-1,j)))
                
                output(i,j)= gmag(i,j);
            else
                output(i,j)=0;
            end
        elseif ((gdir(i,j)>=112.5 && gdir(i,j)<=157.5)||(gdir(i,j)<-22.5 && gdir(i,j)>=-67.5))
            if ((gmag(i,j) >= gmag(i+1,j-1))&&(gmag(i,j) >= gmag(i-1,j+1)))
                %el zawya mn 157.5 l7ad 180 3ayza condition
                output(i,j)= gmag(i,j);
            else
                output(i,j)=0;
            end
        elseif((gdir(i,j)>=157.5 && gdir(i,j)<=180))
            if((gmag(i,j) >= gmag(i,j+1))&&(gmag(i,j) >= gmag(i,j-1)))
                output(i,j)= gmag(i,j);
            else
                output(i,j)=0;
            end
        end
    end
end
% figure,imshow(output);
gmag=Normalization(output);
% figure,imshow(gmag);
high_thre  =0.2; %max(max(gmag))*highThresholdRatio;
min_thre   =0.01; %high_thre*lowThresholdRatio;

strongEdgesRow = zeros(1,h);     % strong edge row index
strongEdgesCol = zeros(1,w);    % strong edge col index
weakEdgesRow = zeros(1,h);      % weak edge row index
weakEdgesCol = zeros(1,w);      % weak edge col index

 strongIndex = 1;
 weakIndex = 1;

for i=2:h-1 % row
    for j=2:w-1 % col
        if gmag(i,j) > high_thre
            gmag(i,j) = 1;
            strongEdgesRow(strongIndex) = i;
            strongEdgesCol(strongIndex) = j;
            strongIndex = strongIndex + 1;
            
        elseif gmag(i,j) < min_thre
            gmag(i,j) = 0;
        else
            weakEdgesRow(weakIndex) = i;
            weakEdgesCol(weakIndex) = j;
            weakIndex = weakIndex + 1;
        end
    end
end

% figure,imshow(gmag);

for i=1:strongIndex-1
    gmag = FindWeakEdges(gmag, strongEdgesRow(i),strongEdgesCol(i));
end
% figure,imshow(gmag);

for i=1:weakIndex-1
    if gmag(weakEdgesRow(i),weakEdgesCol(i)) ~= 1
        gmag(weakEdgesRow(i),weakEdgesCol(i)) = 0;
    end
end
% figure,imshow(gmag);

new=edge(img,'canny',[0.01 0.1],1);
final=gmag;
subplot(1,2,1);
imshow(final);
subplot(1,2,2);
imshow(new);
end

