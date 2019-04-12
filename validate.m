function [ valid ] = validate( func )
%validate the syntax of one variable function
%   used variable must be symbol (x)
try
    str2func(['@(x) ' vectorize(char(func))]);
    valid = true;
catch
    valid = false;
end

end

