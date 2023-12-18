% example_square_prop_one_step.m

N = 1024; % number of grid points per side
L = 1e-2; % total size of the grid [m]
delta1 = L / N; % grid spacing [m]
D = 2e-3; % diameter of the aperture [m]
wvl = 1e-6; % optical wavelength [m]
k = 2*pi / wvl;
Dz = 1e3; % propagation distance [m]

[x1 y1] = meshgrid((-N/2 : N/2-1) * delta1);
ap = rect(x1/D) .* rect(y1/D);
[x2 y2 Uout] = one_step_prop(ap, wvl, delta1, Dz);

% analytic result for y2=0 slice
Uout_an = fresnel_prop_square_ap(x2(N/2+1,:), 0, D, wvl, Dz);

% Calculate irradiance (intensity)
Irradiance = abs(Uout).^2;

% Plot the irradiance in the observation plane
figure;
imagesc(x1(1,:), y1(:,1), Irradiance);
colormap('hot');
axis square;
xlabel('x (milimeters)');
ylabel('y (milimeters)');
title('Irradiance in the Observation Plane');
colorbar;

%x_range_mm = [-2, 2];
%y_range_mm = [-2, 2];
%xlim(x_range_mm);
%ylim(y_range_mm);

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

% Plot the intensity after propagation
figure;
imagesc(angle(Uout));
title('Analytic Result for y2=0 Slice');
xlabel('x [mm]');
ylabel('Phase');

x_range_mm = [-3, 3];
xlim(x_range_mm);
