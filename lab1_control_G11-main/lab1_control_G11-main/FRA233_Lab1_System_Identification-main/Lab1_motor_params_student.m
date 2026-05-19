    %{  
This script for prepare data and parameters for parameter estimator.
1. Load your collected data to MATLAB workspace.
2. Run this script.
3. Follow parameter estimator instruction.
%}

% R and L from experiment
motor_R = 2.280;
motor_L = 0.0012794;
% Optimization's parameters
motor_Eff = 0.5;
motor_Ke = 0.005;
motor_J = 0.1;
motor_B = 0.1;

% Extrcact collected data
Input = data{6}.Values.Data;
Time = data{4}.Values.Time;
Velo = double(data{4}.Values.Data);

% Plot 
Input = squeeze(double(data{6}.Values.Data));
Time  = double(data{4}.Values.Time);
Velo  = squeeze(double(data{4}.Values.Data));

plot(Time, Velo, Time, Input)







%% % Assuming your table is named 'T'
index=1;
Eff = lab1_control.Eff;  % Extracts the 'eff' column as a vector
Jm = lab1_control.Jm;    % Extracts the 'Ke' column
B = lab1_control.B;       % Extracts the 'J' column
Ke = lab1_control.Ke;

% R and L from experiment
motor_R = 3.58;
motor_L = 0.003;
% Optimization's parameters
motor_Eff = Eff(index);
motor_Ke = Ke(index);
motor_J = Jm(index);
motor_B = B(index);

simOut = sim("C:\control\lab1_control_G11\FRA233_Lab1_System_Identification-main\Lab1_parameter_estimation_student.slx");

real_val=data{1}.Values.Data;
model_val=simOut.simout.Data;
y_real = real_val(:);
y_model = model_val(:);

plot(y_model);
ylabel('Angular velocity (rad/s)') % Label for the top plot
hold 'on';
plot(y_real);
xlabel('Time') % Label for the top plot
 lgd = legend('model data', 'real data');
 lgd.Position = [0.8, 0.8, 0.1, 0.05];
 title('model data VS real data')
hold 'off';

%% 2. Calculate Evaluation Metrics
residuals = y_real - y_model;

% Root Mean Squared Error (General accuracy)
SSres = sum(residuals.^2);

% 3. Total Sum of Squares (Difference from the mean of real data)
SStot = sum((y_real - mean(y_real)).^2);

% 4. R-squared Value
R2 = 1 - (SSres / SStot);
rmse = sqrt(mean(residuals.^2));
fprintf('The R-squared value is: %.4f\n', R2);
fprintf('The RMSE value is: %.4f\n', rmse);

myFolder = 'C:\control\lab1_control_G11\New_validation'; % Set your destination
myName = 'sinparam_1.png';                   % Set your filename

% fullfile joins them: 'C:\control\lab1_control_G11\model_VS_realdata\step9'
savePath = fullfile(myFolder, myName);

exportgraphics(gca, savePath);