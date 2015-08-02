clear all
close all
load TIrr.mat
%load TempData.mat
%TaC=TempData;
 for i=1:length(TIrr)
 fprintf('%d iteration\n',i);
 %different values of g
 g=TIrr(i)/1000.0;
 %g=1 corresponds to G=1000 W/m2
 G(1,i)=g;
 TaC(1,i)= 30+G(1,i)*10;
 TaC(1,i)= TaC(1,i)/38.4131;
 Pmax=0;
 Vmax=0;
 Imax=0;
 k=1;
 Ia(k)=0.001;
 Va(k)=21;
  for k=1:250 
  Va(k+1) = solar_rad_inv(Ia(k), G(1,i),TaC(1,i));
Pam(k+1)=Va(k+1)*Ia(k);
if Pam(k+1)>Pmax;
    Pmax=Pam(k+1);
    Vmax=Va(k+1);
    Imax=Ia(k);
end
  Ia(k+1)=Ia(k)+0.01;
end
  Pa=Va.*Ia;
Vm(1,i)=Vmax;
Im(1,i)=Imax;
Pm(1,i)=Pmax;
hold on
plot(Va,Pa,'k');
plot(Vmax,Pmax,'r*')
end

Ginput=[G;TaC];
Toutput=[Pm;Vm;Im];
disp(Toutput)
save solar_annual_data  Ginput Temp_output

