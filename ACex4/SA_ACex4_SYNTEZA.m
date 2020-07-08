%% LABORATORUM SA
% ÆWICZENIE AcEx4 - Model-Identification Adaptive Control (MIAC)
% Blok syntezy

%---- • NOTATKI
% 

function [w] = SA_ACex4_SYNTEZA(input)
%UNTITLED1 Summary of this function goes here
%   Detailed explanation goes here

global alfa
p = input(1:2);

%w_prev = in(3:5);
epsilon = 0.01;
% if p2*p2 < epsiolon
%     out = w_prev;
% else

% Równanie (13)
w1 = (5*p(1) - alfa)/(p(2) * alfa);
w2 = 1/p(2);
w3 = p(1)/p(2);    

w = [w1; w2; w3];
end




