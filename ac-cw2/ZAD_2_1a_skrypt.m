%% LABORATORUM SA
% ∆WICZENIE C2 - Nieparametryczne metody identyfikacji
% ZADANIE 2.1a

% Program naleøy uruchomiÊ z wyczyszczonym Workspace, nastepnie uruchomiÊ
% model BlackBoxG, po czym znÛw uruchomiÊ program. Po kaødorazowym
% uruchomieniu naleøy wyczyúciÊ Workspace i postÍpowaÊ analogicznie.
% Ewentualnie, zmieniÊ okres prÛbkowania na innπ wartoúÊ oraz zapisaÊ w
% folderze projektu. Aktualnie (19/04/2020) Tp = 0.2

%%
close all; clc;

%% Parametry prÛbkowania
tend = 30;
Tp = 0.2;
t = 0 :Tp: (tend-Tp);
N = size(t,2);

%% ZADANIE 2.1a
%---- ï Wykorzystujπc plik BlackBoxG.mdl zawierajπcy blok dynamiki identyfikowanego
%----   procesu utworzyÊ schemat blokowy pozwalajπcy na pobudzenie obiektu szumem
%----   bia≥ym o wariancji ?u2 = 0.5 i akwizycjÍ danych pomiarowych do przestrzeni roboczej Matlaba;
%----   naleøy pamiÍtaÊ o odpowiednim umiejscowieniu blokÛw prÛbkujπcopamiÍtajπcych 
%----   Zero-Order Hold (okres prÛbkowania rÛwny Tp). Uwaga: przed
%----   uruchomieniem schematu naleøy zainicjowaÊ wartoúci zmiennych Tp oraz sigma2v,
%----   przy czym pierwsza z nich oznacza okres prÛbkowania, a druga wariancjÍ zak≥Ûcenia v(n).

% ZADANIE 2.1c
%---- ï SprawdziÊ wp≥yw wartoúci okresu prÛbkowania Tp na jakoúÊ identyfikacji ñ przyjπÊ
%----   wartoúci z nastÍpujπcego zbioru: Tp ? {1.0; 0.5; 0.2} s. Uwaga: liczbÍ prÛbek M
%----   naleøy dobraÊ dla kaødej wartoúci Tp.

% ZADANIE 2.1d
%---- ï SprawdziÊ wp≥yw wartoúci wariancji zak≥Ûcenia pomiarowego v(n) na 
%----   jakoúÊ identyfikacji ñ przyjπÊ wartoúci zmiennej sigma2v ze zbioru: {0.0; 0.001; 0.01}

% load Signal_U_Y.mat;
% load Signal_V.mat;
sigma2v = 0.001;
sigma2u = 0.5;
u = Signal(:, 1);
y = Signal(:, 2);
R_u = zeros(N, N);
R_u_alt = zeros(2*N, 2*N);

%% ZADANIE 2.1b
%---- ï Stosujπc wzory (11) przeprowadziÊ eksperyment identyfikacji obciÍtej odpowiedzi impulsowej 
%----   metodπ analizy korelacyjnej (funkcja pseudoinwersji w Matlabie:
%----   pinv()) ñ przyjπÊ wstÍpnie M = 30 dla Tp = 1. WyznaczyÊ przybliøonπ odpowiedü 
%----   skokowπ obiektu stosujπc zaleønoúÊ (12). Na podstawie uzyskanych odpowiedzi czasowych 
%----   oszacowaÊ strukturÍ modelu oraz przybliøone wartoúci parametrÛw
%----   charakterystycznych identyfikowanej dynamiki. Uwaga: do obliczeÒ moøna wykorzystaÊ funkcjÍ Covar(D,tau).

% Wyznaczenie wektora funkcji autokorelacji sygna≥u u ^r_u
for j=0 : N-1
    r_u(j+1) = Covar([u u], j);
end

% Wyznaczenie macierzy autokorelacji sygna≥u u ^R_u
for j=0 : N-1
    R_u((j+1), (j+1):end) = r_u(1:N-j);
    R_u((j+1):end, (j+1)) = r_u(1:N-j);        
end

% Wyznaczenie wektora korelacji wzajemnej sygna≥u y oraz u
for j=0 : N-1
    r_yu(j+1) = Covar([y u], j);
end

r_yu = r_yu';   % konwersja na wektor pionowy

%% Wyznaczenie M prÛbek odpowiedzi impulsowej gM_alt rÛwnaniem (9)
for j=0 : 2*N-1
    r_u_alt(j+1) = Covar([u u], j);
end
for j=0 : 2*N-1
    R_u_alt((j+1), (j+1):end) = r_u_alt(1:2*N-j);
    R_u_alt((j+1):end, (j+1)) = r_u_alt(1:2*N-j);        
end
for j=0 : 2*N-1
    r_yu_alt(j+1) = Covar([y u], j);
end

r_yu_alt = r_yu_alt';   % konwersja na wektor pionowy
% gM_9 = (pinv(R_u_alt) * r_yu_alt) .* (1/Tp);

for i=N : numel(gM_9)
    gM_9(i) = 0;
end

%% Wyznaczenie M prÛbek odpowiedzi impulsowej gM rÛwnaniem (10)
gM_10 = (r_yu ./ sigma2u) .*(1/Tp);

%% Wyznaczenie M prÛbek odpowiedzi skokowej hM
% RÛwnaniem (9)
for j=1 : N-1
    hM_9(j) = Tp .* sum(gM_9(1:j));
end

% RÛwnaniem (10)
for j=1 : N-1
    hM_10(j) = Tp .* sum(gM_10(1:j));
end

%% Transmitancja G - z modelu BlackBoxG
num = [0.5];
den = [5 11 7 1];
G = tf([num], [den]);

%% WYNIKI - wykresy
% Odpowiedzi impulsowe modelu
figure(1);
plot(t, gM_9(1:numel(t)), 'r');
hold on;
plot(t, gM_10);
hold on;
impulse(G, 'm');
% Opis wykresu
grid on;
xlabel('czas t [s]');
ylabel('amplituda');
title({
    ['ODPOWIEDè IMPULSOWA MODELU'] 
    });
legend('{\itrÛwnanie (9)}','{\itrÛwnanie (10)}','{\ittransmitancja}');

% Odpowiedzi skokowe modelu
figure(2);
plot(t(2:end), hM_9);
hold on;
plot(t(2:end), hM_10, 'r');
hold on;
step(G, 'm');
% Opis wykresu
grid on;
xlabel('czas t [s]');
ylabel('amplituda');
title({
    ['ODPOWIEDè SKOKOWA MODELU'] 
    });
legend('{\itrÛwnanie (9)}','{\itrÛwnanie (10)}','{\ittransmitancja}');

% Sygna≥y wejúciowe
figure(3);
plot(t, u);
hold on;
plot(t, y, 'r');
% Opis wykresu
grid on;
xlabel('czas t [s]');
ylabel('amplituda');
title({
    ['SYGNA£ WEJåCIOWY I WYJSCIOWY'] 
    });
legend('{\itu(t)}','{\ity(t)}');
