function [T_order, T] = dynamic_resid_tt(y, x, params, steady_state, T_order, T)
if T_order >= 0
    return
end
T_order = 0;
if size(T, 1) < 4
    T = [T; NaN(4 - size(T, 1), 1)];
end
T(1) = exp(y(10))*exp(y(3))^params(1);
T(2) = params(2)*1/exp(y(12));
T(3) = params(1)*exp(y(15))*exp(y(8))^(params(1)-1);
T(4) = 1+T(3)-params(3);
end
