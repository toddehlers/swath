function [maxvalue,minvalue,meanvalue,stdvalue,cumdist] = avg(patch,pixel_size,dim_flag)
% avg.m is a simple routine to sum cloumns of data and extract the mean
% maximum, and mean values and the standard eviation in each column.  
% For use with swath.m.
%
% find the patch dimensions
    [r,c] = size(patch);
%
% determine the direction of matrix statistics
    if dim_flag == 'lr' %#ok<*STCMP>
        dim = r;
        dir = 2;
    end
    %
    if dim_flag == 'ud'
        dim = c;
        dir = 1;
    end
%
% calculate the swath length
    dist = pixel_size*ones(1,dim);
    dist(1)=0;
    cumdist = cumsum(dist);
%
% calculate statistics
    meanvalue = nanmean(patch,dir);
    stdvalue = nanstd(patch,0,dir);
    maxvalue = max(patch,[],dir);
    minvalue = min(patch,[],dir);
%