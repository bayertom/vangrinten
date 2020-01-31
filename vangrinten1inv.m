function [lat, lon] = vangrinten1inv(R, X, Y)
    eps = 1.0e-5
    x=abs(X)/(R*pi);
    y=abs(Y)/(R*pi);
    if (abs(X)<eps) %lat=0
        t=2*y/(1+y^2); 
        lat=sign(Y)*t*pi/2;
        lon=0;
    elseif (abs(Y)<eps) %lon=0
        lat=0; lon=sign(X)*pi;
    else
        %Solve quadratic equation for s
        a=x;
        b=1-x*x-y*y;
        c=-x;
        D=b^2-4*a*c;
        s=(-b+sqrt(D))/(2*a);
        lon=sign(X)*s*pi*180/pi;

        %%Solve the cubic equation for t
        at=x^4+2*x^2*y*(1+y)+(1+y)^2*(1+y^2);
        bt=-2*(x^2*(y-1)+y*(1+y)^2);
        ct=-4*y*(1+x^2+y^2);
        dt=8*y^2;
        A=bt/at;
        B=ct/at;
        C=dt/at;
        Q_=(3*B-A^2)/9;
        R_=(9*A*B-27*C-2*A^3)/54;
        D_=Q_^3+R_^2;
        theta = acos(R_/sqrt(-Q_^3));

        t=2*sqrt(-Q_)*cos((theta+4*pi)/3)-A/3;
        lat=sign(Y)*pi/2*t*180/pi;
    end
end

