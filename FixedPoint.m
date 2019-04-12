function [f, g, xNew, relativeError, excution_time,Gx, absoluteError] = Untitled(equation ,maxIteration, tolerance, initialPoint )
tic;
S = vectorize(char(equation)); %str = x^2-6*x
f = str2func(['@(x) ' S]);
syms x
g(x) = f+x;
xOld = initialPoint;
try
    xNew(1) = vpa(g(xOld));
catch
    return;
end
    relativeError(1) = abs((xNew(1) - xOld))/xNew(1);
    absoluteError(1) = abs(f(xNew(1)) - 0);

iter = 1;
iter_max = maxIteration;
index = 2;
while absoluteError(index - 1) > tolerance && iter < iter_max
    xOld = xNew(index - 1);
    
    try
        xNew(index) = vpa(g(xOld));
    catch
        return;
    end
    
        relativeError(index) = abs((xNew(index) - xOld))/xNew(index);
    absoluteError(index) = abs((xNew(index) - xOld));
    if abs(xNew(index)) < 10^-200 | abs(xNew(index)) > 10^200
        break;
    end
    
    
    iter = iter + 1;
    index = index + 1;
end
    excution_time = toc;
for i = 1:length(xNew)
    Gx(i) = vpa(g(xNew(i)));
end
end





