close all;
clear all;

tend = 1;
Tp = 0.001;
t = 0:Tp:(tend-Tp);
N = size(t,2);

%definicja analizowanych sygnalow
Ve = 0.25;          %wariancja szumu bialego
e = sqrt(Ve)*randn(1,N);         %Szum bia³y

Gf = tf([0.1], [1 -0.9], Tp);
v = lsim(Gf,e,t);
x = sin(2*pi*5*t);
y = sin(2*pi*5*t) + e;
z = sin(2*pi*5*t) + 0.5*sin(2*pi*10*t) + 0.25*sin(2*pi*30*t);

s = x;      %Wybór sygnalu do analizy

figure(10);
plot(t,s);
grid on;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%analiza Fouriera sygnalu s
Nfft = N;    % Warto sprawdzic tez dla Nfft = 400, Nfft = 800 i Nfft = 126
dO = 2*pi/Nfft;
Omega = 0:dO:(pi-dO);
omega = Omega./Tp;
S = fft(s,Nfft);
AbsS = 2*(abs(S)./Nfft); %mnozymy *2 bo obciazamy widmo do zakresu [0, pi]
ArgS = angle(S);
% % figure (20);
% % plot(omega, AbsS(1:floor(0.5*Nfft)));
% % hold on;
% % stem(omega, AbsS(1:floor(0.5*Nfft)));
% % grid on;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% widmo mocy sygnalu s (periodogram s)
pS = S.*conj(S)./Nfft;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% estymacja z u¿yciem FFT widmowej gêstoœci mocy sygna³u s

% wersja 1 - ksi¹¿kowa

m1 = N/5;
RsmW = Rsn((N-m1):(N+m1));
Nfft = size(RsmW, 2);
RsFFT = fft(RsmW, Nfft);
dO1 = 2*pi/Nfft;
Omega1 = 0:dO1:(pi-dO1);
omega1 = Omega1./Tp;
AbsRsFFT = abs(RsFFT);
figure(30);
stem(omega1, AbsRsFFT(1:floor(0.5*Nfft), 'm');
grid on;

                    