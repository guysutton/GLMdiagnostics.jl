# Calculate leverage values

N = length(resids_raw)
X = [salamander[!, :mined] ones(N)]                  # design matrix variable values of columns and rows for sections 
W = LinearAlgebra.diagm(0 => m1.model.rr.wrkwt)      # diagonal component weight working 
W2 = real.(sqrt(W))                                  # W2 * W2 = W, the imaginary part becomes zero theoretically 

H =  2 * 5




H = W2 * X * inv(X' * W * X) * X' * W2               # hat matrix 
leverage = diag(W2)                                   # hat diagonal components leverage matrix 

modelmatrix(m1)


