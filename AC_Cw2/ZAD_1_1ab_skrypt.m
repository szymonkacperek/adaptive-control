%% LABORATORUM SA
% ∆WICZENIE C2 - Nieparametryczne metody identyfikacji
% ZADANIE 1.1a, 1.1b
%%
close all; clear all; clc;

%% ZADANIE 1.1a
%---- ï W pliku ProcessStepResponse.mat zapisano zbiÛr chwil czasu oraz odpowiadajπcy 
%----   im zbiÛr prÛbek odpowiedzi skokowej pewnego obiektu dynamicznego (pobudzano skokiem jednostkowym). 
%----   Dane zapisano w postaci dwukolumnowej macierzy
%----   S, ktÛrej pierwsza kolumna odpowiada wektorowi chwil czasu wyraøonych w sekundach, a druga 
%----   wektorowi prÛbek zarejestrowanej odpowiedzi skokowej obiektu.

%% ZADANIE 1.1b
%---- ï Za≥adowaÊ zarejestrowane dane do przestrzeni roboczej Matlaba. 
%----   WykreúliÊ odpowiedü skokowπ obiektu. Na podstawie odpowiedzi skokowej oszacowaÊ wzmocnienie
%----   statyczne obiektu. Stosujπc wartoúci zawarte w tablicy 1 oszacowaÊ rzπd dynamiki
%----   oraz parametry zastÍpcze modelu Gm1(s). PorÛwnaÊ odpowiedü skokowπ i impulsowπ obiektu oraz modelu Gm1(s).

% wczytanie danych
load ProcessStepResponse.mat;
t = S(1:end, 1);
ans = S(1:end, 2);

%% Wyznaczenie wzmocnienia statycznego
% na podstawie danych z kursora
Au = 1;               % amplituda wymuszenia skokowego = 1
yUst = max(ans);      % czas wystπpienia amplitudy

% wzmocnienie statyczne
K = yUst / Au;

%% Wyznaczenie rzÍdu dynamiki obiektu
% na podstawie danych z kursora, tabeli 1.
T50 = 11.5;
T90 = 22.8;

% zastÍpcza sta≥a czasowa T
T = T90 / 5.32;

% rzπd dynamiki obiektu - dobrano z tabeli
p = 3;          

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
