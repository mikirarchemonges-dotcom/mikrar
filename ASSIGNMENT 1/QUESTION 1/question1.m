clc,clear;
%% QUESTION 1
%STEP 1: read the dataset
data = readtable("C:\Users\BAKOO COMPUTERS\Downloads\sales_data.csv");
%% STEP 2: convert Date column to datetime
data.Date = datetime(data.Date,'InputFormat','dd/MM/uuuu');
%% STEP 3: create a new year column
data.Year = year(data.Date);
%% STEP 4: find unique years in dataset
years = unique(data.Year);
%% STEP 5: loop through each year, create a table and struct
yearlyStruct = struct();
for i = 1:length(years)
    yr = years(i);
    % filter rows for this year
    yearTable = data(data.Year == yr, :);
    %store in a struct
    yearlyStruct.(sprintf('year%d', yr)) = yearTable;
    % write into one excel work book with each year on a seperate sheet
    outputfile = 'yearly_data.xlsx';
   writetable(yearTable, outputfile,'Sheet',sprintf('year_%d',yr));
end
% display confirmation
disp('data successfully split by year')
