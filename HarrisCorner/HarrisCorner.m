function [ output_args ] = Untitled( input_args )

img=imread('c1.jpg');
img1=imread('c2.jpg');
% img=rgb2gray(img);
Threshold=50000;
k=0.06;
sigma=1;
c=3;
[m,n]=size(img);
[m1,n1]=size(img1);

img=imgaussfilt(img);
img1=imgaussfilt(img1);

[xx,yy] = meshgrid(-c:c, -c:c);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% img=double(img);
% g1=fspecial('gaussian',[30 30],1);
% img=conv2(img,g1,'same');
% [Gx,Gy]=gradient(img);
% figure,imshow(uint8(img));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Gxy = exp(-(xx .^ 2 + yy .^ 2) / (2 * sigma ^ 2));
Gx = xx .* exp(-(xx .^ 2 + yy .^ 2) / (2 * sigma ^ 2));
Gy = yy .* exp(-(xx .^ 2 + yy .^ 2) / (2 * sigma ^ 2));

Ix = conv2(Gx, img);
Iy = conv2(Gy, img);

Ix1 = conv2(Gx, img1);
Iy1 = conv2(Gy, img1);
% figure,imshow(uint8(Ix));
% figure,imshow(Iy);
Ix2 = Ix .^ 2;
Iy2 = Iy .^ 2;
Ixy = Ix .* Iy;


Ix21 = Ix1 .^ 2;
Iy21 = Iy1 .^ 2;
Ixy1 = Ix1 .* Iy1;
% figure,imshow(uint8(Ix2));
% figure,imshow(uint8(Iy2));

Sx2 = conv2(Gxy, Ix2);
Sy2 = conv2(Gxy, Iy2);
Sxy = conv2(Gxy, Ixy);


Sx21= conv2(Gxy, Ix21);
Sy21= conv2(Gxy, Iy21);
Sxy1= conv2(Gxy, Ixy1);
% figure,imshow(Sx2);
% figure,imshow(Sy2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Image 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

im=zeros(m,n);
temp=zeros(m,n);
for x=1:m
   for y=1:n
       H = [Sx2(x,y)  Sxy(x, y); Sxy(x, y) Sy2(x, y)];
       
       R = det(H) - k * (trace(H) ^ 2);
       temp(x,y)=R;
       if (R > Threshold)
          im(x, y) = R; 
       end
   end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
im = im > imdilate(im, [1 0 1; 1 0 1; 1 0 1]);


%%%%%%%%%%%%%%%%%%%%%%%%%%%% Rotated Image %%%%%%%%%%%%%%%%%%%%%%%%%

% figure,imshow(temp);
% figure,imshow(im);


im1=zeros(m1,n1);
temp1=zeros(m1,n1);
for x=1:m1
   for y=1:n1
       H1 = [Sx21(x,y)  Sxy1(x, y); Sxy1(x, y) Sy21(x, y)];
       
       R1 = det(H1) - k * (trace(H1) ^ 2);
       temp1(x,y)=R1;
       if (R1 > Threshold)
          im1(x, y) = R1; 
       end
   end
end

im1 = im1 > imdilate(im1, [1 0 1; 1 0 1; 1 0 1]);


% figure,imshow(temp1);
% figure,imshow(im1);

figure(1);
subplot(1,3,1);
imshow(img),
subplot(1,3,2);
imshow(temp),
subplot(1,3,3);
imshow(im),


figure(2);
subplot(1,3,1);
imshow(img1),
subplot(1,3,2);
imshow(temp1),
subplot(1,3,3);
imshow(im1),




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





end