%% PROBLEM A: TRANSPOSE OPERATIONS
disp('=================== PROBLEM A: TRANSPOSE OPERATIONS ===================');

% Define the matrices exactly as given
R = [ 5 -2  0  7;
    1  3 -4  2;
    6  0  8 -1];

Z = [ 2+3i  -1+4i   5-2i;
    -3+1i   6      2+5i];

% A replaced by R (real matrix) 
A = R;
disp('A = R:');  disp(A);
disp('transpose(A):');  disp(transpose(A));
disp('A'':');           disp(A');
disp('A.'':');          disp(A.');

% A replaced by Z (complex matrix)
A = Z;
disp('A = Z:');  disp(A);
disp('transpose(A):');  disp(transpose(A));
disp('A'':');           disp(A');
disp('A.'':');          disp(A.');



%% PROBLEM B: LINEAR SYSTEM
disp('=================== PROBLEM B: TWO METHODS FOR A LINEAR SYSTEM ========');

% Coefficient matrix and right-hand-side vector
A = [ 2 -1  3  2;
    1  4 -2  1;
    3  2  1 -1;
    -2  3  4  2];
b = [16; -7; 6; 7];

detA = det(A);
disp('Coefficient matrix A:');     disp(A);
disp('Right-hand-side vector b:'); disp(b);
fprintf('det(A) = %.6f\n\n', detA);


% Method 1: Inverse method 
x_inv = inv(A) * b;
disp('Solution by inverse method (inv(A)):');
disp(x_inv);

% Method 2: Cramer's Rule
n = size(A, 1);
x_cramer = zeros(n, 1);
for k = 1:n
    Ak = A;             % copy of A
    Ak(:, k) = b;       % replace k-th column with b
    x_cramer(k) = det(Ak) / detA;
end
disp('Solution by Cramer''s Rule (x_cramer):');
disp(x_cramer);

% Required numerical checks

fprintf('det(A)                 = %.6f\n', detA);
fprintf('norm(x_inv - x_cramer) = %.4e\n', norm(x_inv - x_cramer));
fprintf('norm(A*x_inv - b)      = %.4e\n', norm(A*x_inv - b));