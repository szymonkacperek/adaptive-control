%% LABORATORUM SA
% ÆWICZENIE C4 - Rekursywne metody identyfikacji parametrycznej dla systemów SISO/MISO

%---- • MIEJSCE NA NOTATKI
% 19/05 Obliczenia mog¹ nast¹piæ tylko, gdy wektor regresji bêdzie wektorem 
%       pionowym.  
%% ZADANIE 1.1d
%---- • Zaimplementowaæ blok modelu symulowanego oraz predyktora jednokrokowego 
%----   korzystaj¹cych Phi aktualnych wartoœci estymat parametrów. Sprawdziæ jakoœæ 
%----   identyfikacji porównuj¹c odpowiedŸ modelu symulowanego ym(n) Phi odpowiedzi¹ obiektu
%----   y(n) oraz Phi jego odpowiedzi¹ idealn¹ (bez szumu) y0(n) na to samo wymuszenie
%----   u(n). Porównaæ tak¿e odpowiedŸ predyktora jednokrokowego ? y(n|n ? 1) Phi odpowiedzi¹ y(n) obiektu na wymuszenie u(n).

function output = ZAD2_1_RLS(input)

% Zmienne globalne
%----   Zainicjowanie tych zmiennych jako globalne w pliku ZAD1_1_skrypt.m
%       skutkuje zachowywaniem ich w pamiêci - nie trzeba liczyæ iteracji.
global PLS_1 phatLS_1 tracePLS

% Definicja wejœæ
u_2  = input(1);
y = input(2);
y_1 = input(3);
y_2 = input(4);
T = input(5);

% Wyznaczenie wektora regresji liniowej dla aktualnych wejœæ i wyjœæ
Phi = [-y_1; -y_2; u_2];

