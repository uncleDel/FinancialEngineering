% Final Project

% Load the massaged data
D = importdata('SPX-v5.csv', ',');
[num_rows, num_columns] = size(D.data);
disp(num_rows);
disp(num_columns);

% Split the data into parameter Arrays
m_array = D.data(:,1);          % Maturity in # weeks
k_array = D.data(:,2);          % Strike Price
c_array = D.data(:,5);          % Observed Call Option Price (avg of bid and call)
s_array = D.data(:,7);          % Current Price of Security
p_array = D.data(:,10);         % Observed Put Option Price (avg of bid and call)
r_array = D.data(:,12);         % Risk Free Interest Rate for a T-bill with same maturity as option

y = 0.02;                       % Dividend Yield of S&P 500 Index in 2009

v_array = zeros(num_rows, 1);   % Implied Volatility

% Sanity Check By Printing one row of data
% v_array(1) = blsimpv(s_array(1), k_array(1), r_array(1), m_array(1)/52, c_array(1), 10, y);
% val = sprintf('s=%f, k=%f, r=%f, m=%f, c=%f, 10, div_yield=%f', s_array(1), k_array(1), r_array(1), m_array(1)/52, c_array(1), y); disp(val);
% val = sprintf('Implied Volatility v = %f', v_array(1)); disp(val);

for i=1:num_rows;
    % Function Parms: blsimpv(Price, Strike, Rate, Time, Value, Limit, Yield, Tolerance,
    % Class)
    v_array(i) = blsimpv(s_array(i), k_array(i), r_array(i), m_array(i)/52, c_array(i), 10, div_yield);
    val = sprintf('s=%f, k=%f, r=%f, m=%f, c=%f, 10, y=%f, Implied Vol=%f',... 
            s_array(i), k_array(i), r_array(i),m_array(i)/52, c_array(i), y,...
            v_array(i)); 
    disp(val);
        
end;
