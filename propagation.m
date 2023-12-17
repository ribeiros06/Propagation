D = 8e-3; % diameter of the observation aperture [m]
wvl = 1e-6; % optical wavelength [m]
k = 2*pi / wvl; % optical wavenumber [rad/m]
Dz = 1; % propagation distance [m]
arg = D/(wvl*Dz);
delta1 = 1/(10*arg); % source-plane grid spacing [m]
delta2 = D/100; % observation-plane grid spacing [m]
N = 1024; % number of grid points
% source-plane coordinates
[x1 y1] = meshgrid((-N/2 : N/2-1) * delta1);
[theta1 r1] = cart2pol(x1, y1);
A = wvl * Dz; % sets field amplitude to 1 in obs plane
pt = A * exp(-i*k/(2*Dz) * r1.^2) * arg^2 ...
.* sinc(arg*x1) .* sinc(arg*y1);
[x2 y2 Uout] = ang_spec_prop(pt, wvl, delta1, delta2, Dz);



% Calculate irradiance (intensity)
Irradiance = abs(Uout).^2;

% Plot the irradiance in the observation plane
figure;
imagesc(x2(2,:), y2(:,2), Irradiance);
colormap('hot');
axis square;
xlabel('x (meters)');
ylabel('y (meters)');
title('Irradiance in the Observation Plane');
colorbar;

% Display the analytic result for y2=0 slice
figure;
plot(x2(N/2+1, :)*1000, Irradiance(N/2+1, :));
title('Analytic Result for y2=0 Slice');
xlabel('x [mm]');
ylabel('|Uout_an|^2');

x_range_mm = [-3, 3];
xlim(x_range_mm);


% Plot the intensity after propagation
figure;
plot(x2(N, :)*1000, angle(Uout_an));
title('Analytic Result for y2=0 Slice');
xlabel('x [mm]');
ylabel('Phase');