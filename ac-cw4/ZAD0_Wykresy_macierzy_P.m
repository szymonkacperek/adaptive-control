%% LABORATORUM SA
% ÆWICZENIE C4 - Rekursywne metody identyfikacji parametrycznej dla systemów SISO/MISO
% ZADANIE 1.1e, 1.2c
% Plik rysuj¹cy wykresy macierzy kowariancji P={LS, IV}
close all; clc
%---- • MIEJSCE NA NOTATKI
% 
%% ZADANIE 1.1e
%---- •  Sprawdziæ przebieg œladu macierzy P (n) podczas identyfikacji (funkcja trace(P)).
figure(1);
plot(t, tracePLS(1:end-1));

%% ZADANIE 1.2c
%---- •  Sprawdziæ przebieg œladu macierzy P (n) podczas identyfikacji (funkcja trace(P)).
hold on;
plot(t, tracePIV(1:end-1),'--');
grid on;
title({
    ['Porównanie macierzy kowariancji {\itP} dla metod {\itRLS} oraz {\itRIV}']
    });
legend('{\itP^{LS}}','{\itP^{IV}}');
