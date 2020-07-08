function y = controller(f)

global theta10 theta20 kp kd theta6_daszek

beta = f(1);
%beta_d = f(2);
x2_daszek = f(2);
x3_daszek = f(3);
br = f(4);
br_d = f(5);
br_dd = f(6);



u = (br_dd - theta20*br_d - theta10*br + kd*(br_d-x2_daszek) + kp*(br-beta) - x3_daszek)/theta6_daszek; %wzór (24) i (32)
y = u;