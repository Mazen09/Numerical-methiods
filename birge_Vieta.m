function [ error,root,fn,fx,iteration_no,iterations,excution_time,X,A,B,C,AbsErr,RelErr ] = birge_Vieta( p0,str,upper,tolerance )
%birge_Vieta finds a root for the given function.
%   Using Birge Vieta method this function will find a root for the given
%   function.
tic;
S = vectorize(char(str));
fn = str2func(['@(x) ' S]);
fntemp = fn;
error = 0;
syms x;
fx = diff(fn,x);
degree = 0;
notPoly = 0;
while vpa(fntemp) ~= 0
   fntemp = diff(fntemp,x);
   degree = degree+1;
   if degree == 100
      notPoly = 1;
      break;
   end    
end
if notPoly == 1
     X = inf(upper,1);
    A = inf(upper,1);
    B = inf(upper,4);
    C = inf(upper,4);
    AbsErr = inf(upper,1);
    RelErr = inf(upper,1);
    error = 1;
    root = inf;
    S = vectorize(char(str));
    fn = str2func(['@(x) ' S]);
    syms x;
    fx = diff(fn,x);
    iteration_no = inf;
    iterations = inf;
    excution_time = toc;
    return;
end    
P = inf(upper,1);
Ea = inf(upper,1);
Er = inf(upper,1);
b = inf(upper,degree);
c = inf(upper,degree-1);
P(1) = p0;
a = coeffs(fn,x,'All');
for j =1:upper
     b(j,1)=a(1);
     c(j,1)=a(1);
    for i = 1:(degree-1)
        b(j,i+1)=P(j)*b(j,i)+a(i+1);
    end 
    for i = 1:(degree-2)
        c(j,i+1)=P(j)*c(j,i)+b(j,i+1);
    end
    if c(j,degree-1) == 0
       error = 1;
       break;
    end
    P(j+1)=P(j)-(b(j,degree)/c(j,degree-1));
    if(j>1)
        if P(j+1) == 0
        error = 1;
        break;
        end 
        Ea(j+1) = abs((P(j+1)-P(j)));
        if P(j+1) == 0
           Er(j+1) = 1000000; 
        else    
        Er(j+1) = abs((P(j+1)-P(j))/P(j+1));
        end
        if Ea(j+1)<tolerance
          break; 
       end    
    end
end
iteration_no =j;
iterations = 1:j;
if Ea(j)>Ea(1)
    error = 1;
end    
X = P;
A = a;
B = b;
C = c;
RelErr = Er;
AbsErr = Ea;
root = P(j);
excution_time = toc;
end

