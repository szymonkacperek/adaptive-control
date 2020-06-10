%% LABORATORUM SA
% ÆWICZENIE C4 - Rekursywne metody identyfikacji parametrycznej dla systemów SISO/MISO
% ZADANIE 2.1

%---- • MIEJSCE NA NOTATKI
% 
%%
close all; clc;

%% ZADANIE 2.1a - PARAMETRY PRÓBKOWANIA
%---- • Zainicjowaæ nastêpuj¹ce zmienne globalne: Tp=0.1, Tend=1000, Td=1500, które
%----   oznaczaj¹ (w sekundach), odpowiednio, okres próbkowania, horyzont czasowy
%----   symulacji oraz czas, po którym nast¹pi zmiana wartoœci parametru b20 (tutaj
%----   Tend<Td, wiêc zmiana nie nast¹pi wcale – obiekt o sta³ych parametrach).
global Tp
Tend = 1000;
Tp = 0.1;
t = 0 :Tp: Tend;
N = size(t,2);
Td = 300;
c10 = 0;

%% ZADANIE 1.1c
%---- •  Zainicjowaæ jako zmienn¹ globaln¹ wartoœæ parametru c10 = 0 (zak³adamy zak³ó-
%----   canie szumem bia³ym). Przeprowadziæ identyfikacjê parametryczn¹ toru dynamiki
%----   u ? y obiektu (14) metod¹ RLS przyjmuj¹c jako wejœcie pobudzaj¹ce u(n) sygna³
%----   prostok¹tny (symetryczny wzglêdem zera) o amplitudzie jednostkowej i czêstotliwoœci fu = 0.2 Hz. 
%----   Przeanalizowaæ przebiegi estymat p?(n) dla ró¿nych wartoœci parametru ? przy wyborze pocz¹tkowej 
%----   macierzy P (0) (patrz w2). Sprawdziæ wp³yw wartoœci okresu próbkowania na jakoœæ identyfikacji 
%----   – sugerowany zestaw wartoœci (w [s]): Tp e {0.01; 0.1; 0.5; 1.0; 2.0}.
fu = 0.2;
uAmp = 1;

%% ZADANIE 1.1d
%---- •  Zaimplementowaæ blok modelu symulowanego oraz predyktora jednokrokowego korzystaj¹cych 
%----   z aktualnych wartoœci estymat parametrów. Sprawdziæ jakoœæ identyfikacji porównuj¹c odpowiedŸ 
%----   modelu symulowanego ym(n) z odpowiedzi¹ obiektu y(n) oraz z jego odpowiedzi¹ idealn¹ (bez szumu) 
%----   y0(n) na to samo wymuszenie u(n). Porównaæ tak¿e odpowiedŸ predyktora jednokrokowego ? y(n|n ? 1) z 
%----   odpowiedzi¹ y(n) obiektu na wymuszenie u(n).

% zobacz plik ZAD1_ObiektARMAX.slx

% Warunki pocz¹tkowe
%----   Wspó³czynnik ro decyduje jak dynamicznie zmieniaæ siê bêd¹ wartoœci
%       estymaty phatLS. Jeœli wstêpnie wiemy w jakich okolicach mo¿na
%       przyj¹æ phatLS warto zostawiæ ro ma³e, jednak¿e przy zerowej wiedzy
%       a priori warto wybraæ du¿¹ liczbê.

global phatLS_1 PLS_1
phatLS_1 = [0; 0; 0];
roLS = 100;
PLS_1 = roLS * eye(3);

%% ZADANIE 1.1e
%---- •  Sprawdziæ przebieg œladu macierzy P (n) podczas identyfikacji (funkcja trace(P)).
global tracePLS
tracePLS = [];

%% ZADANIE 1.2a
%---- • Zainicjowaæ wartoœæ parametru c10 = 0.7 (zak³adamy zak³ócanie szumem kolorowym). 
%----   Przeprowadziæ identyfikacjê parametryczn¹ toru dynamiki u 7? y obiektu
%----   (14) stosuj¹c metodê RIV ze zmiennymi instrumentalnymi obliczanymi zgodnie z
%----   definicj¹ (12)-(13).

global phatIV_1 PIV_1
phatIV_1 = [0; 0; 0];
roIV = 100;
PIV_1 = roIV * eye(3);

%% ZADANIE 1.2c
%---- • Sprawdziæ przebieg œladu macierzy P (n) podczas identyfikacji (funkcja trace(P)).
global tracePIV
tracePIV = [];

%% ZADANIE 2.1b
%---- • Stosuj¹c metodê RLS? przeprowadziæ identyfikacjê parametryczn¹ toru dynamiki
%----   u ? y obiektu (14) przyjmuj¹c wspó³czynnik zapominania ? z zakresu [0.98; 0.999].
%----   Sprawdziæ wp³yw wartoœci wspó³czynnika ? ? (0, 1) na jakoœæ identyfikacji i fluktuacje 
%----   estymat parametrów. Szczególn¹ uwagê zwróciæ na zdolnoœæ estymatora do œledzenia zmian 
%----   parametru b20 obiektu. Sprawdziæ przebieg œladu macierzy kowariancji P (n) podczas identyfikacji
global lambda 
lambda = 0.98;

%% ZADANIE 2.1c
%---- • Stosuj¹c metodê filtracji Kalmana przeprowadziæ identyfikacjê parametryczn¹ toru
%----   dynamiki u 7? y obiektu (14) z wykorzystaniem aktualizacji (19) przyjmuj¹c
%----   R = diag{0.0001, 0.0001, 0.0001}, a nastêpnie R = diag{0, 0, 0.0001} (w obu przypadkach 
%----   przyj¹æ zastêpczo ?2 := 1). Zwróciæ uwagê na zdolnoœæ estymatora do
%----   œledzenia zmian parametru b20 obiektu oraz na zachowanie pozosta³ych estymat
%----   parametrów modelu dla obu zastosowanych macierzy R. Sprawdziæ wp³yw wartoœci elementów 
%----   diagonali macierzy R na jakoœæ identyfikacji i fluktuacje estymat parametrów.
global sigma2 R
sigma2 = 1;  
R = diag([0; 0; 0.001]);

%% ZADANIE 2.1d
%---- • Przeanalizowaæ jakoœæ identyfikacji adaptacyjnej stosuj¹c metodê resetowania macierzy 
%----   kowariancji P (n) (zastosowaæ kryteria R1 do R3). Sprawdziæ wp³yw warto-
%----   œci parametrów ro_i na jakoœæ identyfikacji i fluktuacje estymat parametrów.
global ro 
ro = 0.05;
resetFreq = 33.0;            % ms               

%% ZADANIE 2.1e
%---- • Sprawdziæ jakoœæ identyfikacji stosuj¹c metodê RIV?, RIV z filtracji Kalmana oraz
%----   RIV z resetowaniem macierzy kowariancji dla przypadku, gdy zak³ócenie bêdzie
%----   szumem kolorowym (w tym celu zainicjowaæ c10 = 0.7).
c10 = 0.7;

%----   Wyniki:
%       idealne(a1, a2, b2) = {0.8; 0.1; 0.3394}
% 
%       R3_LS(a1, a2, b2) = {-0.96; 0.06; 0.29}
%       R3_IV(a1, a2, b2) = {-0.79; -0.1; 0.34}
% 