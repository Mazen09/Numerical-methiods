function [ interpolationMethod,numOfPts,samplePts,corrValues,queryPts] = parsePart2( filename )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
interpolationMethod = 0;
numOfPts = 0;
samplePts = 0;
corrValues = 0;
queryPts = 0;

fid = fopen(filename);
if fid < 0
    error('can not open the file %s \n\n ',filename);
end
fgets(fid);
line = fgets(fid);
while(ischar(line))
    c = strsplit(line);
    num = str2double(string(c(1)));
    temp = string(c(3));
    
    if(num == 1)
         try
             n = str2double(temp);
             if n == 1 || n == 2
                interpolationMethod = str2double(temp);
             else
                 error('method number is 1 or 2');
             end
         catch
             error('error parsing method number');
         end
    elseif(num == 2)
        try
             n = str2double(temp);
             if n > 0
                numOfPts = str2double(temp);
             else
                 error('number of points should be positive');
             end
         catch
             error('error parsing number of points');
         end
    elseif(num == 3)
        try
             temp = regexprep(temp, '(\[|\])', '');
             m = strsplit(temp,',');
             for i =1 : length(m)
                t = str2double(string(m(i))) ;
                if(i == 1)
                    samplePts = t;
                else
                    samplePts = [samplePts,t];
                end
             end
         catch
             error('error parsing sample points');
         end
    elseif(num == 4)
        try
             temp = regexprep(temp, '(\[|\])', '');
             m = strsplit(temp,',');
             for i =1 : length(m)
                t = str2double(string(m(i))) ;
                if(i == 1)
                    corrValues = t;
                else
                    corrValues = [corrValues,t];
                end
             end
             if(length(samplePts) ~= length(corrValues))
                 error('sample points and their corresponding values should be equal');
             end
         catch
             error('error parsing corresponding values');
         end
    elseif(num == 5)
        try
             temp = regexprep(temp, '(\[|\])', '');
             m = strsplit(temp,',');
             for i =1 : length(m)
                t = str2double(string(m(i))) ;
                if(i == 1)
                    queryPts = t;
                else
                    queryPts = [queryPts,t];
                end
             end
         catch
             error('error parsing query points');
         end
    else
        error('number of inputs should not exceeds 5');
    end
    line = fgets(fid);
end
fclose(fid);
end

