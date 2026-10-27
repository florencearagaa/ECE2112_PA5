# ECE 2112: Advanced Computer Programming and Algorithms
## Experiment 5: Introduction to MATLAB Programming

---

## 🎯 Objectives

At the end of this laboratory activity, the student should be able to:
1. Create real and complex matrices in MATLAB.
2. Distinguish standard transpose (`.'`) and functional transpose (`transpose()`) from complex-conjugate transpose (`'`) operations.
3. Express a system of simultaneous linear equations in matrix form ($A \mathbf{x} = \mathbf{b}$).
4. Solve and verify linear systems using the Matrix Inverse Method and Cramer's Rule in MATLAB.

---

## 📜 Submission Rules & Requirements

To ensure full credit according to the rubric, adhere strictly to the following rules:

1. **File Naming Convention:** The submission file must be named `Surname_PA5.m` (e.g., `DelaCruz_PA5.m`).
2. **Header Comments:** The top of the script must contain your full name (Surname, First Name M.I.), section, and date submitted.
3. **Sectioning:** Code must be organized into clearly labeled sections using MATLAB section dividers (`%%`).
4. **No Hardcoding:** All outputs must be computed dynamically using MATLAB functions and operators. Do not type computed numbers directly into the output.
5. **Forbidden Operators:** Do **NOT** use MATLAB's left-division operator (`\`) for solving the system in Problem B (as the task specifically tests the Inverse Method and Cramer's Rule).
6. **Execution Integrity:** The script must run sequentially from top to bottom without throwing warnings or errors.

---

## 🔬 Detailed Discussion & Code Breakdown

### Problem A: Transpose Operations

#### Concept Discussion
In MATLAB, matrix transposition behaves differently depending on whether the elements are real or complex numbers:
* **Standard Non-Conjugate Transpose (`.'` and `transpose(A)`):** Swaps rows and columns without altering the sign of the imaginary parts.
* **Complex-Conjugate Transpose (`'`):** Swaps rows and columns **and** negates the imaginary part of every element (computes the complex conjugate $\overline{z} = a - bi$).

#### Code Implementation & Detailed Description

```matlab
%% PROBLEM A: TRANSPOSE OPERATIONS

% 1. Matrix Definitions
% Define real matrix R (3x4) and complex matrix Z (2x3)
R = [ 5 -2  0  7;
      1  3 -4  2;
      6  0  8 -1 ];

Z = [ 2+3i -1+4i 5-2i;
     -3+1i     6 2+5i ];

% 2. Transpose Operations on Real Matrix R
disp('--- REAL MATRIX R OPERATIONS ---');
disp('transpose(R):');
disp(transpose(R));   % Calls MATLAB built-in non-conjugate transpose function

disp('R'':');
disp(R');             % Complex-conjugate transpose operator

disp('R.'':');
disp(R.');            % Array/Non-conjugate transpose operator

% 3. Transpose Operations on Complex Matrix Z
disp('--- COMPLEX MATRIX Z OPERATIONS ---');
disp('transpose(Z):');
disp(transpose(Z));   % Functional non-conjugate transpose

disp('Z'':');
disp(Z');             % Conjugate transpose: swaps rows/cols AND negates imaginary components

disp('Z.'':');
disp(Z.');            % Array transpose: swaps rows/cols WITHOUT conjugating imaginary parts

% -------------------------------------------------------------------------
% ANSWERS TO DISCUSSION QUESTIONS (Included as MATLAB Comments):
% 
% a. Which operations give identical results for the real matrix R?
%    Answer: All three operations (transpose(R), R', and R.') yield identical 
%    results because the imaginary parts of all elements in R are zero.
%
% b. Which two operations give identical results for the complex matrix Z?
%    Answer: transpose(Z) and Z.' yield identical results because both perform
%    an array transpose without taking the complex conjugate.
%
% c. What additional operation is performed by the apostrophe operator (') 
%    when the matrix contains complex entries?
%    Answer: The single apostrophe operator (') calculates the complex conjugate 
%    of each element in addition to swapping the matrix rows and columns.
% -------------------------------------------------------------------------
```

---

### Problem B: Two Methods for a Linear System

