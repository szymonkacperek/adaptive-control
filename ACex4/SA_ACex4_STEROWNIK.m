%% LABORATORIUM SA
% ÆWICZENIE AcEx4 - Model-Identification Adaptive Control (MIAC)
% Sterownik

%---- • NOTATKI
% 
%%
function [out] = SA_ACex4_STEROWNIK(in)

% Definicja sygna³ów wejœciowych
yr = in(1);
yrp = in(2);
e = in(3);
 w = in(1:3);
w1 = w(1);
w2 = w(2);
w3 = w(3);
% w1 = 5;
% w2 = 1;
% w3 = 1;


u = w1*e + w2*yr + w3*yrp;
out = u;
end