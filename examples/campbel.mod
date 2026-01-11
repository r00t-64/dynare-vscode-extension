// ============================================
// MODELO DE CAMPBELL (1994) - SECCIÓN 2
// Oferta laboral fija (L=1 normalizado)
// ============================================

// Variables endógenas (en logaritmos)
var y c k i a;
varexo e;       // shock tecnológico
parameters alpha beta delta rho;

// Calibración de Campbell (1994), Tabla 1
alpha = 0.667;   // participación del capital
beta  = 0.99;    // factor de descuento trimestral
delta = 0.025;   // tasa de depreciación trimestral
rho   = 0.979;   // persistencia del shock tecnológico

// ============================================
// MODELO NO LINEAL
// ============================================
model;
  // (1) Función de producción: Y_t = A_t * K_{t-1}^alpha * L^(1-alpha)
  // Como L=1 fijo: Y_t = A_t * K_{t-1}^alpha
  exp(y) = exp(a) * exp(k(-1))^alpha;

  // (2) Restricción de recursos: Y_t = C_t + I_t
  exp(y) = exp(c) + exp(i);

  // (3) Acumulación de capital: K_t = (1-delta)*K_{t-1} + I_t
  exp(k) = (1-delta) * exp(k(-1)) + exp(i);

  // (4) Ecuación de Euler (consumo)
  // 1/C_t = beta * E_t[1/C_{t+1} * (alpha*A_{t+1}*K_t^(alpha-1) + 1 - delta)]
  (1/exp(c)) = beta * (1/exp(c(+1))) *
               (alpha * exp(a(+1)) * exp(k)^(alpha-1) + 1 - delta);

  // (5) Proceso del shock tecnológico: log A_t = rho * log A_{t-1} + e_t
  a = rho * a(-1) + e;
end;

// ============================================
// ESTADO ESTACIONARIO (ANALÍTICO)
// ============================================
steady_state_model;
  // Shock en SS: a = 0 (log A = 0 => A = 1)
  a = 0;

  // 1. Capital del estado estacionario
  // De la ecuación de Euler: 1 = beta*(alpha*K^(alpha-1) + 1 - delta)
  K_ss = ((alpha) / (1/beta - (1-delta)))^(1/(1-alpha));
  k = log(K_ss);

  // 2. Producción
  Y_ss = K_ss^alpha;  // A=1, L=1
  y = log(Y_ss);

  // 3. Inversión (de ley de movimiento capital en SS: I = delta*K)
  I_ss = delta * K_ss;
  i = log(I_ss);

  // 4. Consumo (de restricción recursos: C = Y - I)
  C_ss = Y_ss - I_ss;
  c = log(C_ss);
end;

// ============================================
// INICIALIZACIÓN Y CÁLCULO
// ============================================
initval;
  k = log( ((alpha)/(1/beta - (1-delta)))^(1/(1-alpha)) );
  a = 0;
  y = alpha * k;
  i = log(delta) + k;
  c = log(exp(y) - exp(i));
end;

resid;
steady;
check;

// ============================================
// SHOCK TECNOLÓGICO
// ============================================
shocks;
  var e = 0.0072^2;  // varianza como en Campbell
end;

// ============================================
// SIMULACIÓN STOCHASTICA
// ============================================
stoch_simul(order = 1, irf = 40, nograph) y c i k a;

// ============================================
// GRÁFICAS PERSONALIZADAS (como Figura 1)
// ============================================
// Nota: Dynare ya genera gráficas, pero podemos hacerlas estilo Campbell
// Las IRFs están en oo_.irfs
