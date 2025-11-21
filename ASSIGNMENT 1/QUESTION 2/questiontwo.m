clear;
clc;
% Define the struct
Student = struct('Name',{},'Age',{},'Homedistrict',{},'Course',{},'Tribe',{},'Village',{},'Interest',{}, 'FacialRecognition',{});
% student 1
Student(1).Name = 'SEBYATIKA COLLINE';
Student(1).Age = 25;
Student(1).Homedistrict = 'WAKISO';
Student(1).Course = 'AMI';
Student(1).Religion = 'PENTACOSTAL';
Student(1).Tribe = 'MUGANDA';
Student(1).Village = 'MPOLOGOMA';
Student(1).Interest = 'READING THE BIBLE';
Student(1).FacialRecognition = imread("C:\Users\BAKOO COMPUTERS\Pictures\WhatsApp Image 2025-09-09 at 21.07.09_f3a18aea.jpg");
% student 2
Student(2).Name = 'KABWERU ANDREW';
Student(2).Age = 21;
Student(2).Homedistrict = 'BUGIRI';
Student(2).Religion = 'ANGLICAN';
Student(2).Tribe = 'MUSOGA';
Student(2).Village = 'KAPYANGA';
Student(2).Course = 'WAR';
Student(2).Interest = 'FOOTBALL';
Student(2).FacialRecognition = imread("C:\Users\BAKOO COMPUTERS\Pictures\WhatsApp Image 2025-03-29 at 19.10.16_f817a611f.jpg");
% student 3
Student(3).Name = 'DIKITAL JOHN';
Student(3).Age = 23;
Student(3).Homedistrict = 'PALLISA';
Student(3).Religion = 'CATHOLIC';
Student(3).Tribe = 'ITESOT';
Student(3).Village = 'AGULE';
Student(3).Course = 'WAR';
Student(3).Interest = 'FOOTBALL';
Student(3).FacialRecognition = imread("C:\Users\BAKOO COMPUTERS\Pictures\WhatsApp Image 2025-09-09 at 11.57.25_aa9266c6.jpg");
% student 4
Student(4).Name = 'KIUTU LEONARD';
Student(4).Age = 22;
Student(4).Homedistrict = 'NAMISINDWA';
Student(4).Religion = 'CATHOLIC';
Student(4).Tribe = 'GUSHU';
Student(4).Village = 'SITUMI';
Student(4).Course = 'WAR';
Student(4).Interest = 'RUGBY';
Student(4).FacialRecognition = imread("C:\Users\BAKOO COMPUTERS\Pictures\WhatsApp Image 2025-09-16 at 10.42.31_b554e2d5.jpg");
% student 5
Student(5).Name = 'CHEMONGES MIKRAR';
Student(5).Age = 24;
Student(5).Homedistrict = 'KAPCHORWA';
Student(5).Religion = 'ISLAM';
Student(5).Tribe = 'SABINY';
Student(5).Village = 'KALENJIN';
Student(5).Course = 'WAR';
Student(5).Interest = 'FOOTBALL';
Student(5).FacialRecognition = imread("C:\Users\BAKOO COMPUTERS\Pictures\WhatsApp Image 2025-09-08 at 15.32.26_f8362f19.jpg");
% student 6
Student(6).Name = 'NAGASHA RITTA';
Student(6).Age = 24;
Student(6).Homedistrict = 'NTUNGAMO';
Student(6).Religion = 'CATHOLIC';
Student(6).Tribe = 'MUNYANKOLE';
Student(6).Village = 'MUTANOGA';
Student(6).Course = 'AMI';
Student(6).Interest = 'SWIMMING';
Student(6).FacialRecognition = imread("C:\Users\BAKOO COMPUTERS\Pictures\WhatsApp Image 2025-09-08 at 14.56.18_d3aeca6f.jpg");
% student 7
Student(7).Name = 'SANYU JOY';
Student(7).Age = 22;
Student(7).Homedistrict = 'BUBUDA';
Student(7).Religion = 'BORN AGAIN';
Student(7).Tribe = 'MUGISHU';
Student(7).Village = 'BUDUDA';
Student(7).Course = 'MEB';
Student(7).Interest = 'SWIMMING';
Student(7).FacialRecognition = imread("C:\Users\BAKOO COMPUTERS\Pictures\WhatsApp Image 2025-09-08 at 15.23.23_6d5698f6.jpg");
% student 8
Student(8).Name = 'OULE SADOCK';
Student(8).Age = 22;
Student(8).Homedistrict = 'SOROTI';
Student(8).Course = 'AMI';
Student(8).Religion = 'BORN AGAIN';
Student(8).Tribe = 'ITESOIT';
Student(8).Village = 'PAMBA';
Student(8).Interest = 'WATCHING';
Student(8).FacialRecognition = imread("C:\Users\BAKOO COMPUTERS\Pictures\WhatsApp Image 2025-09-15 at 20.15.33_64960172.jpg");
% student 9
Student(9).Name = 'WANGUSI DAVID';
Student(9).Age = 21;
Student(9).Homedistrict = 'BUSIA';
Student(9).Course = 'MEB';
Student(9).Religion = 'CATHOLIC';
Student(9).Tribe = 'SAMIA';
Student(9).Village = 'NANGWE';
Student(9).Interest = 'FOOTBALL';
Student(9).FacialRecognition = imread("C:\Users\BAKOO COMPUTERS\Pictures\IMG-20250915-WA0073.jpg");
% Student 10
Student(10).Name = 'ATYANG MILDRED';
Student(10).Age = 23; 
Student(10).Homedistrict = 'TORORO'; 
Student(10).Course = 'WAR';
Student(10).Religion = 'PENTECOSTAL';
Student(10).Tribe = 'ITESOIT';
Student(10).Village = 'AKOLODONG A';
Student(10).Interest = 'AEROBICS';
Student(10).FacialRecognition = imread("C:\Users\BAKOO COMPUTERS\Pictures\WhatsApp Image 2025-09-16 at 10.42.31_b554e2d5.jpg");
% Save members into a .mat file for later use
save('Students.mat',"Student");
disp('Group members data stored and saved successfull!');