% Function to generate 1st Order Interactions of the XY model
% Z is the Pauli Matrix
% w is the first order interacction strength
% k is the qubit index
% n is the total number of qubits in the system

function H_Z = H_k(Z, k, n)
    I = eye(2); % identity matrix

    % initializing the Z term
    H_Z = 1;
    for q = 1:n
        if q == k
            H_Z = kron(H_Z, Z);
        else
            H_Z = kron(H_Z, I);
        end
    end
end