function MaizeYieldPredictor
    % --- Maize Yield Prediction GUI ---
    
    clc; close all;
    fig = uifigure('Name','Maize Yield Prediction System','Position',[200 100 950 600]);

    % --- Title ---
    uilabel(fig,'Text','MAIZE YIELD PREDICTION SYSTEM','FontSize',18,...
        'FontWeight','bold','Position',[250 540 500 40]);

    %% --- INPUT SECTION ---
    inputs = {'Average Temperature (°C)','Total Rainfall (mm)','Solar Radiation (MJ/m²/day)',...
              'Soil Moisture (m³/m³)','Soil pH','Nitrogen (kg/ha)',...
              'Phosphorus (kg/ha)','Potassium (kg/ha)','Elevation (m)','Slope (°)','Aspect (°)'};
    defaults = [25 600 18 0.35 6.5 100 40 100 200 3 180];

    for i = 1:length(inputs)
        uilabel(fig,'Text',inputs{i},'Position',[50 520-(i-1)*40 200 25],'HorizontalAlignment','left');
        uieditfield(fig,'numeric','Value',defaults(i),'Position',[270 520-(i-1)*40 100 25],'Tag',sprintf('input%d',i));
    end

    %% --- Buttons ---
    uibutton(fig,'Text','Predict Yield','FontSize',13,'BackgroundColor',[0.2 0.6 0.3],...
        'Position',[420 90 150 40],'ButtonPushedFcn',@(btn,event)predictYield(fig));

    uibutton(fig,'Text','Clear','FontSize',13,'Position',[600 90 100 40],...
        'ButtonPushedFcn',@(btn,event)clearFields(fig));

    uibutton(fig,'Text','Exit','FontSize',13,'FontColor',[1 0 0],'Position',[720 90 100 40],...
        'ButtonPushedFcn',@(btn,event)close(fig));

    %% --- OUTPUT SECTION ---
    uitable(fig,'Data',cell(6,2),'ColumnName',{'Parameter','Value'},...
        'Tag','outputTable','Position',[450 300 420 220],'ColumnWidth',{180 180});

    uiaxes(fig,'Position',[50 90 350 180],'Tag','ax');

    uitextarea(fig,'Position',[450 150 420 120],'Tag','infoBox',...
        'Value',{'Enter soil & weather parameters, then click Predict Yield.'},...
        'FontSize',12,'Editable','off');
end

%% === PREDICT FUNCTION ===
function predictYield(fig)
    % --- Read input values ---
    for i = 1:11
        val(i) = findobj(fig,'Tag',sprintf('input%d',i)).Value;
    end
    [temp, rain, rad, sm, pH, N, P, K, elev, slope, aspect] = deal(val(1),val(2),val(3),val(4),val(5),val(6),val(7),val(8),val(9),val(10),val(11));

    % --- Calculate yield estimation ---
    % Stress & nutrient factors
    T_opt = 25;
    temp_factor = 1 - abs(temp - T_opt)/30; temp_factor = max(0,min(1,temp_factor));
    water_factor = min(1, sm / 0.4);
    nutrient_factor = mean([min(1,N/100), min(1,P/40), min(1,K/100)]);
    topo_factor = max(0.7, 1 - 0.005*(abs(slope) + abs(aspect-180)/180 + abs(elev-200)/400));

    % Radiation-use efficiency model
    RUE = 3.5;  % g/MJ
    PAR = rad * 0.45 * 120;  % total PAR over 120-day season
    biomass = PAR * RUE * temp_factor * water_factor * nutrient_factor * topo_factor;
    HI = 0.5; % harvest index
    yield_g_m2 = biomass * HI;
    yield_kg_ha = yield_g_m2 * 10;

    % --- Classify performance ---
    if yield_kg_ha < 4000
        status = ' Low Yield Potential';
    elseif yield_kg_ha < 7000
        status = 'Moderate Yield';
    else
        status = ' High Yield Potential';
    end

    % --- Display Results ---
    tbl = findobj(fig,'Tag','outputTable');
    tbl.Data = {
        'Predicted Yield (kg/ha)', round(yield_kg_ha);
        'Temperature Factor', round(temp_factor,2);
        'Water Stress Factor', round(water_factor,2);
        'Nutrient Factor', round(nutrient_factor,2);
        'Topography Factor', round(topo_factor,2);
        'Harvest Index', HI;
        };

    info = findobj(fig,'Tag','infoBox');
    info.Value = {
        ' Yield prediction complete.';
        sprintf('Predicted Yield: %.0f kg/ha', yield_kg_ha);
        sprintf('Classification: %s', status);
        'Yield is estimated using stress-adjusted RUE × HI model.';
        'Adjust soil and weather inputs to test different scenarios.'
        };

    % --- Simple bar plot of factors ---
    ax = findobj(fig,'Tag','ax');
    cla(ax);
    bar(ax, [temp_factor water_factor nutrient_factor topo_factor]);
    ylim(ax,[0 1]);
    ax.XTickLabel = {'Temp','Water','Nutrients','Topo'};
    title(ax,'Stress Factors (0-1)');
end

%% === CLEAR FUNCTION ===
function clearFields(fig)
    for i = 1:11
        findobj(fig,'Tag',sprintf('input%d',i)).Value = 0;
    end
    findobj(fig,'Tag','outputTable').Data = cell(6,2);
    info = findobj(fig,'Tag','infoBox');
    info.Value = {'Cleared. Enter new data to predict yield.'};
    ax = findobj(fig,'Tag','ax'); cla(ax);
end
