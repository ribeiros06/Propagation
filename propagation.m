close all;
clear;
D = 8e-3; % diameter of the observation aperture [m]
wvl = 1e-6; % optical wavelength [m]
k = 2*pi / wvl; % optical wavenumber [rad/m]
Dz = 1; % propagation distance [m]
arg = D/(wvl*Dz);
delta1 = 1/(10*arg); % source-plane grid spacing [m]
delta2 = D/100; % observation-plane grid spacing [m]
N = 2048; % number of grid points
% source-plane coordinates
[x1 y1] = meshgrid((-N/2 : N/2-1) * delta1);
[theta1 r1] = cart2pol(x1, y1);
A = wvl * Dz; % sets field amplitude to 1 in obs plane
pt = A * exp(-i*k/(2*Dz) * r1.^2) * arg^2 ...
.* sinc(arg*x1) .* sinc(arg*y1).*exp(-(arg/4*r1).^2);
[x2 y2 Uout] = ang_spec_prop(pt, wvl, delta1, delta2, Dz);



% Calculate irradiance (intensity)
Irradiance = abs(Uout).^2;
Irradiance_in = abs(pt).^2;

% Plot the irradiance in the observation plane
figure;
plot(x2(N/2+1,:), Irradiance_in(N/2+1,:));
colormap('hot');
axis square;
xlabel('x (meters)');
ylabel('y (meters)');
title('Irradiance in the Source Plane');
colorbar;

x_range_mm = [-3e-3, 3e-3];
xlim(x_range_mm);

% Plot the irradiance in the observation plane
figure;
imagesc(x2(1,:), y2(:,1), Irradiance);
colormap('hot');
axis square;
xlabel('x (meters)');
ylabel('y (meters)');
title('Irradiance in the Observation Plane');
colorbar;


x_range_mm = [-8e-3, 8e-3];
xlim(x_range_mm);
y_range_mm = [-8e-3, 8e-3];
ylim(y_range_mm);

% Display the analytic result for y2=0 slice
figure;
plot(x2(N/2+1, :), Irradiance(N/2+1, :));
title('Analytic Result for y2=0 Slice');
xlabel('x [mm]');
ylabel('|Uout_an|^2');

x_range_mm = [-8e-3, 8e-3];
xlim(x_range_mm);


% Plot the intensity after propagation
figure;
plot(x2(N/2+1, :), angle(Uout(N/2+1, :)));
title('Analytic Result for y2=0 Slice');
xlabel('x [mm]');
ylabel('Phase');

x_range_mm = [-3e-4, 3e-4];
xlim(x_range_mm);

% Plot the intensity after propagation
figure;
imagesc(angle(Uout));
title('Analytic Result for y2=0 Slice');
xlabel('x [mm]');
ylabel('Phase');
