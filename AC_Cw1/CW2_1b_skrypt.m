%% LABORATORUM SA
% ÆWICZENIE C1 - Analiza sygna³ów deterministycznych i losowych w dziedzinie czasu i czêstotliwoœci
% ZADANIE 2.1b
%%
close all; clear all; clc;

%% PARAMETRY PRÓBKOWANIA
tend = 15;   % wówczas N = 15000
Tp = 0.001;
t = 0 :Tp: (tend-Tp);
N = size(t,2);

%% DEFINICJE ANALIZOWANYCH SYGNA£ÓW
Ve = 0.25;
Gf = tf([0.1], [1 -0.9], Tp);       
x = sin(2*pi*5*t) + 0.5*sin(2*pi*10*t) + 0.25*sin(2*pi*30*t);
e = sqrt(Ve)*randn(1,N);
v = lsim(Gf,e,t);   

%% ZADANIE 2.1b
%---- • Sprawdziæ wp³yw iloœci N próbek sygna³u x(t) branych do analizy widmowej na
%----   jakoœæ otrzymywanego widma amplitudowego oraz periodogramu (rozdzielczoœæ
%----   czêstotliwoœciowa).

% Parametry wykresu
dO = 2*pi/N;
Omega = 0:dO:(pi-dO);
omega = Omega./Tp;

% Transformata Fouriera sygna³ów
fft_x = fft(x, N);
abs_fft_x = abs(fft_x);
widmo_amp_x = 2*abs_fft_x./N;

% Periodogram
conj_fft_x = conj(fft_x);
pX = fft_x.*conj(fft_x)./N;

% Sprawdzenie twierdzenia Parsevala
parseval_pX = sum(pX);
parseval_X = sum(x.*x);

%% WYNIKI
% x
figure(1);
% subplot(311);
plot(x, 'g');
grid on;
xlabel('czas t [s]');
ylabel('np. napiêcie [V]');
title("Sygna³ {\itx(n)}");
legend('{\itx(n)}');

figure(2);
% subplot(312);
stem(omega, widmo_amp_x(1:floor(N/2)), 'r');
grid on;
xlabel('pulsacje \omega_k [rad/s]');
ylabel('pr¹¿ki [-]');
title("Widmo amplitudowe sygna³u {\itx(n)}");
legend('{\itx(n)}');

figure(3);
% subplot(313);
stem(omega, pX(1:floor(N/2)), 'b');
grid on;
xlabel('pulsacje \omega_k [rad/s]');
ylabel('pr¹¿ki [-]');
title("Periodogram sygna³u {\itx(n)}");
legend('{\itx(n)}');