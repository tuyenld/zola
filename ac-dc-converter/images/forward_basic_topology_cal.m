%% Input
D = 0.46; % Duty cycle
f_sw = 100 * 1e3; % switching freq
V_in = 24; % Input voltage
V_out = 3.3; % Output volage
I_out = 1; % Output current
delta_IL = 10 / 100 * I_out; % 10% of output current

V_d = 0.369; % Voltage drop the Diode - 0.369

%% 1. Calculate the turns ratio
clc;
N_r = (V_out + V_d) / (D * V_in); % 0.36
fprintf("Turns ratio: %f\n", N_r);

%% 2. Calculat V_L
V_L = (V_in * N_r - V_d) - V_out;
fprintf("Output inductor voltage V_L = %f\n", V_L);

%% 3. Caculate output Inductor
delta_t = D/f_sw;
L_out = V_L * delta_t / delta_IL;
fprintf("Output inductor L = %f uH\n", L_out * 1e6);

