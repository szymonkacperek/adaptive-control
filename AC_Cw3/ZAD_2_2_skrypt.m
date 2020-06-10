%% LABORATORUM SA
% ÆWICZENIE C3 - Wsadowe metody identyfikacji parametrycznej
% ZADANIE 2.2

%---- • MIEJSCE NA NOTATKI
% 
%%
close all; clc; clear all

%% Parametry próbkowania
% Dostêpne w pliku PDF.
tend = 100;
Tp = 0.05;
t = 0 :Tp: tend;
N = size(t,2);

%% ZADANIE 2.2a
%---- • Wykorzystuj¹c plik IdentWsadowaDyn.mat oraz dane pomiarowe zapisane 
%----   w macierzy DaneDynC przeprowadziæ identyfikacjê parametryczn¹ dla modelu (18) 
%----   metod¹ IV (zastosowaæ wzór (14)) dla danych ze zbioru Zest. W tym celu utworzyæ
%----   wektor zmiennych instrumentalnych z(n) a nastêpnie macierz Z – do uzyskania
%----   zmiennych instrumentalnych wykorzystaæ metodê wg wzorów (16)-(17).

load IdentWsadowaDyn.mat;

uEst = DaneDynC(1:1000, 1);
yEst = DaneDynC(1:1000, 2);
NEst = numel(uEst);
tEst = t(1:NEst);

uVal = DaneDynC(1001:end, 1);
yVal = DaneDynC(1001:end, 2);
NVal = numel(uVal);
tVal = t(NVal:end);

u = DaneDynC(1:end, 1);
y = DaneDynC(1:end, 2);
N = numel(u);

% Wyznaczenie n realizacji regresji liniowej dla {u_est(n), y_est(n)} (11)
Phi = zeros(NEst, 2);
for i=2 : NEst
    Phi(i,:) = [yEst(i-1) uEst(i-1)];
end

% Wyznaczam wektor parametrów uzyskanych metod¹ LS na podstawie wzoru (10)
phatLS = pinv(Phi) * yEst;

% Wyznaczam wektor x wed³ug równania (16)
%----   W gruncie rzeczy wyznaczenie x jest identyczne jak odpowiedŸ modelu
%       symulowanego ym.
x(1) = 0;
for i=2 : NEst
    x(i) = phatLS(1)*x(i-1) + phatLS(2)*u(i-1);
end

% Wyznaczenie macierzy zmiennych instrumentalnych Z
Z = zeros(NEst, 2);
for i=2 : NEst
    Z(i, 1:end) = [x(i-1) uEst(i-1)];
end

% Wyznaczam wektor parametrów uzyskanych metod¹ IV na podstawie wzoru (14)
phatIV = pinv(Z'*Phi)*Z'*yEst;

%% ZADANIE 2.2b
%---- • Na podstawie oszacowanego wektora p?IV N wyznaczyæ estymaty parametrów k? oraz
%----   T? modelu czasu ci¹g³ego.

% Wyznaczam wartoœæ estymaty k^ oraz T^ przekszta³caj¹c wzór na p2 oraz p1
ThatIV = -Tp / log(phatIV(1));
khatIV = phatIV(2) / (1-exp(-Tp/ThatIV));

%% ZADANIE 2.2c
%---- • Zilustrowaæ na wspólnym wykresie (w dziedzinie czasu) odpowiedŸ zmierzon¹ y(n)
%----   ze zbioru Zval oraz odpowiedŸ zidentyfikowanego modelu symulowanego ym(n)
%----   na wymuszenie u(n) wziête z danych weryfikuj¹cych Zval. Iloœciowo oceniæ jakoœæ
%----   identyfikacji obliczaj¹c wartoœæ wskaŸnika (19) dla p? = p?IV N .

% Wyznaczam odpowiedŸ predyktora jednokrokowego na podstawie wzoru (18) 
% oraz zidentyfikowanych parametrów phatLS dla danych waliduj¹cych Zval
%----   Wyznaczanie predyktora jednokrokowego dla modelu dyskretnego na
%       podstawie wyznaczonego wzoru (2) z dokumentu .DOCX (yhat) jest lepsze na
%       podstawie otrzymanego wzoru, poniewa¿ mo¿na wówczas zmieniaæ pakiet
%       danych wejœciowych, dla którego wyznaczona jest odpowiedŸ.
for i=2 : NVal
    yhatIV(i, :) = phatIV(1)*yVal(i-1) + phatIV(2)*uVal(i-1);
    yhatLS(i, :) = phatLS(1)*yVal(i-1) + phatLS(2)*uVal(i-1);
end

% Wyznaczenie odpowiedzi zindentyfikowanego modelu symulowanego ym(n)
Gm = tf([khatIV], [ThatIV 1]);
ym = lsim(Gm, uVal, tVal);

% Wyznaczenie y0 (y bez zak³óceñ) - wersja transmitancyjna
%----   Jest to wykres idealnego modelu, którego nie mo¿na uzyskac w
%       praktyce. Dostêpny jest dla nas tylko dlatego, ¿e prof. udostêpni³
%       dane, które wykorzysta³ do tworzenia zbioru danych (k0, T0).
                                        %----   ALTERNATYWA dla y0 - wersja dyskretna
k0 = 2;                                 % p = [exp(Tp/T0) k0*(1-exp(Tp/T0))];
T0 = 0.5;                               % for i=2 : N
G = tf([k0], [T0 1]);                   % y0(i-1) = p(1)*y(i-1) + p(2)*u(i-1);
y0 = lsim(G, uVal, tVal);             % end

% Wyznaczenie wskaŸnika (19)
E = yEst' - yhatIV;              % b³¹d równania
V = (1/NEst) * sum(E.^2);   

%% SEKCJA WYKRESÓW
% Wykres odpowiedzi modelu obiektu dynamicznego (y^IV)
figure(1);
plot(tVal, yhatIV);

% Wykres odpowiedzi modelu obiektu dynamicznego (y^LS)
hold on;
plot(tVal, yhatLS);

% Wykres odpowiedzi modelu symulowanego (ym)
hold on;
plot(tVal, ym);

% Wykres odpowiedzi na podstawie zmiennych waliduj¹cych Zval (zak³óconych szumem, z konsultacji - y)
hold on;
plot(tVal, yVal);

% Wykres odpowiedzi bez zak³óceñ y0
hold on;
plot(tVal, y0, '--');

% Opis wykresu
grid on;
xlabel('u');
ylabel('y');
title({
    ['PORÓWNANIE ODPOWIEDZI OBIEKTU I MODELU NA WYMUSZENIE {\itu(n)}']
    });
legend('{\ity_{hatIV}}','{\ity_{hatLS}}','{\ity_m}','{\ity}','{\ity_0}');