function [ result,excution_time,fn, answers ] = newton_interpolation( points , correspondingPoints, queries)
tic;
pointsSize = length(points);
result = zeros(pointsSize, pointsSize+1);
for i = 1:pointsSize
    result(i,1) = points(i);
    result(i,2) = correspondingPoints(i);
end
for j = 3:pointsSize(1)+1
    for i = j-1:pointsSize(1)
        result(i,j) = (result(i,j-1)-result(i-1,j-1))/(result(i,1)-result(i-j+2,1));
    end
end

syms x;
fn = result(1,2);
for i = 2:pointsSize
    fnLoop = 1;
    k = 1;
   for j = i-1:-1:1
      fnLoop = fnLoop * (x - result(k,1));
      k = k + 1;
   end
   fnLoop = fnLoop * result(i,i+1);
   fn = fn + fnLoop;
end
fn = simplify(fn);
excution_time = toc;

for i=1:length(queries)
answers(i) = vpa(subs(fn,x,queries(i)));
end


end

