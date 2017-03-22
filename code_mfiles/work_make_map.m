
% ax=worldmap([20 50],[-90 -70 ])
%load coastlines
%geoshow(coastlat,coastlon)
clear;clc
work_compile3
%%
    latlim = [25 45];
    lonlim = [-85 -60];
    ax = usamap(latlim, lonlim);
    states = shaperead('usastatelo', 'UseGeoCoords', true);
    geoshow(states ,'LineWidth', 1, 'FaceColor', [0.8 0.8 0.8], 'EdgeColor', [ 0.5 0.5 0.5]); hold on
% h = geoshow(42, -71, 'DisplayType', 'Point', 'Marker', '+', 'Color', 'red');
% sitedata = load('./data/siteinfo2.txt');
    plotm(Tsite.decimallatitude, -1 *Tsite.decimallongitude, ...
             'o',  ...
             'MarkerEdgecolor', mycolor(1), 'MarkerFacecolor', mycolor(1),...
             'MarkerSize', 4)
% plotm(sitedata(:,2), -1*sitedata(:,3), 'o',  'MarkerEdgecolor', mycolor(4), 'linewidth', 2, 'MarkerSize', 6)
 % dms2degrees([70 49 28])
% dms2degrees([71 19 23])
%% add line and text
% rank by latitude so it's easier to control
 [y, I] = sort(Tsite.decimallatitude, 'descend');
 indshift = [1 0 0 -1 -1.5 -0.5 -0.7 -0.5 -1 -2 -0.5 -0.5 -0.5 -0.5 -0.5];
for s =1:15
        site = Tsite.siteID(I(s));
        lat0 = y(s);
        lon0 = -1*Tsite.decimallongitude(I(s));
        lat1 = lat0 + indshift(s); 
        lon1 = lon0+3;
       linem([lat0 lat1], [lon0 lon1],'k');
       textm(lat1, lon1, Tsite.sitename(I(s)));
end
