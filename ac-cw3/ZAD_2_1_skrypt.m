%% LABORATORUM SA
% ÆWICZENIE C3 - Wsadowe metody identyfikacji parametrycznej
% ZADANIE 2.1

%---- • MIEJSCE NA NOTATKI
% 22/04 Zadanie 2.1b. Jest szansa, ¿e Ÿle obliczy³em yhat. Powinienem
%       wykorzystaæ model w którym sk³adnikiem sumy jest równie¿ sygna³
%       stochastyczny v. Wówczas móg³bym te¿ obliczyæ ym w inny sposób -
%       chyba bardziej poprawny.
% 23/04 Mam z³e estymowane parametry k^ i T^. p^ te¿. powinny byæ: phatLS(W)^=[0.9 0.19]
%       powinny byæ dla bia³ego (?). sigma2 dla C = . dla ci¹g³ego 0.94. 
% 23/04 k^ i T^ poprawione
%
%%
close all; clc; clear all

%% Parametry próbkowania
% Dostêpne w pliku PDF.
tend = 100;
Tp = 0.05;
t = 0 :Tp: tend;
N = size(t,2);

%% ZADANIE 2.1a
%---- • Dana jest nastêpuj¹ca struktura obiektu dynamicznego pierwszego rzêdu i jego
%----   aproksymacja dyskretna gdzie k0 i T0 s¹ nieznanymi prawdziwymi parametrami obiektu, natomiast
%----   aproksymacjê dyskretn¹ G(z) wyznaczono metod¹ ’zoh’ (transformacja skokowoinwariantna). 
%----   Na podstawie powy¿szej transmitancji mo¿emy zapisaæ model dyskretny obiektu 
%----   z u¿yciem operatora q = q?1 w postaci: y(n) = G(q, p)u(n)+ v(n),
%----   gdzie v(n) reprezentuje zak³ócenie losowe.

% Obliczenia dostêpne w pliku DOCX.

%% ZADANIE 2.1c
%---- • Plik IdentWsadowaDyn.mat zawiera zbiory danych pomiarowych (pary
%----   (u(n), y(n))) zapisane w dwóch macierzach DaneDynW, DaneDynC, przy czym
%----   pierwsza z nich zawiera pomiary zak³ócone szumem bia³ym, a druga – szumem
%----   kolorowym. Wprowadziæ dane do przestrzeni roboczej Matlaba istrukcj¹ load
%----   IdentWsadowaDyn.mat. Podzieliæ dane pomiarowe na dwa zbiory (np. w proporcji 50% do 50%): 
%----   Zest stanowi¹ce dane estymuj¹ce (u¿ywane do estymacji
%----   parametrów) oraz Zval stanowi¹ce dane weryfikuj¹ce (u¿ywane do weryfikacji modelu).

load IdentWsadowaDyn.mat;

u_est = DaneDynW(1:1000, 1);
y_est = DaneDynW(1:1000, 2);
N_est = numel(u_est);
t_est = t(1:N_est);

u_val = DaneDynW(1001:end, 1);
y_val = DaneDynW(1001:end, 2);
N_val = numel(u_val);
t_val = t(N_val:end);

u = DaneDynW(1:end, 1);
y = DaneDynW(1:end, 2);
N = numel(u);

%% ZADANIE 2.1b
%---- • Zapisaæ model obiektu (18) w postaci regresji liniowej i wyznaczyæ regresor oraz
%----   wektor parametrów zastêpczych modelu dyskretnego.

% Wyznaczenie n realizacji regresji liniowej dla {u_est(n), y_est(n)}
Fi = zeros(N_est, 2);
for i=2 : N_est
    Fi(i, 1:end) = [y_est(i-1) u_est(i-1)];
end

%% ZADANIE 2.1d
%---- • Przyjmuj¹c strukturê modelu ARX przeprowadziæ identyfikacjê parametryczn¹ dla
%----   modelu (18) stosuj¹c wzór (10) oraz zbiór danych estymuj¹cych Zest. Obliczenia
%----   wykonaæ niezale¿nie dla przypadku zak³ócenia szumem bia³ym i kolorowym.

% Identyfikacja parametrów modelu (18) wzorem (10) za pomoc¹ danych Z_est
phatLS = pinv(Fi) * y_est;  

%% ZADANIE 2.1e
%---- • Na podstawie wektora p_LS N wyznaczyæ estymaty k^ oraz T^

% Wyznaczam wartoœæ estymaty k^ oraz T^ przekszta³caj¹c wzór na p2 oraz p1
That = -Tp / log(phatLS(1));
khat = phatLS(2) / (1-exp(-Tp/That));

