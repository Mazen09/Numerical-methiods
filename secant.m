function [ Fxi,root,error,fn,fx,iteration_no,excution_time,iteration,Xi,XiPlusOne,XiMinusOne,AbsErr,RelErr ] = secant( xold0,xold1,str,upper,tolerance )
%secant finds root of given function.
%   Secant method finds the root of the given function using the secant
%   method.
tic;
error = 0;
Xiold0 = inf(upper,1);
Xiold1 = inf(upper,1);
Xinew = inf(upper,1);
Ea = inf(upper,1);
Er = inf(upper,1);
Fxi = inf(upper,1);
for i = 1:upper
   syms x;
   S = vectorize(char(str));
   fn = str2func(['@(x) ' S]);
   fx = diff(fn,x);
   %x=xold0;
   fnold0=subs(fn,x,xold0);
   %x=xold1;
   try
   fnold1=subs(fn,x,xold1);
   catch
      error = 1;
      break;       
   end
   Fxi(i) = fnold1;
   if (fnold1-fnold0) == 0 || (i == 10 && Ea(1) < Ea(i))
      error = 1;
      break;
   end     
   xnew=xold1-(fnold1*(xold1-xold0)/(fnold1-fnold0));
   Xiold0(i) = xold0;
   Xiold1(i) = xold1;
   Xinew(i) = vpa(xnew);
   if (xnew == 0)
      Er(i) = 10000000;
   else
       Er(i) = abs((vpa(xnew)-xold1)/vpa(xnew));
   end
   Ea(i) = abs((vpa(xnew)-xold1));
   xold0=xold1;
   xold1=vpa(xnew);
end    
iteration_no = i;
iteration = 1:i;
Xi = Xiold1;
XiPlusOne = Xinew;
XiMinusOne = Xiold0;
AbsErr = Ea;
RelErr = Er;
root = XiPlusOne(i);
excution_time = toc;
end

