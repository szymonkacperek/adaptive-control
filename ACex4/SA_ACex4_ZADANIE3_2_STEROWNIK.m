%% LABORATORIUM SA
% ÆWICZENIE AcEx4 - Model-Identification Adaptive Control (MIAC)
% Sterownik

%---- • NOTATKI
% 
%%
function [out] = SA_ACex4_ZADANIE3_2_STEROWNIK(in)

% Definicja sygna³ów wejœciowych
yrDot = in(1);
yr = in(2);
e = in(3);

w = [5 1 1];


u = w(1)*e + w(2)*yr + w(3)*yrDot;
out = u;
end