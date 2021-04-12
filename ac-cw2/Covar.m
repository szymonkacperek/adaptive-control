function C=Covar(D,tau)
%%oblicza wartoœæ funkcji kowariancji 'c(tau)' dla sygna³ów zawartych w D i
%%przesuniêcia czasowego równego 'tau'
%%parametry wejœciowe: D - macierz sk³adaj¹ca siê z 2 kolumn (y(n), u(n));
%% tau - ¿¹dana wartoœæ przesuniêcia sygna³ów (liczba próbek przesuniêcia);

Y = D(:,1);
U = D(:,2);

N = size(Y,1);
Yp = zeros(N,1);

MU = (1/N)*sum(U);
MY = (1/N)*sum(Y);

Ud = U;% - MU*ones(N,1);              %odjêcie wartoœci œrednich
Yd = Y;% - MY*ones(N,1);

if (tau>=0)
    Yp(1:(N-tau)) = Yd((1+tau):N);  
else
    Yp((1-tau):N) = Yd(1:(N+tau));  
end

CYU = (1/N)*(Ud'*Yp);                   %uwaga: normalizacja wartoœci¹ 'N'
% CYU = (1/(N-abs(tau)))*(Ud'*Yp);        %uwaga: normalizacja wartoœci¹ 'N-|tau|'

C = CYU;