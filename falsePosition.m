function [l,u,r,relativeError, f,excution_time, error, absoluteError] = falsePosition(func,xl,xu,es,imax)
%using known false position method to find a root inside some interval
tic;
    f = str2func(['@(x)' vectorize(char(func))]);

     error=""; 
    if(f(xu)*f(xl))> 0.0
        error = 'false-point method : no roots in iterval';
        
    end
    absoluteError(1) = 1000000000000;
        relativeError(1) = 1000000000000;

    for i = 1:1:imax
        l(i)= xl;
        u(i) = xu;
        r(i) = ((l(i)*f(u(i)))-(u(i)*f(l(i))))/(f(u(i))-f(l(i)));
        if f(r(i)) == 0.0 
            disp('root found');
            break;
        elseif f(r(i)) * f(l(i))  < 0 
            xu = r(i); 
        else 
            xl = r(i);
        end
        if(i > 1)
        relativeError(i) = abs(((r(i) - r(i-1))/(r(i))));
        absoluteError(i) = abs(((r(i) - r(i-1))));
        end
        if ((i > 1) && (absoluteError(i)< es) )
            disp('method has converged');break;
        end
    end
    
    if(absoluteError(i) > es)
        error = ('zero not found for desired tolerance and number of iterations');
    end

    
    
    excution_time = toc;

end

