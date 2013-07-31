function price = getAmericanOptionPrice(S0,K,N,sigma,T,r)

% Function Summary
% S0 = Stock Price at Time t=0
% K = Strike Price
% N = Number of Binomial Tree Periods
% Sigma = Volatility
% T = Expiration Period in Years
% r = Continuously Compounded Annual Interest Rate

dt = T/N;
u = exp(sigma * sqrt(dt));
d = 1/u;
q = (exp(r*dt)-d)/(u-d);

Put = zeros(N+1,1);

%str = sprintf('dt = %f: u = %f : d = %f', dt, u, d); disp(str);
%str = sprintf('Risk Neutral Probability q = %f', q); disp(str);

% Calculate Payoffs at the end state
for i=1:N+1
    Si = S0*d^(N-(i-1))*u^(i-1);
    Put(i) = max(0,K-Si);
    %row = sprintf('i = %d, Si = %f, K-Si = %f, max(0,K-Si) = %f',i, Si, K-Si, Put(i)); disp(row);
end

% disp(Put);

for n=N:-1:1
    %result=sprintf('------- n = %d --------------',n) ; disp (result);
    for j=1:n
        %result=sprintf('    ------- j = %d --------------',j) ; disp (result);
        sT = S0*u^(j-1)*d^(n-j);
        exerciseValue = K - sT;
        contValue = exp(-r*dt)*(q*Put(j+1)+(1-q)*Put(j));
        Put(j) = max(exerciseValue, contValue);
        
        %result = sprintf('sT=%f,exerciseValue=%f, contValue=%f, maxValue=%f', sT, exerciseValue, contValue, Put(j)); disp (result);
    end
    %result = sprintf('n = %d', n); disp (result); disp (Put);
end

price = Put (1);
