function [residual, T_order, T] = static_resid(y, x, params, T_order, T)
if nargin < 5
    T_order = -1;
    T = NaN(4, 1);
end
[T_order, T] = campbel.sparse.static_resid_tt(y, x, params, T_order, T);
residual = NaN(5, 1);
    residual(1) = (exp(y(1))) - (T(1));
    residual(2) = (exp(y(1))) - (exp(y(2))+exp(y(4)));
    residual(3) = (exp(y(3))) - (exp(y(4))+exp(y(3))*(1-params(3)));
    residual(4) = (1/exp(y(2))) - (T(2)*T(4));
    residual(5) = (y(5)) - (y(5)*params(4)+x(1));
end
