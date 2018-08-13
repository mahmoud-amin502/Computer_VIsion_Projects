function panor()
buildingDir = fullfile(toolboxdir('vision'), 'visiondata', 'building');
buildingScene = imageSet(buildingDir);
I = read(buildingScene, 1);
grayImage = rgb2gray(I);
figure;
imshow(grayImage)


points = detectSURFFeatures(grayImage);
[features, points] = extractFeatures(grayImage, points);
I2 = read(buildingScene, 2);
grayImage2 = rgb2gray(I2);
grayImage2=imrotate(grayImage2,-30);

figure;
imshow(grayImage2)

points2 = detectSURFFeatures(grayImage2);
[features2, points2] = extractFeatures(grayImage2, points2);

index_pairs = matchFeatures(features,features2);
matchedPtsOriginal  = points(index_pairs(:,1));
matchedPtsDistorted = points2(index_pairs(:,2));
figure;
ax = axes;

showMatchedFeatures(grayImage,grayImage2,matchedPtsOriginal(1:22,:),matchedPtsDistorted(1:22,:),'montage','Parent',ax);
tform =estimateGeometricTransform(matchedPtsDistorted,matchedPtsOriginal,'projective');
outputView = imref2d(size(grayImage2));
Ir = imwarp(grayImage2,tform,'OutputView',outputView);
figure; imshow(Ir);
blender = vision.AlphaBlender('Operation', 'Binary mask','MaskSource', 'Input port');
[x1,y1] = size(grayImage);

mask = ones(size(Ir));
mask(:,1:end/2) = 0;

panorama = step(blender,grayImage,Ir,mask);  %%%%%%%%%
figure
imshow(panorama)
end









% panorama = zeros([x1+x1 y1+y1], 'like', grayImage);
%  panorama = step(blender, panorama,grayImage);


% grayImage=ind2rgb(grayImage, colormap);
% Ir=ind2rgb(Ir, colormap);
