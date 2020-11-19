function [lat, lon] = vangrinten2inv(R, X, Y)
    eps = 1.0e-5
    
    %Transform to the unit sphere
    x=abs(X)/R;
    y=abs(Y)/R;

    %Singular cases
    if (abs(X)<eps) %lat=0
        t=2*y/(1+y^2); 
        lat=sign(Y)*t*pi/2;
        lon=0;
    elseif (abs(Y)<eps) %lon=0
        lat=0; lon=sign(X)*x*pi;
    else
        %Solve quadratic equation for s
        a=x;
        b=1-x*x-y*y;
        c=-x;
        D=b^2-4*a*c;
        s=(-b+sqrt(D))/(2*a);
        lon=sign(X)*s*pi;

        %Compute t
        t = 2*y/(1+x^2+y^2);
        lat = sign(Y)* pi/2*t;
    end
end

