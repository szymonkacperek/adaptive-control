function [p_hat, P_LS, epsilon] = RLS(phi, y, p_hat_prev, P_LS_prev)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
global lambda
numerator = P_LS_prev*phi*phi'*P_LS_prev;
denominator = lambda + phi'*P_LS_prev*phi;

P_LS = (P_LS_prev - numerator/denominator)/lambda;

k = P_LS*phi;

epsilon = y - phi'*p_hat_prev;
p_hat = p_hat_prev + k*epsilon;
