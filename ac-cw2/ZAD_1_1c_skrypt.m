%% LABORATORUM SA
% ∆WICZENIE C2 - Nieparametryczne metody identyfikacji
% ZADANIE 1.1c
%%
close all; clear all; clc;

%% ZADANIE 1.1c
%---- ï PowtÛrzyÊ procedurÍ identyfikacji dla przypadku danych zaszumionych zebranych
%----   w macierzy nS w pliku NoisyProcessStepResponse.mat. Co moøna powiedzieÊ
%----   na temat efektywnoúci metody w przypadku danych zaszumionych?

% wczytanie danych
load NoisyProcessStepResponse.mat;
t = nS(1:end, 1);
ans = nS(1:end, 2);

%% Wyznaczenie wzmocnienia statycznego
% na podstawie danych z kursora
Au = 1;               % amplituda wymuszenia skokowego = 1
yUst = max(ans);      % czas wystπpienia amplitudy

% wzmocnienie statyczne
K = yUst / Au;

%% Wyznaczenie rzÍdu dynamiki obiektu
% na podstawie danych z kursora, tabeli 1.
T50 = 33.7;
T90 = 58.6;

% zastÍpcza sta≥a czasowa T
T = T90 / 7.99;

% rzπd dynamiki obiektu - dobrano z tabeli
p = 5;          

%% Wyznaczenie odpowiedzi skokowej modelu Gm1
s = tf('s');
num = K;
den = (T*s+1)^p;
Gm1 = tf(num/den);

%% Wyznaczenie odpowiedzi impulsowej modelu Gm1
% Wyznaczenie pochodnej odpowiedzi skokowej
Tp = t(2)-t(1);
dans = diff(ans)./Tp;

%% WYNIKI - Odpowiedzi skokowe
% Odpowiedü skokowa obiektu
figure(1);
plot(t, ans, 'm');

% Odpowiedü skokowa modelu
hold on;
step(Gm1);

% Opis wykresu
grid on;
xlabel('czas t [s]');
ylabel('odpowiedü uk≥adu [-]');
title({
    ['ODPOWIEDè UK£ADU NA WYMUSZENIE SKOKOWE'                        ] 
    ['K = ' num2str(K), ', T90/T50 = ' num2str(T90/T50) ', p = ' num2str(p)  ', T = ' num2str(T)  ]
    });
legend('{\itobiekt}','{\itmodel}');

%% Odpowiedzi impulsowe
% Odpowiedü impulsowa obiektu
figure(2);
plot(t(2:end), dans, 'r');

% Odpowiedü impulsowa modelu
hold on;
impulse(Gm1);

% Opis wykresu
grid on;
xlabel('czas t [s]');
ylabel('odpowiedü uk≥adu [-]');
title('ODPOWIEDè UK£ADU NA WYMUSZENIE IMPULSOWE'); 
legend('{\itobiekt}','{\itmodel}');
