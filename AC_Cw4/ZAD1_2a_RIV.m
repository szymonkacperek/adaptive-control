%% LABORATORUM SA
% ÆWICZENIE C4 - Rekursywne metody identyfikacji parametrycznej dla systemów SISO/MISO

%---- • MIEJSCE NA NOTATKI
% 19/05 Obliczenia mog¹ nast¹piæ tylko, gdy wektor regresji bêdzie wektorem 
%       pionowym.  
%% ZADANIE 1.1d
%---- • Zaimplementowaæ blok modelu symulowanego oraz predyktora jednokrokowego 
%----   korzystaj¹cych z aktualnych wartoœci estymat parametrów. Sprawdziæ jakoœæ 
%----   identyfikacji porównuj¹c odpowiedŸ modelu symulowanego ym(n) z odpowiedzi¹ obiektu
%----   y(n) oraz z jego odpowiedzi¹ idealn¹ (bez szumu) y0(n) na to samo wymuszenie
%----   u(n). Porównaæ tak¿e odpowiedŸ predyktora jednokrokowego ? y(n|n ? 1) z odpowiedzi¹ y(n) obiektu na wymuszenie u(n).

function output = ZAD1_2a_RIV(input)

% Zmienne globalne
%----   Zainicjowanie tych zmiennych jako globalne w pliku ZAD1_1_skrypt.m
%       skutkuje zachowywaniem ich w pamiêci - nie trzeba liczyæ iteracji.
global PIV_1 phatIV_1 tracePIV 

% Definicja wejœæ
u_2 = input(1);
y = input(2);
y_1 = input(3);
y_2 = input(4);
x_1 = input(5);
x_2 = input(6);

% Wyznaczenie wektora regresji liniowej dla aktualnych wejœæ i wyjœæ
Phi = [-y_1; -y_2; u_2];

% Wyznaczam wektor z
z = [-x_1; -x_2; u_2];

% Wyznaczam wspó³czynnik epsilon:
epsilon = y - (Phi' * phatIV_1);

% Wyznaczam macierz P^{IV}
%----   Domyœlna macierz P nie bêdzie w stanie zareagowaæ na zmianê
%       parametrów modelu. (w naszym przypadku b2 - zmieniany po czasie
%       Td)
PIV = PIV_1 - ((PIV_1 * z * Phi' * PIV_1) / (1 + Phi' * PIV_1 * z));
% Uaktualniam zmienn¹ globaln¹ PIV_1
PIV_1 = PIV;

%% Wyznaczam wspó³czynnik k(n)
k = PIV * z;

% Wyznaczam wektor parametrów estymowanych phatLS
phatIV = phatIV_1 + k*epsilon;

% Uaktualniam phatLS_1
phatIV_1 = phatIV;

output = [phatIV; epsilon];

%% ZADANIE 1.1e
%---- •  Sprawdziæ przebieg œladu macierzy P (n) podczas identyfikacji (funkcja trace(P)).

tracePIV = [tracePIV; trace(PIV)];