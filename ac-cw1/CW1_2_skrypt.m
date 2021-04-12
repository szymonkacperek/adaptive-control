%% LABORATORUM SA
% ÆWICZENIE C1 - Analiza sygna³ów deterministycznych i losowych w dziedzinie czasu i czêstotliwoœci
% ZADANIE 1.2

%%
clear all; close all; clc;

%% Parametry
load StochasticProcess.mat;

t = StochasticProcess(1,:);                 % pierwszy wiersz zawiera chwile czasu dyskretnego

%% ZADANIE 1.2a 
%---- • Wczytaæ zbiór danych z pliku StochasticProcess.mat i wykreœliæ kilka wybranych 
%----   realizacji procesu losowego w funkcji czasu dyskretnego.

% % realizacja_1 = StochasticProcess(2,:);
% figure(1);
% subplot(2,2,1);
% plot(t, StochasticProcess(2,:));
% subplot(2,2,2);
% plot(t, StochasticProcess(3,:));
% subplot(2,2,[3 4]);
% plot(t, StochasticProcess(4,:), 'r', t, StochasticProcess(5,:), 'b');

%% ZADANIE 1.2b 
%---- • Obliczyæ estymaty ? mi oraz ? ?i2 obliczone po realizacjach oraz estymaty ? m oraz ? ?2
%----   obliczone po czasie dla wszystkich dostêpnych realizacji procesu losowego

StochasticProcess([1], :) = [];     % usuniêcie pierwszego wiersza macierzy

estymata_mi = mean(StochasticProcess, 1);
estymata_m = mean(StochasticProcess, 2);


estymata_sig_i = var(StochasticProcess, 0, 1);    
estymata_sig = var(StochasticProcess, 0, 2);

%% ZADANIE 1.2c 
%---- • Przedstawiæ na wspólnym wykresie ? mi i ? m oraz ? ?i2 i ? ?2. Porównaæ i zinterpretowaæ
%----   otrzymane wyniki (nale¿y pamiêtaæ, ¿e estymaty s¹ zmiennymi losowymi).

figure(1);
subplot(211);
plot(estymata_mi', 'or');
hold on;
plot(estymata_m, 'ob')
legend('estymata m_i','estymata m');
title('Porównanie estymat m oraz m_i');
grid on;

subplot(212);
plot(estymata_sig_i, 'ok');
hold on;
plot(estymata_sig, 'om');
legend('estymata \sigma_i','estymata \sigma');
title('Porównanie estymat \sigma_i oraz \sigma');
grid on;