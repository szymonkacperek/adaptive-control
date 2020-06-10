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

function output = ZAD1_1d_RLS(input)

% Zmienne globalne
%----   Zainicjowanie tych zmiennych jako globalne w pliku ZAD1_1_skrypt.m
%       skutkuje zachowywaniem ich w pamiêci - nie trzeba liczyæ iteracji.
global PLS_1 phatLS_1 tracePLS

% Definicja wejœæ
u_2  = input(1);
y = input(2);
y_1 = input(3);
y_2 = input(4);

% Wyznaczenie wektora regresji liniowej dla aktualnych wejœæ i wyjœæ
Phi = [-y_1; -y_2; u_2];

% Wyznaczam wspó³czynnik epsilon:
epsilon = y - (Phi' * phatLS_1);

% Wyznaczam macierz P^{LS}
%----   Domyœlna macierz P nie bêdzie w stanie zareagowaæ na zmianê
%       parametrów modelu. (w naszym przypadku b2 - zmieniany po czasie
%       Td)
PLS = PLS_1 - ((PLS_1 * Phi * Phi' * PLS_1) / (1 + Phi' * PLS_1 * Phi));
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

