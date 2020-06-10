%% LABORATORUM SA
% ÆWICZENIE C1 - Analiza sygna³ów deterministycznych i losowych w dziedzinie czasu i czêstotliwoœci
% ZADANIE 2.1a
%%
close all; clear all; clc;

%% PARAMETRY PRÓBKOWANIA
tend = 1;   % wówczas N = 1000
Tp = 0.001;
t = 0 :Tp: (tend-Tp);
N = size(t,2);

%% DEFINICJE ANALIZOWANYCH SYGNA£ÓW
Ve = 0.25;
Gf = tf([0.1], [1 -0.9], Tp);       
x = sin(2*pi*5*t) + 0.5*sin(2*pi*10*t) + 0.25*sin(2*pi*30*t);
e = sqrt(Ve)*randn(1,N);
v_primary = lsim(Gf,e,t);   
v = v_primary';

%% ZADANIE 2.1a
%---- • Przyjmuj¹c Tp = 0.001 s oraz N = 1000 obliczyæ i wykreœliæ widmo amplitudowe
%----   |XN(?k)| sygna³u x(nTp) oraz jego periodogram. Zinterpretowaæ uzyskane wyniki.
%----   Sprawdziæ twierdzenie Parsevala.
%----   Uwaga: do obliczeñ mo¿+na wykorzystaæ funkcjê fft() Matlaba, która realizuje
%----   szybk¹ wersjê transformaty DFT z równania (12).

%% 
select = x;

% Parametry wykresu
dO = 2*pi/N;
Omega = 0:dO:(pi-dO);
omega = Omega./Tp;

% Transformata Fouriera sygna³ów
fft_select = fft(select, N);
abs_fft_select = abs(fft_select);
widmo_amp_select = 2*abs_fft_select./N;

% Periodogram (widmo mocy sygna³u)
conj_fft_select = conj(fft_select);
pSelect = fft_select.*conj(fft_select)./N;

% Sprawdzenie twierdzenia Parsevala
parseval_pSelect = sum(pSelect);
parseval_Select = sum(select.*select);

%% WYNIKI
% x
figure(1);
% subplot(311);
plot(t, select, 'g');
grid on;
xlabel('czas t [s]');
ylabel('np. napiêcie [V]');
title("Sygna³ {\itx(n)}");
legend('{\itx(n)}');

figure(2);
% subplot(312);
stem(omega, widmo_amp_select(1:floor(N/2)), 'r');
grid on;
xlabel('pulsacje \omega_k [rad/s]');
ylabel('pr¹¿ki [-]');
title("Widmo amplitudowe sygna³u {\itx(n)}");
legend('{\itx(n)}');

figure(3);
% subplot(313);
stem(omega, pSelect(1:floor(N/2)), 'b');
grid on;
xlabel('pulsacje \omega_k [rad/s]');
ylabel('pr¹¿ki [-]');
title("Periodogram sygna³u {\itx(n)}");
legend('{\itx(n)}');