
% Maize Yield Estimation Project

clear; clc; 

% 1. Data Generation and Initialization
rng(42); % For reproducible results

% Time vector (growing season: 120 days)
days = 1:120;
num_seasons = 5; % 5 years of data

% Generate synthetic environmental data
temperature = 15 + 15*sin(2*pi*days/120) + 3*randn(1,120);
precipitation = max(0, 20 + 10*randn(1,120)); % mm/day
solar_radiation = 15 + 10*sin(2*pi*days/120) + 2*randn(1,120); % MJ/m²/day
humidity = 60 + 20*randn(1,120); % %

% Soil parameters
soil_moisture = 0.3 + 0.1*randn(1,120); % m³/m³
soil_temperature = 12 + 10*sin(2*pi*days/120) + 2*randn(1,120); % °C
soil_pH = 6.5 + 0.5*randn(1,120);
N_level = 80 + 20*randn(1,120); % kg/ha
P_level = 40 + 10*randn(1,120); % kg/ha
K_level = 100 + 25*randn(1,120); % kg/ha

% Topography
elevation = 200 + 50*randn; % meters
slope = 2 + 1*randn; % degrees
aspect = 180*rand; % degrees

% Maize Growth Model
% Simplified maize growth stages
growth_stages = {'Germination', 'Vegetative', 'Flowering', 'Grain Filling', 'Maturity'};
stage_days = [1, 20, 50, 80, 120];

% Calculate Growing Degree Days (GDD)
T_base = 10; % Base temperature for maize
T_max = 30; % Maximum temperature for growth
GDD = zeros(1,120);
for i = 1:120
    T_avg = (max(temperature(i), T_base) + min(temperature(i), T_max)) / 2;
    GDD(i) = max(0, T_avg - T_base);
end
cumulative_GDD = cumsum(GDD);

% Biomass accumulation model
PAR = solar_radiation * 0.45; % Photosynthetically Active Radiation
RUE = 3.5; % Radiation Use Efficiency (g/MJ)
water_stress_factor = min(1, soil_moisture / 0.4);
temperature_stress_factor = 1 - abs(temperature - 25) / 30;

biomass = zeros(1,120);
for i = 2:120
    stress_factor = water_stress_factor(i) * temperature_stress_factor(i);
    biomass_gain = PAR(i) * RUE * stress_factor * nutrient_factor(N_level(i), P_level(i), K_level(i));
    biomass(i) = biomass(i-1) + biomass_gain;
end

% Yield estimation (Harvest Index approach)
HI = 0.5; % Harvest Index for maize
estimated_yield = biomass(end) * HI; % g/m²
estimated_yield_kg_ha = estimated_yield * 10; % Convert to kg/ha

% 3. Multiple Year Analysis
years = 2019:2023;
yields_kg_ha = zeros(1, num_seasons);
environmental_factors = zeros(num_seasons, 4);

for year = 1:num_seasons
    % Generate yearly variations
    temp_variation = 1 + 0.1*randn;
    rain_variation = 1 + 0.2*randn;
    
    yearly_temperature = temperature * temp_variation;
    yearly_precipitation = precipitation * rain_variation;
    
    % Recalculate biomass with yearly variations
    yearly_biomass = zeros(1,120);
    for i = 2:120
        ws_factor = min(1, soil_moisture(i) / 0.4);
        ts_factor = 1 - abs(yearly_temperature(i) - 25) / 30;
        stress_factor = ws_factor * ts_factor;
        biomass_gain = PAR(i) * RUE * stress_factor * nutrient_factor(N_level(i), P_level(i), K_level(i));
        yearly_biomass(i) = yearly_biomass(i-1) + biomass_gain;
    end
    
    yields_kg_ha(year) = yearly_biomass(end) * HI * 10;
    
    % Store environmental factors
    environmental_factors(year, 1) = mean(yearly_temperature);
    environmental_factors(year, 2) = sum(yearly_precipitation);
    environmental_factors(year, 3) = mean(solar_radiation);
    environmental_factors(year, 4) = mean(N_level);
end

% 4. PLOT 1: Environmental Factors vs Time
figure('Position', [100, 100, 1200, 800]);

subplot(2,2,1);
plot(days, temperature, 'r-', 'LineWidth', 2);
hold on;
plot(days, soil_temperature, 'b-', 'LineWidth', 2);
xlabel('Days After Planting');
ylabel('Temperature (°C)');
title('Air and Soil Temperature Profile');
legend('Air Temperature', 'Soil Temperature', 'Location', 'northwest');
grid on;

% Add growth stage markers
for i = 1:length(stage_days)
    xline(stage_days(i), '--', growth_stages{i}, 'Color', [0.5 0.5 0.5]);
end

subplot(2,2,2);
yyaxis left;
plot(days, precipitation, 'b-', 'LineWidth', 2);
ylabel('Precipitation (mm/day)');
yyaxis right;
plot(days, soil_moisture, 'g-', 'LineWidth', 2);
ylabel('Soil Moisture (m³/m³)');
xlabel('Days After Planting');
title('Precipitation and Soil Moisture');
grid on;

subplot(2,2,3);
plot(days, solar_radiation, 'y-', 'LineWidth', 2);
xlabel('Days After Planting');
ylabel('Solar Radiation (MJ/m²/day)');
title('Solar Radiation During Growing Season');
grid on;

subplot(2,2,4);
plot(days, N_level, 'r-', 'LineWidth', 2);
hold on;
plot(days, P_level, 'g-', 'LineWidth', 2);
plot(days, K_level, 'b-', 'LineWidth', 2);
xlabel('Days After Planting');
ylabel('Nutrient Level (kg/ha)');
title('Soil Nutrient Dynamics');
legend('Nitrogen (N)', 'Phosphorus (P)', 'Potassium (K)');
grid on;

