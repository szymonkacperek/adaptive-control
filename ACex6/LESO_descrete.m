function z = LESO_descrete(f)

global A C L B Ta

u_prev = f(1);
y_prev = f(2);
x1_daszek = f(3);
x2_daszek = f(4);
x3_daszek = f(5);

x_daszek_prev = [x1_daszek; x2_daszek; x3_daszek];

% Wzór (16)
x_daszek = (eye(3) + Ta*(A-L*C))*x_daszek_prev + Ta*B*u_prev + Ta*L*y_prev;

z = x_daszek';