#### System Equations & Matrix Representation
The given system of simultaneous linear equations is:

$$\begin{aligned}
2x_1 - x_2 + 3x_3 + 2x_4 &= 16 \\
x_1 + 4x_2 - 2x_3 + x_4 &= -7 \\
3x_1 + 2x_2 + x_3 - x_4 &= 6 \\
-2x_1 + 3x_2 + 4x_3 + 2x_4 &= 7
\end{aligned}$$

In matrix form $A \mathbf{x} = \mathbf{b}$:

$$A = \begin{bmatrix} 2 & -1 & 3 & 2 \\ 1 & 4 & -2 & 1 \\ 3 & 2 & 1 & -1 \\ -2 & 3 & 4 & 2 \end{bmatrix}, \quad \mathbf{b} = \begin{bmatrix} 16 \\ -7 \\ 6 \\ 7 \end{bmatrix}$$

#### Solution Methods

1. **Inverse Method:** Computes solution vector using $\mathbf{x}_{\text{inv}} = A^{-1} \mathbf{b}$ via MATLAB's `inv(A)`.
2. **Cramer's Rule:** Computes each variable $x_j$ by replacing the $j$-th column of matrix $A$ with the vector $\mathbf{b}$ to form matrix $A_j$:

$$x_j = \frac{\det(A_j)}{\det(A)}$$

#### Code Implementation & Detailed Description

```matlab
%% PROBLEM B: TWO METHODS FOR A LINEAR SYSTEM

% 1. Define Coefficient Matrix A and Vector b
A = [  2  -1   3   2;
       1   4  -2   1;
       3   2   1  -1;
      -2   3   4   2 ];

b = [ 16;
      -7;
       6;
       7 ];

% 2. Check Determinant
det_A = det(A);
disp('Determinant of A:');
disp(det_A);

% Rule Check: Matrix must be non-singular (det(A) != 0)
if det_A == 0
    error('Matrix A is singular. Unique solution does not exist.');
end

% 3. Method 1: Matrix Inverse Method
% Formula: x_inv = inv(A) * b
x_inv = inv(A) * b;
disp('Solution via Inverse Method (x_inv):');
disp(x_inv);

% 4. Method 2: Cramer's Rule
% Replace each column of A with vector b and calculate x_j = det(A_j) / det(A)
[n, ~] = size(A);
x_cramer = zeros(n, 1);

for j = 1:n
    A_j = A;           % Create a copy of original matrix A
    A_j(:, j) = b;     % Replace j-th column with right-hand-side vector b
    x_cramer(j) = det(A_j) / det_A; % Calculate variable value
end

disp('Solution via Cramer''s Rule (x_cramer):');
disp(x_cramer);

% 5. Numerical Precision & Verification Checks
disp('--- NUMERICAL CHECKS ---');

% Check 1: Difference between both solution methods
% Should be close to 0 (e.g., < 1e-12) due to floating-point precision
diff_norm = norm(x_inv - x_cramer);
disp('norm(x_inv - x_cramer):');
disp(diff_norm);

% Check 2: Residual check norm(A*x_inv - b)
% Verifies if solution satisfies original equation A*x = b
residual_norm = norm(A * x_inv - b);
disp('norm(A*x_inv - b):');
disp(residual_norm);
```

---

## 📊 Evaluation & Grading Rubric

| Component | Description | Points |
| :--- | :--- | :---: |
| **Transpose Operations** | Correct implementation of `transpose()`, `'`, and `.'` for real and complex matrices, with clear responses to discussion questions in comments. | **35** |
| **Inverse Method** | Correct setup of matrix $A$ and vector $\mathbf{b}$, and accurate computation of solution vector `x_inv`. | **25** |
| **Cramer's Rule & Checks** | Iterative/direct implementation of Cramer's Rule, non-zero determinant verification, and accurate calculation of both norm checks. | **30** |
| **Code Readability** | Clean formatting, adherence to naming conventions, proper section labeling, and informative output displays. | **10** |
| **Total** | | **100** |
```

eof

The generated `README.md` file comprehensively covers all parts of the lab specification, code descriptions, rules, and rubric requirements. Let me know if you need any additional modifications!