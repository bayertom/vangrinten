function [X,Y] = vangrinten3(R, lat, lon)
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
        a = s*t^2;
        b = t^2*(1-s^2);
        c = 2*s*(1-t^2-sqrt(1-t^2));
        D = b^2-4*a*c;
        x =(-b+sqrt(D))/(2*a);
        y =(1-sqrt(1-t^2))/t;

        %Transform to the sphere of the radius R
        X=sign(lon)*R*x;
        Y=sign(lat)*R*y;
    end
end

