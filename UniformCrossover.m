function [y1, y2] = UniformCrossover(x1, x2)

    alpha = randi([0, 1], size(x1(1,:)));
    
    y1(1,:) = alpha.*x1(1,:) + (1-alpha).*x2(1,:);
    y2(1,:) = alpha.*x2(1,:) + (1-alpha).*x1(1,:);
    
    y1(2,:) = alpha.*x1(2,:) + (1-alpha).*x2(2,:);
    y2(2,:) = alpha.*x2(2,:) + (1-alpha).*x1(2,:);
    
    y1(3,:) = alpha.*x1(3,:) + (1-alpha).*x2(3,:);
    y2(3,:) = alpha.*x2(3,:) + (1-alpha).*x1(3,:);
    
  

end