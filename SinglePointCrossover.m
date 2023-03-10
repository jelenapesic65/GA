function [y1, y2] = SinglePointCrossover(x1, x2)

    nVar = numel(x1(1,:));
    
    j = randi([1, nVar-1]);
    
    y1(1,:) = [x1(1,1:j) x2(1,j+1:end)];
    y2(1,:) = [x2(1,1:j) x1(1,j+1:end)];
    
    y1(2,:) = [x1(2,1:j) x2(2,j+1:end)];
    y2(2,:) = [x2(2,1:j) x1(2,j+1:end)];
    
    y1(3,:) = [x1(3,1:j) x2(3,j+1:end)];
    y2(3,:) = [x2(3,1:j) x1(3,j+1:end)];

end