function sim = linearKernel(x1, x2)

x1 = x1(:); x2 = x2(:);

% Compute the kernel
sim = x1' * x2;  % dot product

end