function [X,Y] = vangrinten1(R, lat, lon)
    eps = 1.0e-5

    %Parammetrization
    s = abs(lon)/pi;
    t = 2*abs(lat)/pi;
    
    %Singular cases
    if (abs(lat)<eps) %lat=0
        X=R*lon/pi; Y=0;
    elseif (abs(lon)<eps) %lon=0
        X=0; Y=R*sign(lat)*(1-sqrt(1-t^2))/t;
    elseif (abs(abs(lat)-pi/2) < eps) %lat=+-pi/2
        X=0; Y=R*sign(lat);
    else %Otherwise
        %Solve quadratic equation
        ts=sqrt(1-t^2);
        a=s^2+1/s^2+(t-2)^2*(1+t+ts)^2/t^4-2;
        b=2*(1-s^2)*(t^6+16*(1+ts)+t^4*(7+ts)-8*t^2*(3+2*ts))/(s*t^4*(1+ts)^2);
        c=8*(t^2-1)*(1+ts)/t^4;
        D = b^2-4*a*c;
        x=(-b+sqrt(D))/(2*a);
        
        %Back substitution
        y=sqrt(1-x^2+2*x*(s^2-1)/(2*s));
        
        %Alternatively, solve the quadratic equation for y 
        a=s^2+1/s^2+(t-2)^2*(1+t+ts)^2/t^4-2;
        b=(t-2)*(t+ts+1)*(t+s^4*t+2*s^2*(ts+1))/(s^2*t^3);
        c=(t+s^4*t+2*s^2)*(ts+1)/(s^2*t^2);
        D = b^2-4*a*c;
        y2=(-b+sqrt(D))/(2*a);
        
        %Transform to the sphere of the radius R
        X=sign(lon)*R*x;
        Y=sign(lat)*R*y;
    end
end

