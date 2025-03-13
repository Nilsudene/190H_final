% Function to create a 2nd order interaction term of the XY Hamiltonian
% X and Y are the Pauli Matrices
% l and m are the spins indices; l < m
% n is the total number of qubits
% H_{<ij>}^{(2)} = I_{1} kron I_{2} kron...X_{l}...X_{m}... +
%                  I_{1} kron I_{2} kron...Y_{l}...Y_{m}...

function H_term = H_lm(X, Y, n, l, m)
    I = eye(2);
    
    % initialize H_ij (X_{i}X_{j} and Y_{i}Y_{j}) are seperately
    % calculated)
    H_term_X = 1;
    H_term_Y = 1;

    % iteratively compute the H_{lm}
    for p = 1:n
        if p == l || p == m
            H_term_X = kron(H_term_X, X);
            H_term_Y = kron(H_term_Y, Y);
        else
            H_term_X = kron(H_term_X, I);
            H_term_Y = kron(H_term_Y, I);
        end
    end
    H_term = (H_term_X + H_term_Y)/2;
end
