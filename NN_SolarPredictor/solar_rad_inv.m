function [Va] = solar_rad_inv(Ia,G,TaC)
Vamax=200;
Vamin=0;
for j=1:20
    Va=(Vamax+Vamin)/2;
       dIa=solar_rad(Va,G,TaC)-Ia;
    if dIa>0
        Vamin=Va;
    else
        Vamax=Va;
    end
Va=(Vamax+Vamin)/2;
end
