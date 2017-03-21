function [patch] = findpatch(dem,x,y,angle,m_prime,n_prime)
% [patch] = dempatch(dem,x,y,angle,m_prime,n_prime)
% returns a rectangular patch of a surface
%
% the surface is represented by height values
% in an m by n matrix.
%
% the patch has its upper left corner at (x,y)
% (measured in matrix indices    1 1,2,..,n )
%                                2
%                                .   (x,y) <= patch starts here
%                                .
%                                m
%
% the upper side is of length n_prime,
% the left side is of length m_prime
% and the angle of the patch is the angle
% measured from the x-axis of the orginal data
% to the upper side of the patch.
%
% angle is in radians
%
% concentrate and draw a picture...
% peter dodds, nov 7, 1998

[m,n] = size(dem);

% patch in patch coords
xpos_patch = ones(m_prime+1,1)*(0:1:n_prime);
ypos_patch = (0:1:m_prime)'*ones(1,n_prime+1);

% patch in dem coords
xpos = x + cos(angle)*xpos_patch + sin(angle)*ypos_patch;
ypos = y - sin(angle)*xpos_patch + cos(angle)*ypos_patch;

% interpolate dem to xpos and ypos
patch = interp2(dem,xpos,ypos,'nearest');