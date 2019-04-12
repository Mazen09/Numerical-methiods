function [ root,conv,ea] = newton_gen( fn,dfn,ddfn,x0,imax,tolerance )
%newton_gen find a root of a function using newton method
%   find a root of a fiunction using newton-raphson modified method

xi = x0;
root = 0;
conv = false;
ea = 1;
xnew = inf ;
for i = 1 : imax
    f = double(subs(fn,xi));
    df = double(subs(dfn,xi));
    d2f = double(subs(ddfn,xi));

    % check if the denomenator is invalid xi
    if ((df*df)-(f*d2f) ~= 0  && ~isnan(xi)) 
        xnew = double(xi - ((f*df)/((df*df)-(f*d2f))));
        if(xnew ~= 0)
            ea = (xnew-xi)/xnew;
        else
            if(subs(fn,xnew) == 0)
            root = xi;
            conv = true;
            end
            break;
        end
        
    else
        if(abs(subs(fn,xi)) <= tolerance)
            root = xi;
            conv = true;
        end
        break;
    end


    if double(abs(ea)) <= tolerance
          root = xnew;
          conv = true;
       break;
      end 
   xi=xnew;
end


if (i > imax)
    conv = false;
end

    



