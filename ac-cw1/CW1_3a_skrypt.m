%% LABORATORUM SA
% ÆWICZENIE C1 - Analiza sygna³ów deterministycznych i losowych w dziedzinie czasu i czêstotliwoœci
% ZADANIE 1.3a
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
%z = sin(2*pi*5*t) + 0.5*sin(2*pi*10*t) + 0.25*sin(2*pi*30*t);   % ??

%% Zadanie 1.3a
%---- • Dla wszystkich sygna³ów obliczyæ wartoœci estymatora funkcji autokorelacji dla i E
%----   [0, N - 1]. Sprawdziæ ró¿nice w przebiegu funkcji autokorelacji przy zastosowaniu
%----   estymatora obci¹¿onego i nieobci¹¿onego.

for i=0 : N-1
    estymator_e(i+1) = Covar([e' e'], i);
    estymator_e_nobc(i+1) = CovarNobc([e' e'], i);
    estymator_x(i+1) = Covar([x' x'], i);
    estymator_x_nobc(i+1) = CovarNobc([x' x'], i);
    estymator_y(i+1) = Covar([y' y'], i);
    estymator_y_nobc(i+1) = CovarNobc([y' y'], i);
    estymator_v(i+1) = Covar([v v], i);
    estymator_v_nobc(i+1) = CovarNobc([v v], i);    
end

% e
figure(1);
subplot(411);
plot(e, 'k');
hold on;
plot(estymator_e, 'r');
hold on;
% plot(estymator_e_nobc, 'b');
grid on;
xlabel('i');
ylabel('estymator');
title('Wykres estymatora autokorelacji e');
legend('e','estymator e','estymator e_nobc');

% x
subplot(412);
plot(x, 'k');
hold on;
plot(estymator_x, 'r');
hold on;
% plot(estymator_x_nobc, 'b');
grid on;
xlabel('i');
ylabel('estymator');
title('Wykres estymatora autokorelacji x');
legend('x','estymator x','estymator x_nobc');

% y
subplot(413);
plot(y, 'k');
hold on;
plot(estymator_y, 'r');
hold on;
% plot(estymator_y_nobc, 'b');
grid on;
xlabel('i');
ylabel('estymator');
title('Wykres estymatora autokorelacji y');
legend('y','estymator y','estymator y_nobc');

%v
subplot(414);
plot(v, 'k');
hold on;
plot(estymator_v, 'r');
hold on;
plot(estymator_v_nobc, 'b');
grid on;
xlabel('i');
ylabel('estymator');
title('Wykres estymatora autokorelacji v');
legend('v','estymator v','estymator v_nobc');