%% ZADANIE 2.1f
%---- • Zilustrowaæ na wspólnym wykresie (w dziedzinie czasu) odpowiedŸ zmierzon¹ y(n)
%----   ze zbioru Zval oraz odpowiedŸ zidentyfikowanego modelu symulowanego ym(n) na
%----   wymuszenie u(n) wziête z danych weryfikuj¹cych Zval. Oceniæ iloœciowo jakoœæ
%----   identyfikacji obliczaj¹c wskaŸnik: (19)

% Wyznaczam odpowiedŸ predyktora jednokrokowego na podstawie wzoru (18) 
% oraz zidentyfikowanych parametrów phatLS dla danych waliduj¹cych Zval
%----   Wyznaczanie predyktora jednokrokowego dla modelu dyskretnego na
%       podstawie wyznaczonego wzoru (2) z dokumentu .DOCX (yhat) jest lepsze na
%       podstawie otrzymanego wzoru, poniewa¿ mo¿na wówczas zmieniaæ pakiet
%       danych wejœciowych, dla którego wyznaczona jest odpowiedŸ.
%----   Alternatywna metoda wyznaczenia predyktora jednokrokowego - na 
%       podstawie wzoru regresji liniowej ró¿nica wynika z danych dobranych 
%       do wyznaczenia fi_n: 
%       yhat = fi_n * phatLS;     
for i=2 : N_val
    yhat(i) = phatLS(1)*y_val(i-1) + phatLS(2)*u_val(i-1);
end
 
% Wyznaczenie zindentyfikowanego modelu symulowanego ym(n)
%----   Mo¿na równie¿ wykorzystaæ wersjê transmitancyjn¹:
%       Gm = tf([khat], [That 1]);
%       ym = lsim(Gm, u_val, t_val);
ym(1)=0;
for i=2 : N_val
    ym(i) = phatLS(1)*ym(i-1) + phatLS(2)*u_val(i-1);
end

% Wyznaczenie y0 (y bez zak³óceñ) - wersja transmitancyjna
%----   Jest to wykres idealnego modelu, którego nie mo¿na uzyskac w
%       praktyce. Dostêpny jest dla nas tylko dlatego, ¿e prof. udostêpni³
%       dane, które wykorzysta³ do tworzenia zbioru danych (k0, T0).
                                        %----   ALTERNATYWA dla y0 - wersja dyskretna
k0 = 2;                                 % p = [exp(Tp/T0) k0*(1-exp(Tp/T0))];
T0 = 0.5;                               % for i=2 : N
G = tf([k0], [T0 1]);                   % y0(i-1) = p(1)*y(i-1) + p(2)*u(i-1);
y0 = lsim(G, u_val, t_val);             % end

% Wyznaczenie wskaŸnika (19)
E = y_val' - yhat;                      % b³¹d równania
V = (1/N_val) * sum(E.^2);

%% SEKCJA WYKRESÓW
% Wykres odpowiedzi modelu obiektu dynamicznego (y^)
figure(1);
plot(t_val, yhat);

% Wykres odpowiedzi modelu symulowanego (ym)
hold on;
plot(t_val, ym);

% Wykres odpowiedzi na podstawie zmiennych waliduj¹cych Zval (zak³óconych szumem, z konsultacji - y)
hold on;
plot(t_val, y_val);

% Wykres odpowiedzi bez zak³óceñ y0
hold on;
plot(t_val, y0, '--');

% Opis wykresu
grid on;
xlabel('u');
ylabel('y');
title({
    ['PORÓWNANIE ODPOWIEDZI OBIEKTU I MODELU NA WYMUSZENIE {\itu(n)}']
    });
legend('{\ity_{hat}}','{\ity_m}','{\ity}','{\ity_0}');

% Wykres wejœcia i wyjœcia
% figure(2);
% plot(t, y);

%% ZADANIE 2.1e
%---- • Dla przypadku danych z zak³óceniem bia³ym oszacowaæ macierz kowariancji (12)
%----   oraz przedzia³y ufnoœci dla estymat p?LS N (patrz Uwaga 1 na str. 6)

% Wyznaczenie macierzy kowariancji P_N
sigma_hat2 = (1/(N_est-numel(phatLS))) * sum(E.^2);
P_N =  sigma_hat2*inv((Fi'*Fi));
P_N_diag = diag(P_N);

% Wyznaczenie przedzia³ów ufnoœci dla poszczególnych estymat
PU95_p = zeros(numel(phatLS), 2);
for i=1 : numel(phatLS)
    PU95_p(i, 1:end) = [phatLS(i)-1.96*sqrt(P_N_diag(i)/N_est) phatLS(i)+1.96*sqrt(P_N_diag(i)/N_est)];
end