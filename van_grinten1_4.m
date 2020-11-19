clc
clear

%Input point
RO = 180 / pi
lat = -50 / RO
lon = 180 / RO
R = 1

t = 2 * abs(lat) / pi
s = abs(lon) / pi;

%Grinten III, forward
a = s*t^2;
b = -t^2*(s^2-1);
c = 2*s*(1-t^2-sqrt(1-t^2));
D = b^2 - 4 * a * c
x = sign(lon) * (-b + sqrt(D))/(2 * a);
y = sign(lat) * (1-sqrt(1-t^2))/t;
X = R * pi * x;
Y = R * pi * y;

%Grinten III, inverse
x2 = abs(x);
y2 = abs(y);
a = x2;
b = 1.0 - x2 * x2 - y2 * y2;
c = -x2;
D = b^2 - 4.0 * a * c;
s2 = (-b + sqrt(D)) / (2.0 * a) * RO
lon2 = sign(x) * s2 * pi;
lon3 = (1-y2)/x2*180/pi*pi*log(pi)
t2 = 2*y / (y^2 + 1)
lat2 = pi /2 * t * RO;

%Grinten II, forward
a = s^2 + 1/s^2 + 4/ t^2 - 2;
b = 4*(s^2-1)*(t^2-1)/(s*t^2);
c = 4*(1-1/t^2); 
D = b^2 - 4 * a * c;
x = sign(lon) * (-b + sqrt(D))/(2 * a);

b = -2*(1+s^2)^2/(s^2*t);
c = (1+s^2)^2/(s^2);
D = b^2 - 4 * a * c;
y = sign(lat)*(-b - sqrt(D))/(2 * a);
X = R * pi * x;
Y = R * pi * y;

%Grinten II, inverse
x2 = abs(x);
y2 = abs(y);
a = x2;
b = 1.0 - x2 * x2 - y2 * y2;
c = -x2;
D = b^2 - 4.0 * a * c;
s2 = (-b + sqrt(D)) / (2.0 * a) * RO
lon2 = sign(x) * s2 * pi;

t2 = 2*y / (1 + x^2 + y^2)
lat2 = pi /2 * t2 * RO;

%Grinten I, forward
ts= sqrt(1-t^2);
a = s^2+1/s^2+(t-2)^2*(1+t+ts)^2/t^4-2;
b = 2*(1-s^2)*(t^6+16*(1+ts)+t^4*(7+ts)-8*t^2*(3+2*ts))/(s*t^4*(1+ts)^2);
c = 8*(t^2-1)*(1+ts)/t^4;
D = b^2-4*a*c;
x = sign(lon)*(-b+sqrt(D))/(2*a);

b = (t-2)*(1+t+ts)*(t+s^4*t+2*s^2*(1+ts))/(s^2*t^3)
c = (2*s^2+t+s^4*t)*(1+ts)/(s^2*t^2);
D = b^2-4*a*c;
y = sign(lat)*(-b-sqrt(D))/(2*a);
X = R*pi*x;
Y = R*pi*y;

%Grinten I, inverse
x2 = abs(x);
y2 = abs(y);
a = x2;
b = 1.0 - x2 * x2 - y2 * y2;
c = -x2;
D = b^2 - 4.0 * a * c;
s2 = (-b + sqrt(D)) / (2.0 * a) * RO;
lon2 = sign(x) * s2 * pi;

a = x^4 + 2*x2^2*y2*(1+y2)+(1+y2)^2*(1+y2^2);
b = -2*(x2^2*(y2-1)+y2*(1+y2)^2);
c = -4*y2*(1+x2^2+y2^2);
d = 8*y2^2;
A = b / a;
B = c / a;
C = d / a;
Q = (3.0 * B - A * A) / 9.0;
R = (9.0 * A * B - 27.0 * C - 2.0 * A * A * A) / 54.0;
D = Q * Q * Q + R * R;
theta = acos(R / sqrt(-Q * Q * Q));
t3 = 2.0 * sqrt(-Q) * cos((theta + 4.0 * pi) / 3.0) - A / 3.0;
lat2 = pi /2 * t3 * RO * sign(y);

%Grinten 4, forward
s = 2 * abs(lon) / pi;
a = s^2 + 1 /s^2 + (5+t*(t*(t-1)-3))^2/t^4 - 2
b = (1-s^2)*(t-1)*(-25 + t*(5+6*t+t^3+t^4))/(s*t^4)
c = (t-1)^2*(1+t)*(5 + 2*t)*(3*t-5)/t^4
D = b^2 - 4.0 * a * c;
x = sign(lon)*(-b+sqrt(D))/(2*a);
b = (3*t+t^2-t^3-5)*(t+s^4*t-2*s^2*(t^2+3*t-5))/(s^2*t^3)
c = (t^2+3*t-s^2*t-5)*(s^2*(t^2+3*t-5)-t)/(s^2*t^2)
D = b^2 - 4.0 * a * c;
y = sign(lat)*(-b+sqrt(D))/(2*a);

%Grinten 4, inverse
x2 = abs(x);
y2 = abs(y);
a = x2;
b = 1.0 - x2 * x2 - y2 * y2;
c = -x2;
D = b^2 - 4.0 * a * c;
s2 = (-b + sqrt(D)) / (2.0 * a) * RO;
lon2 = sign(x) * s2 * pi / 2;

a = 1+y2;
b = -(x2^2 - 3 + y2 + y2^2);
c = -(5 + 3*y2);
d = 5 * y2;
A = b / a;
B = c / a;
C = d / a;
Q = (3.0 * B - A * A) / 9.0;
R = (9.0 * A * B - 27.0 * C - 2.0 * A * A * A) / 54.0;
D = Q * Q * Q + R * R;
theta = acos(R / sqrt(-Q * Q * Q));
t3 = 2.0 * sqrt(-Q) * cos((theta + 4.0 * pi) / 3.0) - A / 3.0;
lat2 = pi /2 * t3 * RO * sign(y);

