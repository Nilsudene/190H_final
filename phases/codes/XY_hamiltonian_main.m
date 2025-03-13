% before we begin :)
clear
close all
clc

% System Size
n = 4;

% Adjacency matrix G = [g_{lm}]
G = zeros(n,n);
G(1,2) = 1;
G(1,3) = 1;
G(2,4) = 1;
G(3,4) = 1;
G = (G+G');
G(logical(eye(n))) = 0;
% G = zeros(n,n);

% The j terms 
W = ones(1,n);

% Generate the Hamiltonian

% set the value of eta: the eigenvalues should be shifted and rescaled
% s.t. they lie between eta and 1-eta. 
% cos((pi-eta)/2) is the starting point of the function defintion F(x)

eta = 0.01; 
[H, H_shift_rescale, E, E_shift_rescale] = Hxy(G, W, n, eta);

% arccos of the ground state energy and the first excited state
E_unique = sort(unique(E_shift_rescale));
lambda0 = 2*acos(E_unique(1));
lambda1 = 2*acos(E_unique(3));

% corresponding sigma and delta values
delta = E_unique(3)-E_unique(1);
sigma_min = cos((pi-eta)/2);
sigma_max = cos(eta/2);

% figuring out mu
% to ensure cos(sigma_plus) = cos(sigma_minus) = 0.5 
mu = (E_unique(1)+E_unique(3))/2;
sigma_plus = cos((mu-delta/2)/2);
sigma_minus = cos((mu+delta/2)/2);

% define the max value of the function (slighlty less than 1, good for approx.)
c = 0.8;
sigma = (sigma_plus+sigma_minus)/2;
d = 80; % degree of the polynomial 
phases = QETU_phases(c,sigma,d);

save('phases.mat','phases');
writematrix(phases, 'phases.txt')