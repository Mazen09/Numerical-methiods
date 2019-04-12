function [XL,XU,XR,RelativeError,f, excution_time, error, absoluteError] = bisection(fx,xl,xu,es,imax)
  tic;   
    f = str2func(['@(x)' vectorize(char(fx))]);
        error="";
    if(f(xu)*f(xl)) > 0 
        error = ('bisection method : no roots in interval');
    end
    for i = 1:1:imax
        XU (i) = xu;
        XL (i) = xl;
        xr = (xl + xu)/2;
        XR (i) = xr;
        %ea = abs((xu-xl)/xl);  
        test = f(xr)*f(xl);
        if (test < 0)
            xu=xr;
        else
            xl=xr;
        end
        if(i == 1) 
            RelativeError(i) = 1000000000;
                absoluteError(1) = 10000000;
        else 
            RelativeError(i) = abs((XR(i)-XR(i-1))/XR(i)); 
                    absoluteError(i) = abs((XR(i)-XR(i-1))); 

        end
        if (test == 0)
            RelativeError(i)=0;
            absoluteError(i)=0;

        end
        if (absoluteError (i) < es)
            break;
        end
    end
    
    if(absoluteError(length(RelativeError)) > es)
        error = ('method can not find the root for specified number of iterabtions ');
    end
    %s=sprintf('\n Root= %f #Iterations = %d \n', xr,i);
    %disp(s);
    excution_time = toc;
end

