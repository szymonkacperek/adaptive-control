%% LABORATORUM SA
% ∆WICZENIE C2 - Nieparametryczne metody identyfikacji
% ZADANIE 1.2b
%%
close all; clear all; clc;

%% ZADANIE 1.2b
%---- ï PowtÛrzyÊ procedurÍ identyfikacji dla przypadku danych zaszumionych zebranych
%----   w macierzy nS w pliku NoisyProcessStepResponse.mat. Co moøna powiedzieÊ
%----   na temat efektywnoúci metody w przypadku danych zaszumionych?

load NoisyProcessStepResponse.mat;
t = nS(1:end, 1);
ans = nS(1:end, 2);

%% Wyznaczenie wzmocnienia statycznego
% na podstawie danych z kursora
Au = 1;               % amplituda wymuszenia skokowego = 1
yUst = max(ans);      % czas wystπpienia amplitudy

% wzmocnienie statyczne
K = yUst / Au;

%% Wyznaczenie prostej stycznej do odpowiedzi skokowej
% Wyznaczenie punktu przegiÍcia - wartoúci Tg
% Wyznaczenie pochodnej odpowiedzi skokowej
Tp = t(2)-t(1);
dans = diff(ans)./Tp;
Ag = max(dans);
indeks = find(dans == Ag);
Tg = t(indeks);

% Okreúlenie sta≥ych T i T0
Yg = ans(indeks);       % punkt przegiÍcia
T0 = (Ag*Tg-Yg)/Ag;
T = (Au*K)/Ag;

%% Wyznaczenie transmitancji Gm2
s = tf('s');
Gm2 = (K*exp(-s*T0)) / (T*s+1);

%% WYNIKI
% Odpowiedü skokowa obiektu
figure(1);
plot(t, ans, 'm');

% Odpowiedü skokowa modelu
hold on;
step(Gm2); 

% Odpowiedü impulsowa obiektu
hold on;
plot(t(2:end), dans, 'k');

% Odpowiedü impulsowa modelu
hold on;
impulse(Gm2);

% Opis wykresu
grid on;
xlabel('czas t [s]');
ylabel('amplituda');
title({
    ['ODPOWIEDè OBIEKTU'] 
    });
legend('{\itskokowa obiektu}','{\itskokowa modelu}','{\itimpulsowa obiektu}','{\itimpulsowa modelu}');