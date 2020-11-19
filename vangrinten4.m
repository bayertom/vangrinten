function [X,Y] = vangrinten4(R, lat, lon)
    eps = 1.0e-5

    %Parametrization
    s = 2*abs(lon) / pi;
    t = 2*abs(lat)/pi;

    %Singular cases
    if (abs(lat)<eps) %lat=0
        X=2*R*lon/pi; Y=0;
    elseif (abs(lon)<eps) %lon=0
        X=0; Y=2*R*lat/pi;
    elseif (abs(abs(lat)-pi/2) < eps) %lat=+-pi/2
        X=0; Y=R*sign(lat);
    else %Otherwise
        %Solve quadratic equation for x
        a = s^2 + 1 /s^2 + (5+t*(t*(t-1)-3))^2/t^4 - 2
        b = (1-s^2)*(t-1)*(-25 + t*(5+6*t+t^3+t^4))/(s*t^4)
        c = (t-1)^2*(1+t)*(5 + 2*t)*(3*t-5)/t^4
        D = b^2-4*a*c;
        x =(-b+sqrt(D))/(2*a);

        %Solve quadratic equation for y
        b = (3*t+t^2-t^3-5)*(t+s^4*t-2*s^2*(t^2+3*t-5))/(s^2*t^3)
        c = (t^2+3*t-s^2*t-5)*(s^2*(t^2+3*t-5)-t)/(s^2*t^2)
        D = b^2 - 4.0 * a * c;
        y = (-b-sqrt(D))/(2*a);
        
        %Transform to the sphere of the radius R
        X=sign(lon)*R*x;
        Y=sign(lat)*R*y;
    end
end