sgtitle('Environmental Factors Affecting Maize Growth');


% Mark growth stages
for i = 1:length(stage_days)
    xline(stage_days(i), '--', growth_stages{i}, 'Color', [0.5 0.5 0.5]);
end

% 6. PLOT 2: Multi-Year Yield Analysis
figure('Position', [100, 100, 1200, 800]);

subplot(2,2,1);
bar(years, yields_kg_ha, 'FaceColor', [0.2 0.6 0.3]);
ylabel('Yield (kg/ha)');
xlabel('Year');
title('Maize Yield Over 5 Years');
grid on;

% Add yield values on bars
for i = 1:length(yields_kg_ha)
    text(years(i), yields_kg_ha(i) + 100, sprintf('%.0f', yields_kg_ha(i)), ...
        'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
end

subplot(2,2,2);
scatter(environmental_factors(:,1), yields_kg_ha, 100, 'filled');
xlabel('Average Temperature (°C)');
ylabel('Yield (kg/ha)');
title('Temperature vs Yield');
grid on;
% Add correlation coefficient
corr_temp = corr(environmental_factors(:,1), yields_kg_ha');
text(0.05, 0.95, sprintf('r = %.3f', corr_temp), 'Units', 'normalized', ...
    'BackgroundColor', 'white');

subplot(2,2,3);
scatter(environmental_factors(:,2), yields_kg_ha, 100, 'filled');
xlabel('Total Precipitation (mm)');
ylabel('Yield (kg/ha)');
title('Precipitation vs Yield');
grid on;
corr_precip = corr(environmental_factors(:,2), yields_kg_ha');
text(0.05, 0.95, sprintf('r = %.3f', corr_precip), 'Units', 'normalized', ...
    'BackgroundColor', 'white');

subplot(2,2,4);
scatter(environmental_factors(:,4), yields_kg_ha, 100, 'filled');
xlabel('Average Nitrogen Level (kg/ha)');
ylabel('Yield (kg/ha)');
title('Nitrogen vs Yield');
grid on;
corr_nitrogen = corr(environmental_factors(:,4), yields_kg_ha');
text(0.05, 0.95, sprintf('r = %.3f', corr_nitrogen), 'Units', 'normalized', ...
    'BackgroundColor', 'white');

sgtitle('Multi-Year Yield Analysis and Environmental Correlations');

% 7. PLOT 3: Yield Prediction Model
figure('Position', [100, 100, 1200, 600]);

% Multiple linear regression for yield prediction
X = [environmental_factors, ones(num_seasons,1)]; % Add intercept
y = yields_kg_ha';
coefficients = X \ y;

predicted_yield = X * coefficients;

subplot(1,2,1);
plot(years, yields_kg_ha, 'o-', 'LineWidth', 3, 'MarkerSize', 10, 'MarkerFaceColor', 'b');
hold on;
plot(years, predicted_yield, 's-', 'LineWidth', 2, 'MarkerSize', 8, 'MarkerFaceColor', 'r');
xlabel('Year');
ylabel('Yield (kg/ha)');
title('Actual vs Predicted Yield');
legend('Actual Yield', 'Predicted Yield', 'Location', 'best');
grid on;

% Calculate model performance
RMSE = sqrt(mean((yields_kg_ha - predicted_yield').^2));
R2 = 1 - sum((yields_kg_ha - predicted_yield').^2) / sum((yields_kg_ha - mean(yields_kg_ha)).^2);

subplot(1,2,2);
scatter(yields_kg_ha, predicted_yield, 100, 'filled');
hold on;
plot([min(yields_kg_ha), max(yields_kg_ha)], [min(yields_kg_ha), max(yields_kg_ha)], 'r--', 'LineWidth', 2);
xlabel('Actual Yield (kg/ha)');
ylabel('Predicted Yield (kg/ha)');
title('Yield Prediction Accuracy');
text(0.05, 0.95, sprintf('R² = %.3f\nRMSE = %.1f kg/ha', R2, RMSE), ...
    'Units', 'normalized', 'BackgroundColor', 'white', 'FontSize', 12);
grid on;

% 8. Results Display
fprintf(' MAIZE YIELD ESTIMATION RESULTS \n');
fprintf('Current Season Estimated Yield: %.0f kg/ha\n', estimated_yield_kg_ha);
fprintf('5-Year Average Yield: %.0f kg/ha\n', mean(yields_kg_ha));
fprintf('5-Year Yield Standard Deviation: %.0f kg/ha\n', std(yields_kg_ha));
fprintf('\nEnvironmental Factor Correlations with Yield:\n');
fprintf('Temperature: r = %.3f\n', corr_temp);
fprintf('Precipitation: r = %.3f\n', corr_precip);
fprintf('Nitrogen: r = %.3f\n', corr_nitrogen);
fprintf('\nPrediction Model Performance:\n');
fprintf('R-squared: %.3f\n', R2);
fprintf('RMSE: %.1f kg/ha\n', RMSE);
fprintf('\nKey Growth Parameters:\n');
fprintf('Final Biomass: %.1f g/m²\n', biomass(end));
fprintf('Cumulative GDD: %.0f °C days\n', cumulative_GDD(end));
fprintf('Harvest Index: %.2f\n', HI);

% Support Function for Nutrient Factor
function nf = nutrient_factor(N, P, K)
    % Calculate nutrient stress factor (0-1)
    N_opt = 100; P_opt = 40; K_opt = 100;
    
    N_factor = min(1, N / N_opt);
    P_factor = min(1, P / P_opt);
    K_factor = min(1, K / K_opt);
    
    nf = (N_factor + P_factor + K_factor) / 3;
end
