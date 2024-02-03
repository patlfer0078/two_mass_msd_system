% Fernando Patlan, MECE 6341 Modeling of Physical Systems
% Problem 2 MSD System - 2 Mass System
% Force acting directly on Mass 2. Mass 1 is connected
% by a spring and damper system

clc % clear the command code in command window
clear all % clears variables and cache memory

%Set up constants of system
m1=1.2; % mass in kg
m2=0.80;
k1=1000; % spring constant in N/m
k2=2000;
b1=5; % damper viscosity in N/(m/s)
b2=10;
F=200; % force in N

%Set up state of system
A=[ 0 1 0 0;
   -(k1+k2)/m1 -b1/m1 k2/m1 b1/m1;
   0 0 0 1;
   k2/m2 b1/m2 -k2/m2 -(b1+b2)/m2];
B=[0 0 0 1/m2]'; %Transposed B matrix
C=[ 1 0 0 0;
    0 1 0 0;
    0 0 1 0;
    0 0 0 1];
D=[0 0 0 0]'; % D matrix transposed
x0=[0 0 0 0]'; % state vector initial values
tf= 2;  %final time in seconds
t1=[0:0.01:tf];  %time interval in steps of 0.1 seconds
u=F*ones(size(t1)); % Fcos(t1); force wrt time

%Plotting the system
sys1=ss(A,B,C,D);
[y,t,x]=lsim(sys1,u,t1,x0); % y gives outputs

%Acceleration Calculation
%based on calculated fbd diagram equations
accel1 = (k2*(y(:,3)-y(:,1))+b1*(y(:,4)-y(:,2))-k1*y(:,1))/m1;
accel2 = (u-b2*y(:,4)-b1*(y(:,4)-y(:,2))-k2*(y(:,3)-y(:,1)))/m2;

figure(1)
subplot(311) %Position: Mass 1 in Blue, Mass 2 in Red
plot(t, y(:,1), '-b', t, y(:,3), '-r', LineWidth=1.5)
xlabel('Time (Sec)', 'fontsize', 12)
ylabel('Position (m)', 'fontsize', 12)
grid
subplot(312) %Velocity: Mass 1 in Blue, Mass 2 in Red
plot(t, y(:,2), '-b', t, y(:,4), '-r', LineWidth=1.5)
xlabel('Time (Sec)', 'fontsize', 12)
ylabel('Velocity (m/s)', 'fontsize', 12)
grid
subplot(313) %Acceleration: Mass 1 in Blue, Mass 2 in Red
plot(t, accel1, '-b', t, accel2, '-r', LineWidth=1.5)
xlabel('Time (Sec)', 'fontsize', 12)
ylabel('Accel (m/s2)', 'fontsize', 12)
grid