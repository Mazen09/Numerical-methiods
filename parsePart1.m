function [methodNum,equation,additionalData,tolerance,maxi] = parsePart1(filename)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

methodNum = 0;
equation = "not found";
additionalData = inf;
tolerance = 0;
maxi = 0;

fid = fopen(filename);
if fid < 0
    error('can not open the file %s \n\n ',filename);
end

fgets(fid);
line = fgets(fid);
while(ischar(line))
    c = strsplit(line);
    lineNum = string(c(1));
    if(string(c(4)) == '|')
        temp = string(c(3));
    else
        
        temp = [string(c(3)),string(c(4))];
    end
    
    disp('line parsed');
    
    num = str2double(lineNum);
    if num == 1
        try
            methodNum = str2double(temp);
        catch
            error('method number is a single number');
        end
    elseif num == 2 
        try
            equation = temp;
        catch
            error('equation should not have spaces in between');
        end 
    elseif num == 3
        try
            if(length(temp) == 1)
                additionalData = str2double(temp);
            elseif(length(temp) == 2)
                temp(1) = regexprep(temp(1), '(\[|\])', '');
                temp(2) = regexprep(temp(2), '(\[|\])', '');
                additionalData = [str2double(temp(1)),str2double(temp(2))]; 
            else
                error('maximum number of cells are 2');
            end
        catch
            error('could not parse the additional data');
        end
    elseif num == 4 
        try
            tolerance = str2double(temp);
        catch
            error('tolerance number is a single number');
        end
    elseif num == 5
        try
            maxi = str2double(temp);
        catch
            error('maxi is a single number');
        end
    end
    line = fgets(fid);
end
fclose(fid);
end

