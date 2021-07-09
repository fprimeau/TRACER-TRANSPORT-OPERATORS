function [D,ind] = fdIF(grd,IF,lon,lat,K)
% give grd, IF stencil,lon, and lat, 
% fdIF can find the nearest Impulse index
% IF: tracer number N with 1s and 0s patter, 
%     the IF is a vector the size is (ncell,I), I is the layer
% K: the number of closest points with 1s
% lon and lat in DEG

Rad2Deg = 180/pi;

aa = find(IF~=0);
lonC = grd.lonCell(aa)*Rad2Deg;
latC = grd.latCell(aa)*Rad2Deg;
dist = abs(lon-lonC) + abs(lat-latC);
[D,ii]= mink(dist,K);
% ii = find,K,'first'))
ind = aa(ii);
