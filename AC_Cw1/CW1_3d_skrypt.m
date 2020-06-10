%% LABORATORUM SA
% ÆWICZENIE C1 - Analiza sygna³ów deterministycznych i losowych w dziedzinie czasu i czêstotliwoœci
% ZADANIE 1.3d
%%
close all; clear all; clc;

%% Parametry próbkowania
tend = 1;
Tp = 0.001;
t = 0 :Tp: (tend-Tp);
N = size(t,2);

%% DEFINICJE ANALIZOWANYCH SYGNALOW
Ve = 0.25;                          % wariancja szumu bialego
e = sqrt(Ve)*randn(1,N);            % Szum bia³y e(nTp). randn(1,N) to macierz 1xN o losowych wspolrzednych (rozklad normalny)
Gf = tf([0.1], [1 -0.9], Tp);       % Transmitancja H
x = sin(2*pi*5*t);                  % x(nTp)
y = sin(2*pi*5*t) + e;              % y(nTp)
v = lsim(Gf,e,t);                   % v(nTp) - odpowiedz transmitancji H na wymuszenie skokowe
% z = sin(2*pi*5*t) + 0.5*sin(2*pi*10*t) + 0.25*sin(2*pi*30*t);   % ??

%% ZADANIE 1.3b
%---- • Dla pary sygna³ów y(nTp) i x(nTp) obliczyæ i wykreœliæ wartoœci estymatora funkcji
%----   korelacji wzajemnej dla i E [?(N ? 1), N ? 1] (skorzystaæ w w³asnoœci W1)

i=-N:N;
% n=numel(i);
% estymator_e=zeros(1,n);

for j=1 :1: numel(i)
    estymator_xy(j) = Covar([x' y'] , j-1000);
    estymator_yx(j) = Covar([y' x'] , j-1000);
end

% e
figure(1);
subplot(211);
plot(i, estymator_xy, '--r');
grid on;
xlabel('i [-]');
ylabel('e [-]');
title("Przebieg funkcji autokorelacji sygna³u {\itx(n)} oraz {\ity(n)} dla i \in  <-"+ N + ";" + N +">");
legend('xy');

subplot(212);
plot(i, estymator_yx, ':m');
grid on;
xlabel('i [-]');
ylabel('e [-]');
title("Przebieg funkcji autokorelacji sygna³u {\ity(n)} oraz {\itx(n)} dla i \in  <-"+ N + ";" + N +">");
legend('yx');
