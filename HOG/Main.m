function [ final ] = Untitled(img)

% img=imread('1_10.png');
[m n]=size(img);
img=imresize(img,[128 128]);
% imshow(img);
img=double(img);
img=imgaussfilt(img,2);


Gx = [-1 0 +1; -2 0 +2; -1 0 +1];
Ix = imfilter(img, double(Gx), 'conv', 'replicate');
Gy = [-1 -2 -1; 0 0 0; +1 +2 +1];
Iy = imfilter(img, double(Gy), 'conv', 'replicate');
% figure,imshow(Ix);
% figure,imshow(Iy);


gmag = sqrt(Ix.^2 + Iy.^2);
gdir = atan2(Iy,Ix)*180/pi;
gdir=abs(gdir);
% figure,imshow(uint8(gmag));

Blocks=Blocking(gdir);
Blocks_mag=Blocking(gmag);
Blocks1=cell(2,2);
Blocks2=cell(2,2);
sz=size(Blocks);
sz1=size(Blocks_mag);
for i=1:sz(1)
    for j=1:sz(2)
        Blocks1{i,j}=mat2cell(Blocks{i,j},[8,8],[8,8]);
    end
end
%%%%%%%%%%%%%%%%%%% for magnitude %%%%%%%%%%%%%%%%
for i=1:sz1(1)
    for j=1:sz1(2)
        Blocks2{i,j}=mat2cell(Blocks_mag{i,j},[8,8],[8,8]);
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
final=zeros(1,1);
fe=Histogram(Blocks1,Blocks2);
sz2=size(Blocks1);
for i=1:sz2(1)
    for j=1:sz2(2)
        f2=cell2mat(fe{i,j});
        f2=f2(:);
        f2=flipud(f2);
        final=[f2;final];
    end
end
final=flipud(final);
final=final(2:end,:);

end




%if temp1>=0 && temp1<10
%bin(1,1)=bin(1,1)+temp2;
