function [lat, lon] = vangrinten4inv(R, X, Y)
    eps = 1.0e-5
    
    %Transform to the unit sphere
    x=abs(X)/R;
    y=abs(Y)/R;
    
    %Singular cases
    if (abs(X)<eps) %lat=0
        t=2*y/(1+y^2); 
        lat=sign(Y)*y*pi/2;
        lon=0;
    elseif (abs(Y)<eps) %lon=0
        lat=0; lon=sign(X)*x*pi/2;
    else
        %Solve quadratic equation for s
        a=x;
        b=1-x*x-y*y;
        c=-x;
        D=b^2-4*a*c;
        s=(-b+sqrt(D))/(2*a);
        lon=sign(X)*s*pi/2;
        
        %Solve cubic equation for t
        a = 1+y;
        b = -(x^2 - 3 + y + y^2);
        c = -(5 + 3*y);
        d = 5 * y;
        A = b / a;
        B = c / a;
        C = d / a;
        Q = (3.0 * B - A * A) / 9.0;
        R = (9.0 * A * B - 27.0 * C - 2.0 * A * A * A) / 54.0;
        D = Q * Q * Q + R * R;
        theta = acos(R / sqrt(-Q * Q * Q));
        t3 = 2.0 * sqrt(-Q) * cos((theta + 4.0 * pi) / 3.0) - A / 3.0;
        
        lat =  sign(Y) * pi / 2 * t3;
    end
end

