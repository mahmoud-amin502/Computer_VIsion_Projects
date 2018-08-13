function[gmag] = FindWeakEdges(gmag, row, col)
    for i = -2:1:2
        for j = -2:1:2
            if (row+i > 0)&&(col+j > 0)&&(row+i < size(gmag,1))&&(col+j < size(gmag,2)) % Make sure we are not out of bounds
                temp=gmag(row+i,col+j);
                if (gmag(row+i,col+j) > 0) && (gmag(row+i,col+j) < 1)
                    gmag(row+i,col+j) = 1;
                    gmag = FindWeakEdges(gmag, row+i, col+j);
                end
            end
        end
    end
end
