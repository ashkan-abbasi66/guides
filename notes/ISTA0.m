%% Toy example illustrating ISTA
clear,close all,clc
% size 
  n = 15;
% Matrix A
  A = rand(n);
% ground truth sparse vector x
  % create x
  xt = zeros(n,1);
  % sparsity
  sparsity = 5; % can be changed
  % index of non-zero element
  id = randi(n,sparsity,1);
  val = rand(sparsity,1);
  xt(id) = val;
% vector b
  b = A*xt;
%% Optimization parameters
 % random initialized x
 x0 = rand(n,1);
 x = x0;
 % reuglarization constant
 lambda = 0.1; % can be changed

 % initial objective function value
 obj_val0 = 0.5*norm(A*x-b,2) + lambda*norm(x,1);
 
 % step size of the gradient step
 t = 1/norm(A'*A,'fro');
 % iteration max
 kmax = 1000;
 
%% Main Loop
for k = 1 : kmax
    % gradient step
    y = x - t*(A'*(A*x-b));
    % thresholding
    x = sign(y).*( max( 0, abs(y)- lambda*t ) );
    % compute objective function value
    obj_val(k) = 0.5*norm(A*x-b,2) + lambda*norm(x,1);
end
%% Plotting the result
 % plot error
 subplot(2,3,1:3),semilogy([obj_val0  obj_val]),grid on
 xlim([0 kmax]), ylim([-inf obj_val0])
 title('Objective function value vs iteration','interpreter','latex','fontsize',16)
 xlabel('iteration/$k$','interpreter','latex','fontsize',14)
 
 ymax = max([xt(:)' x(:)' x0(:)']);
 
 subplot(2,3,4),stem(xt),grid on
 title('Ground truth $x_t$','interpreter','latex','fontsize',16)
 xlabel('coordinate/$i$','interpreter','latex','fontsize',14)
 ylim([0 ymax])
 
 subplot(2,3,5),stem(x),grid on
 title('Estimation $x_{k_{max}}$','interpreter','latex','fontsize',16)
 xlabel('coordinate/$i$','interpreter','latex','fontsize',14)
 ylim([0 ymax])
  
 subplot(2,3,6),stem(x0),grid on
 title('Initial guess $x_0$','interpreter','latex','fontsize',16)
 xlabel('coordinate/$i$','interpreter','latex','fontsize',14)
 ylim([0 ymax])