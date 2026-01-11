function [g1, T_order, T] = dynamic_g1(y, x, params, steady_state, sparse_rowval, sparse_colval, sparse_colptr, T_order, T)
if nargin < 9
    T_order = -1;
    T = NaN(4, 1);
end
[T_order, T] = campbel.sparse.dynamic_g1_tt(y, x, params, steady_state, T_order, T);
g1_v = NaN(16, 1);
g1_v(1)=(-(exp(y(10))*exp(y(3))*getPowerDeriv(exp(y(3)),params(1),1)));
g1_v(2)=(-(exp(y(3))*(1-params(3))));
g1_v(3)=(-params(4));
g1_v(4)=exp(y(6));
g1_v(5)=exp(y(6));
g1_v(6)=(-exp(y(7)));
g1_v(7)=(-exp(y(7)))/(exp(y(7))*exp(y(7)));
g1_v(8)=exp(y(8));
g1_v(9)=(-(T(2)*params(1)*exp(y(15))*exp(y(8))*getPowerDeriv(exp(y(8)),params(1)-1,1)));
g1_v(10)=(-exp(y(9)));
g1_v(11)=(-exp(y(9)));
g1_v(12)=(-T(1));
g1_v(13)=1;
g1_v(14)=(-(T(4)*params(2)*(-exp(y(12)))/(exp(y(12))*exp(y(12)))));
g1_v(15)=(-(T(2)*T(3)));
g1_v(16)=(-1);
if ~isoctave && matlab_ver_less_than('9.8')
    sparse_rowval = double(sparse_rowval);
    sparse_colval = double(sparse_colval);
end
g1 = sparse(sparse_rowval, sparse_colval, g1_v, 5, 16);
end
