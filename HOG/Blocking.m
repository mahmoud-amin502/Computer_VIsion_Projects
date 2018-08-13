function [ Blocks ] = Untitled(mat)
[m, n]=size(mat);
overlap=8;
block_size=16;
step=block_size-overlap;
if mod((m-overlap),block_size)~=0
    mat(:,end+1)=0;
    stop=(m-overlap)-1;
end

if mod((n-overlap),block_size)~=0
    mat(end+1,:)=0;
    stop=(m-overlap)-1;
end

Blocks=cell(2,2);

counti = 0;
for i = 1:step:stop
    counti = counti + 1;
    countj = 0;
    for j = 1:step:stop
        countj = countj + 1;
        Blocks{counti,countj} = mat(i:(i+block_size-1),j:(j+block_size-1));
    end
end






end

