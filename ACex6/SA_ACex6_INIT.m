%% LABORATORIUM SA
% ÆWICZENIE AcEx6 - Active/Adaptive Disturbance Rejection Control (ADRC)

% ZADANIE 3.1
clear all; close all; clc
global beta0 betap0 theta6_daszek theta10 theta20
global alfa mi omegac omega0
global l1 l2 l3 L
global A C B
global kp kd
global um
global Ta
%---- • NOTATKI
% 
%% PARAMETRY SYMULACJI
Tend = 20;
Ta = 0.01;

% Sta³e wartoœci
theta6_daszek = 0.425; % [0.05,0.80],
theta10 = -0.018;
theta20 = 0.01;

% Wzmocnienia
kp = omegac^2 + theta10;
kd = 2*omegac + theta20;

% Ograniczenie napiêcia
um = pi;

%% ZADANIA
%% (a)  ZADANIE 3.1b
%---- • Parametry LESO

%       Mi wp³ywa na omega_0 a omega wp³ywa na L. wiêc zmieniamy macierze g³ówne,
%       które s¹ sta³e domyœlnie.
alfa = 2.0; 
mi = 0.2; 
omegac = 2*pi/alfa;     % omegac << omega0
omega0 = omegac/mi;

% Macierz L
l1 = 3*omega0 + theta20;
l2 = 3*omega0^2 + theta10 + l1*theta20;
l3 = omega0^3;
L = [l1; l2; l3];

% Macierz A
A = [0 1 0; theta10 theta20 1; 0 0 0];

% Macierz B
B = [0; theta6_daszek; 0];

% Macierz C
C = [1 0 0];

%% (b)  ZADANIE 3.1c
% ---- • Plant initial conditions

beta0 = 0.4; %[rad]
betap0 = 0; %[rad]







