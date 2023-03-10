function y = Mutate(x, mu)

    flag = (rand(size(x(1,:))) < mu);
    

    y = x;
    y(1,flag) = 1 - x(1,flag);
    y(2,flag) = 1 - x(2,flag);
    y(3,flag) = 1 - x(3,flag);
    
end