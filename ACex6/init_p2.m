%% LABORATORUM SA
% ÆWICZENIE AcEx4 - Model-Identification Adaptive Control (MIAC)

clear all; close all; clc

global beta0 betap0 theta6_daszek theta10 theta20
global alfa mi omegac omega0
global l1 l2 l3 L
global A C B
global kp kd
global um
global Ta

%%% czas symulacji
Tend = 20;
Ta = 0.01;


beta0 = 0.4; %[rad]
betap0 = 0; %[rad]

theta6_daszek = 0.375; % [0.05,0.80],
theta10 = -0.018;
theta20 = 0.01;


alfa = 2.0; % settling time Ts1% of the closed-loop system satis?es Ts1% ? ? for ? > 0 expressed in [s].
mi = 0.1; % (0,1]
omegac = 2*pi/alfa;
omega0 = omegac/mi;

%%% Macierz L
l1 = 3*omega0 + theta20;
l2 = 3*omega0^2 + theta10 + l1*theta20;
l3 = omega0^3;

L = [l1; l2; l3];

%%% Macierz A
A = [0 1 0; theta10 theta20 1; 0 0 0];

%%% Macierz B
B = [0; theta6_daszek; 0];

%%% Macierz C
C = [1 0 0];

%%% wzmocnienia
kp = omegac^2 + theta10;
kd = 2*omegac + theta20;

%%% ograniczenie napiêcia
um = pi;


