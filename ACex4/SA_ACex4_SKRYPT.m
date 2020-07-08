%% LABORATORIUM SA
% ÆWICZENIE AcEx4 - Model-Identification Adaptive Control (MIAC)

% ZADANIE 3.1
clear all; close all; clc

%---- • NOTATKI
% 
%% 1    PARAMETRY
%  1.1  RSG
Yr = 0.15;           % amplituda [rad/s]
omega_r = 0.25;     % pulsacja [rad/s]

%  1.2  WARUNKI SYMULACJI
global Ta Tc sigma2e TF p_hat P lambda alfa
% Sampling interval of the adaptation loop Ta
Ta = 0.005;

% Sampling interval of conventional loop Tc
Tc = 0.001;

% Variance of stochastic noise sigma2e
sigma2e = 0.0;

% Sta³a czasowa u¿yta dla filtrów SVF (bloki Transfer Fcn)
TF = 1.5*Ta;

%  1.3   BLOK RLS
p_hat = [1; 1];
alfa = 3;
lambda = 0.999;
P = 0.1*eye(2);

%% 2    ZADANIA
%% (a)  ZADANIE 3.1c
%---- • On the scheme in file AeroPlantMIAC.mdl implement the RLS identification block
%       for the plant dynamics applying the SVF method to filter the appropriate signals.
%       Use the Zero-Order Hold blocks to sample all the signals needed for identification
%       purposes. Choose a value of time-constant TF used in the SVF filters to obtain
%       an acceptable quality of identification – start using TF = 1.5Ta. Implement the
%       synthesis block using equation (13). Ensure that all the blocks of the adaptive loop
%       are synchronized with the same sampling time Ta >= Tc.

% zob. ./SA_ACex4_SYNTEZA.m

%% (b)  ZADANIE 3.1b
%---- • Initialize the following global variables: Ta=0.05 s, Tc=0.001 s, sigma2e=0.0, which
%       represent, respectively, the sampling interval of the adaptation loop, the sampling
%       interval of the conventional control loop, and the variance of a stochastic noise
%       disturbing the plant.
