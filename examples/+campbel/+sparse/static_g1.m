function [g1, T_order, T] = static_g1(y, x, params, sparse_rowval, sparse_colval, sparse_colptr, T_order, T)
if nargin < 8
    T_order = -1;
    T = NaN(4, 1);
end
[T_order, T] = campbel.sparse.static_g1_tt(y, x, params, T_order, T);
g1_v = NaN(12, 1);
g1_v(1)=exp(y(1));
g1_v(2)=exp(y(1));
g1_v(3)=(-exp(y(2)));
g1_v(4)=(-exp(y(2)))/(exp(y(2))*exp(y(2)))-T(4)*params(2)*(-exp(y(2)))/(exp(y(2))*exp(y(2)));
g1_v(5)=(-(exp(y(5))*exp(y(3))*getPowerDeriv(exp(y(3)),params(1),1)));
g1_v(6)=exp(y(3))-exp(y(3))*(1-params(3));
g1_v(7)=(-(T(2)*exp(y(5))*params(1)*exp(y(3))*getPowerDeriv(exp(y(3)),params(1)-1,1)));
g1_v(8)=(-exp(y(4)));
g1_v(9)=(-exp(y(4)));
g1_v(10)=(-T(1));
g1_v(11)=(-(T(2)*T(3)));
g1_v(12)=1-params(4);
if ~isoctave && matlab_ver_less_than('9.8')
    sparse_rowval = double(sparse_rowval);
    sparse_colval = double(sparse_colval);
end
g1 = sparse(sparse_rowval, sparse_colval, g1_v, 5, 5);
end
