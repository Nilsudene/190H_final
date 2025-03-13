% Hamiltonian generation for the XY model

% before we begin :)
clear
close all
clc

% System Size
n = 4;

% Adjacency matrix G = [g_{lm}]
G = zeros(n,n);
G = (G+G')/2;
G(logical(eye(n))) = 0;

% The j terms 
W = zeros(1,n);

% function [H, H_norm_shifted, E, E_norm_shifted] = Hxy(G, W) 
    % Defining Pauli Matrices
    Z = [1 0; 0 -1];
    X = [0 1; 1 0];
    Y = [0 -1i; 1i 0];
    
    %%
    % Constructing the Hamiltonian: 
    % 1. Coupling Terms (X_{i}X_{j}+Y_{i}Y{j})
    H = zeros(2^(n),2^(n));
    for l=1:n
        for m=l+1:n
            if G(l,m)~=0
                H = H + G(l,m)*H_lm(X,Y,n,l,m);
            end
        end
    end
    
    
    %%
    % 2. Z terms (\omega_{i}n_{i})
    H_z = zeros(2^n, 2^n);
    for p = 1:n
        if W(p) ~= 0
            H_z = H_z + W(p)*H_k(Z,p,n);
        end
    end
    
    H = H + H_z;
    
    % Find the eigenvalues
    E = eig(H);

    % Shift and rescale H s.t.: E is in [0,1]
    % 1. Shift
    H_shift = H - min(E)*eye(2^n);
    E_shift = E - min(E);
    
    % 2. Rescale
    H_shift_rescale = H_shift/max(E_shift);
    E_shift_rescale = E_shift/max(E_shift);
% end