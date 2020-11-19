clc
clear

%Input parameters: Point [lat, lon]
lat = 50 * pi / 180
lon = -150 * pi / 180 
R = 1

%Transform radius: Grinten I-III
R13 = R * 1;
 
%Transform radius: Grinten IV
R4 = R * pi/2;
 
%Grinten I.
[X1, Y1] = vangrinten1(R13, lat, lon);
[lat2, lon2] = vangrinten1inv(R13, X1, Y1);
lat2d = lat2 * 180 / pi; 
lon2d = lon2 * 180 / pi; 

%Grinten II.
[X2, Y2] = vangrinten2(R13, lat, lon);
[lat22, lon22] = vangrinten2inv(R13, X2, Y2);
lat22d = lat22 * 180 / pi; 
lon22d = lon22 * 180 / pi; 

%Grinten III.
[X3, Y3] = vangrinten3(R13, lat, lon);
[lat23, lon23] = vangrinten3inv(R13, X3, Y3);
lat23d = lat23 * 180 / pi; 
lon23d = lon23 * 180 / pi; 

%Grinten IV.
[X4, Y4] = vangrinten4(R4, lat, lon);
[lat24, lon24] = vangrinten4inv(R4, X4, Y4);
lat24d = lat24 * 180 / pi; 
lon24d = lon24 * 180 / pi; 