%% LABORATORUM SA
% ÆWICZENIE C4 - Rekursywne metody identyfikacji parametrycznej dla systemów SISO/MISO
% ZADANIE 1.1, 1.2

%---- • MIEJSCE NA NOTATKI
% 
%%
close all; clc;

%% ZADANIE 1.1a
%---- • Plik ObiektARMAX.mdl zawiera blok reprezentuj¹cy obiekt dynamiczny 
%----   zdefiniowany w dyskretnej dziedzinie czasu o strukturze ARX/ARMAX:
%----   (14), gdzie a10, a20, b20 i c10 reprezentuj¹ prawdziwe parametry dynamiki obiektu, a
%----   e(n) jest szumem bia³ym. Zaznaczmy, ¿e (14) nale¿y do rodziny modeli ARMAX
%----   o postaci ogólnej: Ay = Bu + Ce ? y = Gu + He, G = B/A, H = C/A. Je¿eli
%----   przyjmiemy c10 = 0 wówczas otrzymamy szczególn¹ postaæ modelu, a mianowicie
%----   model ARX z szumem bia³ym po prawej stronie. Dla c10 6= 0 szum (1+c10q?1)e(n)
%----   jest ju¿ kolorowy z wszelkimi konsekwencjami tego faktu.

%% ZADANIE 1.1b - PARAMETRY PRÓBKOWANIA
%---- • Zainicjowaæ nastêpuj¹ce zmienne globalne: Tp=0.1, Tend=1000, Td=1500, które
%----   oznaczaj¹ (w sekundach), odpowiednio, okres próbkowania, horyzont czasowy
%----   symulacji oraz czas, po którym nast¹pi zmiana wartoœci parametru b20 (tutaj
%----   Tend<Td, wiêc zmiana nie nast¹pi wcale – obiekt o sta³ych parametrach).
Tend = 1000;
Tp = 0.1;
t = 0 :Tp: Tend;
N = size(t,2);
Td = 1500;

%% ZADANIE 1.1c
%---- •  Zainicjowaæ jako zmienn¹ globaln¹ wartoœæ parametru c10 = 0 (zak³adamy zak³ó-
%----   canie szumem bia³ym). Przeprowadziæ identyfikacjê parametryczn¹ toru dynamiki
%----   u ? y obiektu (14) metod¹ RLS przyjmuj¹c jako wejœcie pobudzaj¹ce u(n) sygna³
%----   prostok¹tny (symetryczny wzglêdem zera) o amplitudzie jednostkowej i czêstotliwoœci fu = 0.2 Hz. 
%----   Przeanalizowaæ przebiegi estymat p?(n) dla ró¿nych wartoœci parametru ? przy wyborze pocz¹tkowej 
%----   macierzy P (0) (patrz w2). Sprawdziæ wp³yw wartoœci okresu próbkowania na jakoœæ identyfikacji 
%----   – sugerowany zestaw wartoœci (w [s]): Tp e {0.01; 0.1; 0.5; 1.0; 2.0}.
global c10 L
c10 = 0;
fu = 0.2;
uAmp = 1;
L = 1;          % wspó³czynnik zapominania

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
global PLS_1 phatLS_1
roLS = 100;
PLS_1 = roLS * eye(3);
phatLS_1 = [0; 0; 0];

%% ZADANIE 1.1e
%---- •  Sprawdziæ przebieg œladu macierzy P (n) podczas identyfikacji (funkcja trace(P)).
global tracePLS
tracePLS = [];

%% ZADANIE 1.2a
%---- • Zainicjowaæ wartoœæ parametru c10 = 0.7 (zak³adamy zak³ócanie szumem kolorowym). 
%----   Przeprowadziæ identyfikacjê parametryczn¹ toru dynamiki u 7? y obiektu
%----   (14) stosuj¹c metodê RIV ze zmiennymi instrumentalnymi obliczanymi zgodnie z
%----   definicj¹ (12)-(13).

global PIV_1 phatIV_1 
c10 = 0.7;
roIV = 100;
PIV_1 = roIV * eye(3);
phatIV_1 = [0; 0; 0];

%% ZADANIE 1.2c
%---- •  Sprawdziæ przebieg œladu macierzy P (n) podczas identyfikacji (funkcja trace(P)).
global tracePIV
tracePIV = [];
