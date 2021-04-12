%% LABORATORIUM SA
% ÆWICZENIE AcEx4 - Model-Identification Adaptive Control (MIAC)
% Sterownik

%---- • NOTATKI
% 
%%
function [out] = SA_ACex4_ZADANIE3_3_STEROWNIK(input)

% Definicja sygna³ów wejœciowych
w = input(1:3);
yrDot = input(4);
yr = input(5);
e = input(6);

u = w(1)*e + w(2)*yr + w(3)*yrDot;
out = u;
