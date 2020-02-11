%Written by AS 1/29/18
ii=size(tracks);
 ii=ii(1,1);
fps=0.1; 
meanspeed_each_track = zeros(ii,1);
C{ii,1}=zeros;
for ti=1:ii
    track1=tracks{ti,1};

trackx1= smooth(track1(:,2).*0.13);
trackx=trackx1(1:end-1);
trackx_next=trackx1(2:end);

tracky1= smooth(track1(:,3).*0.13);
tracky=tracky1(1:end-1);
tracky_next=tracky1(2:end);

d_inst = sqrt((trackx_next-trackx).^2 + (tracky_next-tracky).^2);
t_inst = 1/fps;
t_ii = repmat(t_inst,(length(trackx1)-1),1);
Speed_micron_per_min=(d_inst./t_ii)*60;
%% gauss fit on speed
Speed_micron_per_min=Speed_micron_per_min(Speed_micron_per_min>=1);
 C{ti} = Speed_micron_per_min;
 dmx=1:0.5:20;
 figure
 hist(Speed_micron_per_min,dmx)
F=hist(Speed_micron_per_min,dmx);
[p, q] = fit(dmx',F', 'gauss1');
figure
plot(dmx,F,'r*')
hold on
plot(p,'b')
meanspeed_um_m=p.b1;
close all
meanspeed_each_track(ti,1)=meanspeed_um_m;
end
%% gauss fit on meanspeed of channel tracks

 
 dmx=1:1:20;
 figure
hist(meanspeed_each_track,dmx)
F=hist(meanspeed_each_track,dmx);
[p, q] = fit(dmx',F', 'gauss1');
figure
plot(dmx,F,'r*')
hold on
plot(p,'b')
title('Microbow Single Channel Meanspeed Tracks')
xlabel('Speed (µm/minute)') % x-axis label
ylabel('Frequency') % y-axis label
meanspeed_eachtrack_um_m=p.b1;

