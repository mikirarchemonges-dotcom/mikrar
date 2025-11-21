%% QUESTION 1
clc,clear;
% Load dataset
data = readtable("C:\Users\BAKOO COMPUTERS\Downloads\sales_data.csv");
data.Date = datetime(data.Date, 'InputFormat', 'dd/MM/uuuu');
data.Year = year(data.Date);

%% 1. Trend of Total Sales per Year
salesPerYear = groupsummary(data, "Year", "sum", "Sales_Amount");
figure;
bar(salesPerYear.Year, salesPerYear.sum_Sales_Amount);
title('Total Sales by Year');
xlabel('Year');
ylabel('Total Sales Amount');
grid on;
saveas(gcf, 'Total_Sales_By_Year.png');

%% 2. Sales by Region
salesPerRegion = groupsummary(data, "Region", "sum", "Sales_Amount");
figure;
bar(categorical(salesPerRegion.Region), salesPerRegion.sum_Sales_Amount);
title('Total Sales by Region');
xlabel('Region');
ylabel('Total Sales Amount');
grid on;
saveas(gcf, 'Total_Sales_By_Region.png');

%% 3. Relationship: Quantity vs Sales
figure;
scatter(data.Quantity_Sold, data.Sales_Amount, 'filled');
title('Relationship between Quantity and Sales Amount');
xlabel('Quantity Sold');
ylabel('Sales Amount');
grid on;
saveas(gcf, 'Quantity_vs_SalesAmount.png');

%% 4. Sales Trend Over Time
figure;
plot(data.Date, data.Sales_Amount, 'b.');
title('Sales Trend Over Time');
xlabel('Date');
ylabel('Sales Amount');
grid on;
saveas(gcf, 'Sales_Trend_Over_Time.png');

salesPerRep = groupsummary(data, "Sales_Rep", "mean", "Sales_Amount");
figure;
bar(categorical(salesPerRep.Sales_Rep), salesPerRep.mean_Sales_Amount);
title('Average Sales per Sales Rep');
xlabel('Sales Representative'); ylabel('Average Sales Amount');
grid on;
saveas(gcf, 'Avg_Sales_By_Rep.png');

%% 6. Sales by Customer Type
salesByCustomer = groupsummary(data, "Customer_Type", "sum", "Sales_Amount");
figure;
pie(salesByCustomer.sum_Sales_Amount, salesByCustomer.Customer_Type);
title('Sales Share by Customer Type');
saveas(gcf, 'Sales_By_CustomerType.png');

%%3D
salesPerRegion = groupsummary(data, "Region", "sum", "Sales_Amount");
figure;
bar3(categorical(salesPerRegion.Region), salesPerRegion.sum_Sales_Amount);
title('Total Sales by Region');
xlabel('Region');
ylabel('Total Sales Amount');
grid on;
saveas(gcf, '3D_Bar_graph.png');
% 3D pie chart
salesByCustomer = groupsummary(data, "Customer_Type", "sum", "Sales_Amount");
figure;
pie3(salesByCustomer.sum_Sales_Amount, salesByCustomer.Customer_Type);
title('Sales Share by Customer Type');
saveas(gcf, '3D_pie_chart.png');

