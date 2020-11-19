function [X,Y] = vangrinten2(R, lat, lon)
    eps = 1.0e-5
    
    %Parametrization
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
        %Solve quadratic equation for x
        a = s^2 + 1/s^2 + 4/ t^2 - 2;
        b = 4*(s^2-1)*(t^2-1)/(s*t^2);
        c = 4*(1-1/t^2);
        D = b^2-4*a*c;
        x=(-b+sqrt(D))/(2*a);

        %Solve quadratic equation for y
        b = -2*(1+s^2)^2/(s^2*t);
        c = (1+s^2)^2/(s^2);
        D = b^2 - 4 * a * c;
        y =(-b - sqrt(D))/(2 * a);

        %Alternatively
        %y=sqrt(1-x^2+2*x*(s^2-1)/(2*s));

        X=sign(lon)*R*x;
        Y=sign(lat)*R*y;
    end
end

