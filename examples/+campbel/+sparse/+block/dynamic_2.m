function [y, T, residual, g1] = dynamic_2(y, x, params, steady_state, sparse_rowval, sparse_colval, sparse_colptr, T)
residual=NaN(4, 1);
  T(1)=exp(y(6));
  T(2)=exp(y(7));
  T(3)=exp(y(9));
  residual(1)=(T(1))-(T(2)+T(3));
  T(4)=exp(y(10));
  T(5)=exp(y(3));
  residual(2)=(T(1))-(T(4)*T(5)^params(1));
  T(6)=exp(y(8));
  residual(3)=(T(6))-(T(3)+T(5)*(1-params(3)));
  T(7)=exp(y(12));
  T(8)=params(2)*1/T(7);
  T(9)=params(1)*exp(y(15));
  T(10)=1+T(9)*T(6)^(params(1)-1)-params(3);
  residual(4)=(1/T(2))-(T(8)*T(10));
if nargout > 3
    g1_v = NaN(11, 1);
g1_v(1)=(-(T(4)*T(5)*getPowerDeriv(T(5),params(1),1)));
g1_v(2)=(-(T(5)*(1-params(3))));
g1_v(3)=(-T(3));
g1_v(4)=(-T(3));
g1_v(5)=T(1);
g1_v(6)=T(1);
g1_v(7)=T(6);
g1_v(8)=(-(T(8)*T(9)*T(6)*getPowerDeriv(T(6),params(1)-1,1)));
g1_v(9)=(-T(2));
g1_v(10)=(-T(2))/(T(2)*T(2));
g1_v(11)=(-(T(10)*params(2)*(-T(7))/(T(7)*T(7))));
    if ~isoctave && matlab_ver_less_than('9.8')
        sparse_rowval = double(sparse_rowval);
        sparse_colval = double(sparse_colval);
    end
    g1 = sparse(sparse_rowval, sparse_colval, g1_v, 4, 12);
end
end
