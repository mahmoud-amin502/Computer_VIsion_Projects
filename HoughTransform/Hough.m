function [ output_args ] = Untitled4( input_args )

%%%%%%%%%%%%%%%%%%%%%% Hough %%%%%%%%%%%%%%%%%%%

img=imread('gantrycrane.png');  % hough transform of an image
img=rgb2gray(img);
img=edge(img,'canny');
[h,theta,rho]=hough(img);
figure(1);
subplot(2,1,1);
imshow(img);
subplot(2,1,2);
imshow(imadjust(mat2gray(h)));
axis on, axis normal;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%% Hough Peaks %%%%%%%%%%%%%%%

img2=imread('gantrycrane.png');   % gets the peaks from a hough matrix 
img2=rgb2gray(img2);
img2=edge(img2,'canny');
[h1,theta1,rho1]=hough(img2);
figure(2);
subplot(2,1,1);
imshow(img2);

j=houghpeaks(h1,2);
subplot(2,1,2);
imshow(mat2gray(h1));
axis on, axis normal;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%% Hough Lines %%%%%%%%%%%%%%
img3=imread('gantrycrane.png');   % gets the line from an image using the hough transform matrix and the hough peaks in a struck  
img3=rgb2gray(img3);
img3=edge(img3,'canny');
[h2,theta2,rho2]=hough(img3);

j1=houghpeaks(h2,5);
subplot(2,1,2);
imshow(mat2gray(h2));
axis on, axis normal;

lines=houghlines(img3,theta2,rho2,j1);
figure(4), imshow(img3), hold on
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','red');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','green');

end

end

