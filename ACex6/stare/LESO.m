function z = LESO(f)

global A C L B

u = f(1);
y = f(2);
x1_daszek = f(3);
x2_daszek = f(4);
x3_daszek = f(5);

x_daszek = [x1_daszek; x2_daszek; x3_daszek];


x_daszek_d = (A-L*C)*x_daszek + B.*u + L.*y;

z = x_daszek_d';