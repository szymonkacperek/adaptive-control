function z = LESO(f)

global A C L B

% Wzór (8) w ci¹g³ym czasie
u = f(1);
y = f(2);
x1_daszek = f(3);
x2_daszek = f(4);
x3_daszek = f(5);

x_daszek = [x1_daszek; x2_daszek; x3_daszek];

x_daszek_d = (A-L*C)*x_daszek + B.*u + L.*y;

%x_daszek_d = [x_daszek_d(1) x_daszek_d(2) 0];   %%% w celu otwarcia pêli adaptacji (kompensacji) x3_est == 0
                                                %%% pêtla otwarta gdy x3d=0
z = x_daszek_d';