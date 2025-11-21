%% QUESTION 2
% load students.mat
load("C:\Users\BAKOO COMPUTERS\Desktop\GROUP 16 MATLAB\ASSIGNMENT 1\QUESTION 2\Students.mat");
T = struct2table(Student);
%% age statistics
meanAge = mean(T.Age);
medianAge = median(T.Age);
stdAge = std(T.Age);
minAge = min(T.Age);
maxAge = max(T.Age);
disp("Age statistics")
disp(table(meanAge,medianAge,stdAge,minAge,maxAge))

%% Categorical statistics
ReligionCounts = groupsummary(T,"Religion");
disp('Religion Distribution:');
disp(ReligionCounts);

CourseCounts = groupsummary(T,"Course");
disp('Course Distribution:');
disp(CourseCounts);
%% visualisation
%2D bar graph 
figure;
bar(T.Age,'magenta');
title("A bar  graph");
xlabel('Names');
ylabel('Age (years)');
xticklabels(T.Name);
xtickangle(45);
saveas(gcf,'bar2.png');

% 2D line plot
figure;
plot(T.Age,'green');
title('Line plot');
xlabel('courses');ylabel('Age');
xticklabels(T.Course);
xtickangle(60);
saveas(gcf,'line.png');

% 2D pie chart
figure;
pie(Course_count,unique_Courses);
title('A 2D pie chart');
saveas(gcf,'pie.png');

% 2D pie chart with percent
figure;
pie(Religion_count);
title('A 2D pie chart with percent labels')
saveas(gcf,'chart.png');

%% 3D PLOTS
% surface plot
plot(T.Age)
X = 20:1:25;
[X,Y] = meshgrid(X);
Z =X.^2+Y.^2;
surf(X,Y,Z);
xlabel('X');ylabel('Y');zlabel('Z');
title('3D surface plot');
saveas(gcf,'surf.png');

% 3D pie chart
figure;
pie3(course_count,unique_courses);
title('A 3D pie chart');
saveas(gcf,'3dpie.png')

% 3D Bar plot
figure;
bar3(T.Age,'green');
title("A 3D bar  graph");
ylabel('Names');zlabel('Age(years)')
yticklabels(T.Name);
ytickangle(30);
saveas(gcf,'3D bar');

% 3D scatter plot
figure;
X = randn(25,10);
Y = randn(25,10);
Z = randn(25,10);
scatter3(X,Y,Z);
title('3D Scatter Plot');
saveas(gcf,'scatter3.png');
