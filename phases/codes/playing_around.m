% Example from the QSPPACK website

% simulation time
tau = 100;
% set the parameters of the solver
opts.maxiter = 100;
opts.criteria = 1e-12;
% use the real representation to speed up the computation
opts.useReal = true;
% set the solver to fixed-point iteration
opts.method = 'CM';

% Solve for the real coefficients
targ = @(x) 0.5*cos(tau.*x);
parity = 0; % indicating the even parity
% compute the Chebyshev coefficients
d = ceil(1.4*tau+log(1e14));
f = chebfun(targ,d);
coef = chebcoeffs(f);
% discard coefficients of odd orders due to the even parity
coef = coef(parity+1:2:end);

%  Phase factors
[phi_proc,out] = QSP_solver(coef,parity,opts);