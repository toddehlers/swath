function[patch,cumdist] = swath(dem,pixel_size,dim_flag)
% swath.m is the shell code for averaging values of a surface along a swath of
% specified length and width.  Program requires functions findpatch.m and
% avg.m.
% Function requires an input grid of values that encloses desired swath
% Eric Kirby
% 11/9/98
%
% Input:
% dem - the original dem, must be already loaded into matlab
% pixel_size - resolution, pixel per meter
% dim_flag - left/right: 'lr' or up/down: 'ud'
%
% plot the DEM as figure 1
    figure (1)
    hold on
    imagesc(dem)
    axis image
    colormap jet
%
% prompt user for swath position
    disp ('Select the upper left corner of the swath: ')
    [x1,y1] = ginput(1);
    x1 = round(x1);
    y1 = round(y1);
    %
    disp ('Select the upper right corner of the swath: ')
    [x2,y2] = ginput(1);
    x2 = round(x2);
    y2 = round(y2);
%
% blah
    cell_length = round(sqrt(((x2-x1)^2)+((y2-y1)^2)));
    n_prime = cell_length;
%
% calculate angle
    angle = -1*(atan((y2-y1)/(x2-x1)));
%
% prompt user specified width
    width = input('Input width of swath (m): ');
    normalized_width = (width/pixel_size);
    m_prime = round(normalized_width);
%
% set coordinates (x,y) of upper-left swath corner in dem space
    x = x1;
    y = y1;
%
% find lower corner points of swath
    x_shift = normalized_width*sin(angle);
    y_shift = normalized_width*cos(angle);
    x3 = x1 + round(x_shift);
    y3 = y1 + round(y_shift);
    x4 = x2 + round(x_shift);
    y4 = y2 + round(y_shift);
%
% set plotting parameters for box
    xplot = [x1 x2 x2 x4 x4 x3 x3 x1];
    yplot = [y1 y2 y2 y4 y4 y3 y3 y1];
%
% plot bounding box
    figure(1)
    hold on
	plot(xplot,yplot,'-k')
%
% call findpatch.m to interpolate values at points on grid
% with length n_prime, width m_prime, at an angle of angle to x-axis.
	[patch] = findpatch(dem,x,y,angle,m_prime,n_prime);
%
% call avg.m to bin and average values
	[maxelev,minelev,meanelev,stdelev,cumdist] = avg(patch,pixel_size,dim_flag);
%
% plot swath data
	figure(2)
    clf
	hold on
	cumdist = cumdist/1000;
	plot(cumdist,meanelev,'r')
	plot(cumdist,maxelev,'g')
	plot(cumdist,minelev,'b')
	plot(cumdist,(meanelev + stdelev),'k')
	plot(cumdist,(meanelev - stdelev),'k')
	xlabel('Distance(km)')
	ylabel('Elevation (m)')
%