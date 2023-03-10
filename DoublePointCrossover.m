function [y1, y2] = DoublePointCrossover(x1, x2)

    nVar = numel(x1(1,:));
    
    q = randperm(nVar);
    j1 = min(q(1), q(2));
    j2 = max(q(1), q(2));
    
    y1(1,:) = [x1(1,1:j1) x2(1,j1+1:j2) x1(1,j2+1:end)];
    y2(1,:) = [x2(1,1:j1) x1(1,j1+1:j2) x2(1,j2+1:end)];
    
    y1(2,:) = [x1(2,1:j1) x2(2,j1+1:j2) x1(2,j2+1:end)];
    y2(2,:) = [x2(2,1:j1) x1(2,j1+1:j2) x2(2,j2+1:end)];
    
    y1(3,:) = [x1(3,1:j1) x2(3,j1+1:j2) x1(3,j2+1:end)];
    y2(3,:) = [x2(3,1:j1) x1(3,j1+1:j2) x2(3,j2+1:end)];

end