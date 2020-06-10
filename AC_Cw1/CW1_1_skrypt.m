%% LABORATORUM SA
% ÆWICZENIE C1 - Analiza sygna³ów deterministycznych i losowych w dziedzinie czasu i czêstotliwoœci
% ZADANIE 1.1

%%
clc;

%% Parametry próbkowania
% fpr = 1000; dt = 1/fp;      % czêstotliwoœæ próbkowania [Hz]; okres próbkowania
% t0 = 0.5;                   % czas obserwacji sygna³u [s]
Tp = 1;                     % okres probkowania
N = 1000;                   % liczba próbek [-]
% t = (0:N-1) * dt          % wektor czasu      

t = NoiseSig(:,1);
e = NoiseSig(:,2);
v = NoiseSig(:,3);

plot(t,e,'k');
xlabel('t');
hold on;
plot(t,v,'b');
legend('t','e');
grid on;

















%load StochasticProcess.mat;
%mean(StochasticProcess,1);
%var(StochasticProcess,1);

%mk = StochasticProcess(:,1);
%mw = StochasticProcess(:,1);

%plot(mk,'or');  % kropki czerwone
%hold on;        % wstrzymaj, zeby polaczyc oba wykresy
%plot(mw,'ob');  % kropki niebieskie
%grid on;
