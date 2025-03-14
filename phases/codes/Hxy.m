% Hamiltonian generation for the XY model

function [H, H_shift_rescale, E, E_shift_rescale] = Hxy(G, W, n, eta) 
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
    % 1. Rescale
    c1 = (pi-2*eta)/(max(E)-min(E));
    % 2. Shift
    c2 = eta - c1*min(E);

    H_shift_rescale = c1*H + c2*eye(n^2);
    E_shift_rescale = eig(H_shift_rescale);
end