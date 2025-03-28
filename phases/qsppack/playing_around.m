close all
clear
clc

%%
delta = 0.01;
opts.intervals=[delta,1];
opts.objnorm = Inf;
opts.epsil = 0.1;
opts.npts = 500;
opts.isplot= true;
opts.fscale = 1; % disable further rescaling of f(x)

targ = @(x) 0.8*(sign(abs(x)-0.8)+1)/2;
parity = 0; % agrees with parity

% QETU-based parameters
deg = 173;
coef_full=cvx_poly_coef(targ, deg, opts);
% The solver outputs all Chebyshev coefficients while we have to post-select 
% those of odd order due to the parity constraint.
coef = coef_full(1+parity:2:end);

opts.maxiter = 100;
opts.criteria = 1e-12;
opts.useReal = false;
opts.targetPre = true;
opts.method = 'Newton';

[phi_proc,out] = QSP_solver(coef,parity,opts);

%% Errors
xlist1 = linspace(-1,-delta,500)';
xlist2 = linspace(delta,1,500)';
xlist = cat(1, xlist1,xlist2);
func = @(x) ChebyCoef2Func(x, coef, parity, true);
targ_value = targ(xlist);
func_value = func(xlist);
QSP_value = QSPGetEntry(xlist, phi_proc, out);
err= norm(QSP_value-func_value, 2);
disp('The residual error is');


disp(err);
figure()
plot(xlist,QSP_value-func_value)
% figure(5)
% plot(xlist,QSP_value)
xlabel('$$x$$', 'Interpreter', 'latex')
ylabel('$$g(x,\Phi^*)-f_\mathrm{poly}(x)$$', 'Interpreter', 'latex')
print(gcf,'singular_vector_transformation_error.png','-dpng','-r500');