function Ia = solar_rad(Va,G,TaC)
k = 1.381e-23; % Boltzmann's constant
q = 1.602e-19; % Electron charge
Eg = 1.12; % Band gap energy; 1.12eV (Si)
Ns = 36; % # of series connected cells (solar_rad, 36 cells)
TrK = 321;%reference temperature for 25 degree Celcius 
Voc_TrK = 0.59; % Voc (open circuit voltage per cell) @ temp TrK
Isc_TrK=2.55;
Iph_TrK =2.56;
a = 0.65e-3; % Temperature coefficient of Isc (0.065%/C)
%TaC = 25;
NOCT=48;
T=TaC+G*(NOCT-25);
TaK=273+T;
%Va =0;
Vc = Va / Ns; % Cell voltage
% Calculate photon generated current @ given irradiance
Iph = G*Iph_TrK*(1 + (a * (TaK - TrK)));
%Calculate ideality factor
n_TrK=1.47;% Diode ideality factor (n)at reference conditions
n = n_TrK*(TaK/TrK);
Vt_TrK = n_TrK * k * TrK / q;
Vt_Ta = Vt_TrK*(TaK/TrK);
b = Eg * q /(n_TrK * k);
Ir_TrK = Isc_TrK / (exp(Voc_TrK / Vt_TrK) -1);
% Ir_TrK=1.8892e-6;
Ir = Ir_TrK * (TaK / TrK)^(3/n) * exp(-b * (1 / TaK -1 / TrK));
dVdI_Voc=-1.00/Ns;
Xv = Ir_TrK / Vt_TrK * exp(Voc_TrK / Vt_TrK);
Rs = - dVdI_Voc - 1/Xv;
% Rs = R/Ns;
Rp=4.6/(G-0.09678);%0.3012/(G-0.09678);%
% Ia = Iph - Ir * (exp((Vc + Ia * Rs) / Vt_Ta) -1)-((Vc+Ia*Rs)/Rp)
% f(Ia) = Iph - Ia - Ir * ( exp((Vc + Ia * Rs) / Vt_Ta) -1)-((Vc+Ia*Rs)/Rp) = 0
% Solve for Ia by Newton's method: Ia2 = Ia1 - f(Ia1)/f'(Ia1)
Ia=zeros(size(Vc)); % Initialize Ia with zeros
% Perform 5 iterations
for j=1:5;
Ia = Ia - (Iph - Ia - Ir .* ( exp((Vc + Ia .* Rs) ./ Vt_Ta) -1)-((Vc+Ia*Rs)/Rp))...
./ (-1 - Ir * (Rs ./ Vt_Ta) .* exp((Vc + Ia .* Rs) ./ Vt_Ta)-(Rs/Rp));
end

