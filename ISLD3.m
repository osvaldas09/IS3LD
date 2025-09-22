clc
clear all

x = 0.1 : 1/22:1;
d = (1 + 0.6 * sin (2 * pi * x / 0.7) + 0.3 * sin (2 * pi * x)) / 2;
plot(x, d)
%% Pradinių parametrų reikšmių pasirinkimas

eta=0.1;

c1=0.190909;
c2=0.918182;

% r1=0.00909;
% r2=0.918182-0.87273;

r1=0.20509;
r2=0.3;

% 2 sluoksnis

w11_2=rand(1); b1_2=rand(1);
w21_2=rand(1);

centr=0;
a = 0;

for cr = 2:(length(d)-1)

    if (d(cr) > d(cr+1)) && (d(cr) > d(cr-1))          %&& (x(cr) > x(cr-1))
        a=a+1;
        centr(a) = x(cr);
    end

end

for centr_nr = 1:1

    rr(centr_nr)=abs(centr(centr_nr)-centr(centr_nr+1))/((2*sqrt(2)));
    rr(2)=centr(1);

    %ra=centr(1)-(cntr(1)*sqrt(2));

end

%% Tinklo atsako skaičiavimas

for k = 1: 50000
    
    for t = 1:20

        % 1 sluoksnis
    
        F1=exp((-(x(t)-centr(1))^2)/(2*rr(1)^2));

        F2=exp((-(x(t)-centr(2))^2)/(2*rr(2)^2));
        
        % 2 sluoksnis

        v1_2=F1*w11_2+F2*w21_2+b1_2;
        y=v1_2;

        % Klaidos skaičiavimas

        e=d(t)-y;

        % Ryšių svorių atnaujinimas

        Delta_out=e;

        % 2 sluoksnis

        w11_2=w11_2+eta*Delta_out*F1;
        w21_2=w21_2+eta*Delta_out*F2;

        b1_2=b1_2+eta*Delta_out;

    end
end

%%Testavimas

x_t=0.1 : 1/50:1;
y_t=(1 + 0.6 * sin (2 * pi * x_t / 0.7) + 0.3 * sin (2 * pi * x_t)) / 2;
ee=0;

 % 1 sluoksnis

 for tt = 1:45
    
        F1=exp(-(x_t(tt)-centr(1))^2/(2*rr(1)^2));

        F2=exp(-(x_t(tt)-centr(2))^2/(2*rr(2)^2));
        
        % 2 sluoksnis

        v1_2_t=F1*w11_2+F2*w21_2+b1_2;
        y=v1_2_t;
        y_t(tt)=y;

        % Klaidos skaičiavimas

%         ee=ee+abs(d(tt)-y);
 end

 disp(ee)

 figure(2)
 plot(x_t, y_t)
 hold on
 plot(x, d)