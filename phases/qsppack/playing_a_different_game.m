clear
clc
close all

function [phi_proc] = phases(c, sigma)
    tau = 100
    % set the parameters of the solver
    opts.maxiter = 100;
    opts.criteria = 1e-12;
    % use the real representation to speed up the computation
    opts.useReal = true;
    % set the solver to fixed-point iteration
    opts.method = 'Newton';
    
    targ = @(x) c*(sign(abs(x)-sigma)+1)/2;
    parity = 0; % indicating the even parity
    % compute the Chebyshev coefficients
    d = ceil(1.4*tau+log(1e14));
    d = 80;
    f = chebfun(targ,d);
    coef = chebcoeffs(f);
    % discard coefficients of odd orders due to the even parity
    coef = coef(parity+1:2:end);
    
    %% Phases
    [phi_proc,out] = QSP_solver(coef,parity,opts);
    
    %% Plots
    xlist = linspace(0, 1, 1000)';
    targ_value = targ(xlist);
    QSP_value = QSPGetEntry(xlist, phi_proc, out);
    err= norm(QSP_value-targ_value,1)/length(xlist);
    disp('The residual error is');
    disp(err);
    
    % plot the pointwise error
    figure(1)
    
    subplot(2,1,1)
    plot(xlist,QSP_value,'LineWidth',2)
    hold on
    plot(xlist,targ_value,'LineWidth',2)
    legend('$$g(x,\Phi^*)$$','$$f(x)$$','Interpreter','latex','FontSize',14)
    xlabel('$$x$$', 'Interpreter', 'latex','FontSize',14)
    ylabel('$$y(x)$$', 'Interpreter', 'latex','FontSize',14)
    
    subplot(2,1,2)
    plot(xlist,QSP_value-targ_value,'LineWidth',2)
    xlabel('$$x$$', 'Interpreter', 'latex','FontSize',14)
    ylabel('$$g(x,\Phi^*)-f(x)$$', 'Interpreter', 'latex','FontSize',14)
