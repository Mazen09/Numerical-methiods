function [roots, fn,excution_time] = general( func )
%general get all the roots of an equation in average cases.
%   get all roots of a function usuing newton-raphson modified method
% NOTE : the function is one variable function with name 'x'
tic;
fn = sym(str2func(['@(x) ' vectorize(char(func))]));
tolerance = .0001;
syms x;
roots = inf;
maxIter = 100;
f = taylor(fn, x,'Order', 200);
conv = false;
u = sym2poly(f);
numOfRoots = length(u)-1;
succeed = false;
delta = 0;

% this loops until all roots are found or max num of iterations reached
while(numOfRoots ~= 0 && maxIter ~= 0 )
    df = diff(f) ;
    ddf = diff(df);
    while(conv == false)
        x0 = rand * delta;
        [root,conv] = newton_gen(f,df,ddf,x0,100,0.0001);
        if(conv == false)
            [root,conv] = newton_gen(f,df,-x0,100,0.0001);
        end
        % this was by trial (no scientific reason for this assumption)
        if(delta == 10)
            delta = 0;
            break;
        end
        delta = delta + 1;
    end
    conv = false;
    root = double(root);

    
    %add it to the list of roots
    
    % check if the root is less than the tolerance
    if (abs(double(subs(f,root))) <= tolerance)        
        numOfRoots = numOfRoots-1;
        if ~(length(roots) == 1 && roots(1) == inf)
            if(~ismember(root,roots))
                roots = [roots root]; 
            end
        else
            roots = root;
        end

         %divide the equation over the root
        u = sym2poly(f);
        v = [1 -root];
        [q,~] = deconv(u,v);
        f = poly2sym(q);
        
    end
    excution_time = toc;
    maxIter = maxIter - 1;
    disp('roots');
    disp(roots);
    disp('-------------------------------------------');
end



    
