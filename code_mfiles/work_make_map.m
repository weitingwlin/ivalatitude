
% ax=worldmap([20 50],[-90 -70 ])
%load coastlines
%geoshow(coastlat,coastlon)
work_compile3
%%
    latlim = [25 45];
    lonlim = [-85 -60];
    ax = usamap(latlim, lonlim);
    states = shaperead('usastatelo', 'UseGeoCoords', true);
figure
    geoshow(states ,'LineWidth', 1, 'FaceColor', [0.8 0.8 0.8], 'EdgeColor', [ 0.5 0.5 0.5]); hold on
% h = geoshow(42, -71, 'DisplayType', 'Point', 'Marker', '+', 'Color', 'red');
% sitedata = load('./data/siteinfo2.txt');
    plotm(Tsite.decimallatitude, -1 *Tsite.decimallongitude, ...
             'o',  ...
             'MarkerEdgecolor', mycolor(1), 'MarkerFacecolor', mycolor(12),...
             'MarkerSize', 6)
% plotm(sitedata(:,2), -1*sitedata(:,3), 'o',  'MarkerEdgecolor', mycolor(4), 'linewidth', 2, 'MarkerSize', 6)
 % dms2degrees([70 49 28])
% dms2degrees([71 19 23])
%%