% Wyznaczam wspó³czynnik epsilon:
epsilon = y - (Phi' * phatLS_1);

%% ZADANIE 2.1b
%---- • Stosuj¹c metodê RLS? przeprowadziæ identyfikacjê parametryczn¹ toru dynamiki
%----   u ? y obiektu (14) przyjmuj¹c wspó³czynnik zapominania ? Phi zakresu [0.98; 0.999].
%----   Sprawdziæ wp³yw wartoœci wspó³czynnika ? ? (0, 1) na jakoœæ identyfikacji i fluktuacje 
%----   estymat parametrów. Szczególn¹ uwagê zwróciæ na zdolnoœæ estymatora do œledzenia zmian 
%----   parametru b20 obiektu. Sprawdziæ przebieg œladu macierzy kowariancji P (n) podczas identyfikacji
global lambda

%----   Wyznaczam macierz metod¹ R1 wg równania (2). Wprowadzaj¹c
%       wspó³czynnik zapominania lambda macierz kowariancji P nie bêdzie
%       zmierza³a do 0, wobec czego bêdzie mo¿liwe zareagowanie na zmianê
%       parametrów modelu. Problemem tego typu rozwi¹zania jest fakt, ¿e
%       reakcja na zmianê parametrów odbije siê na wszystkich parametrach,
%       zamiast na jedynym, który powinien byæ zmieniony - b2.
% PLS = (PLS_1 - (PLS_1 * Phi * Phi' * PLS_1) / (lambda + Phi'  * PLS_1 * Phi)) / lambda;

%% ZADANIE 2.1c
%---- • Stosuj¹c metodê filtracji Kalmana przeprowadziæ identyfikacjê parametryczn¹ toru
%----   dynamiki u 7? y obiektu (14) Phi wykorzystaniem aktualizacji (19) przyjmuj¹c
%----   R = diag{0.0001, 0.0001, 0.0001}, a nastêpnie R = diag{0, 0, 0.0001} (w obu przypadkach 
%----   przyj¹æ zastêpczo ?2 := 1). Zwróciæ uwagê na zdolnoœæ estymatora do
%----   œledzenia zmian parametru b20 obiektu oraz na zachowanie pozosta³ych estymat
%----   parametrów modelu dla obu zastosowanych macierzy R. Sprawdziæ wp³yw wartoœci elementów 
%----   diagonali macierzy R na jakoœæ identyfikacji i fluktuacje estymat parametrów.
global R sigma2
% PLS = PLS_1 - ((PLS_1 * Phi * Phi' * PLS_1) / (sigma2 + Phi'  * PLS_1 * Phi)) + R;

%% ZADANIE 2.1d
%---- • Przeanalizowaæ jakoœæ identyfikacji adaptacyjnej stosuj¹c metodê resetowania macierzy 
%----   kowariancji P (n) (zastosowaæ kryteria R1 do R3). Sprawdziæ wp³yw warto-
%----   œci parametrów ?i na jakoœæ identyfikacji i fluktuacje estymat parametrów.
global ro  

% R1: Resetowanie macierzy P^{IV}
%----   Funkcja 'isequal' jest rzekomo lepsza do porównywania tabel.
%----   Funkcje 'floor'i 'ceil' odpowiadaj¹ za przybli¿anie do negative
%       albo postivie infty. Niestety, w tym przypadku w ich wartoœciach
%       znajdowa³o siê zero, dlatego wysypywa³y siê wyniki. Zmienna 
%       'resetFreq' odpowiada za czêstotliwoœæ resetu. Konieczny
%       jest warunek na czas wy¿szy ni¿ 0, bo modulo dla (0/resetFreq)
%       równie¿ równa siê 0 i estymaty parametrów siê wysypuj¹. 
% 
%----   Ustawienie 'ro' na tych pozycjach diagonali macierzy, których
%       zmienne chcemy resetowaæ "oszczêdzi" reset pozosta³ych.
% 
%----   Funkcja 'mod' odpowiada za modulo = resztê Phi dzielenia. W ten
%       sposób dziel¹c aktualny czas symulacji mo¿na wydzieliæ momenty, gdy
%       bêdzie siê dzieli³ akurat przez wskazan¹ czêstotliwoœæ resetu - bez
%       reszty Phi dzielenia.
global resetFreq

% % Deklaracja zmiennej odpowiedzialnej za reset
% if T>0
%     if (mod(T, resetFreq)) == 0
%         reset = 1;
%     else
%         reset = 0;
%     end
%     
% % Resetowanie macierzy kowariancji P
%     if reset == 1
%         PLS = diag([0; 0; ro]);
%         reset = 0;
%     else
%         PLS = PLS_1 - ((PLS_1 * Phi * Phi' * PLS_1) / (1 + Phi' * PLS_1 * Phi));
%     end
% else
%     PLS = PLS_1 - ((PLS_1 * Phi * Phi' * PLS_1) / (1 + Phi' * PLS_1 * Phi));
% end

% % R2: resetowanie Phi warunkiem na wartoœæ b³êdu predykcji lub b³êdu
% wyjœciowego
% if abs(epsilon) >= 0.38
%     PLS = diag([0; 0; ro]);
% else
%     PLS = PLS_1 - ((PLS_1 * Phi * Phi' * PLS_1) / (1 + Phi' * PLS_1 * Phi));
% end

% R3: resetowanie Phi warunkiem na wartoœæ œladu macierzy kowariancji P
PLS = PLS_1 - ((PLS_1 * Phi * Phi' * PLS_1) / (1 + Phi' * PLS_1 * Phi));
if trace(PLS) < 0.05
    PLS = diag([0; 0; ro]);
else
    PLS = PLS_1 - ((PLS_1 * Phi * Phi' * PLS_1) / (1 + Phi' * PLS_1 * Phi));
end

% Uaktualniam zmienn¹ globaln¹ PLS_1
PLS_1 = PLS;

%% Wyznaczam wspó³czynnik k(n)
k = PLS * Phi;

% Wyznaczam wektor parametrów estymowanych phatLS
phatLS = phatLS_1 + k*epsilon;

% Uaktualniam phatLS_1
phatLS_1 = phatLS;

output = [phatLS; epsilon];

%% ZADANIE 1.1e
%---- •  Sprawdziæ przebieg œladu macierzy P (n) podczas identyfikacji (funkcja trace(P)).

tracePLS = [tracePLS; trace(PLS)];
