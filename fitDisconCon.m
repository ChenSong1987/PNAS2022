function fitSDT=fitDisconCon(PlotX,PlotY1,PlotY2)

% PlotX  is X-axis (correlation coefficient value)
% PlotY1 is Y-axis (histogram of noise)
% PlotY2 is Y-axis (histogram of signal-noise)

dv = [PlotY1'./max(PlotY1) PlotY2'./max(PlotY2)];
Xs = atanh(PlotX');

%figure(22)
%plot(Xs,dv)
%%

uv = 1;

Nmean = sum((Xs.*dv(:,uv)))./sum(dv(:,uv));
Ndev = sqrt(sum(((Xs-Nmean).^2).*dv(:,uv))./sum(dv(:,uv)));
%%
 
opt = optimset('MaxFunEvals',256,'Display','off'); 
 
[bestparamsN,errN] = fminsearch(@(x) fit_gaus(x,Xs,dv(:,1)),[Nmean log(Ndev) 0],opt);

Nmean = bestparamsN(1);
Ndev = exp(bestparamsN(2));
Namp = exp(bestparamsN(3));

gN = Namp*exp(-.5*((Xs - Nmean)./(Ndev)).^2);

%figure(23)
%subplot(1,3,1)
%plot(Xs,dv(:,uv),'-',...
%     Xs,gN,'.')
% axis square
 
inputs{1} = Xs;
inputs{2} = [Nmean Ndev Namp];
[bestparamsS,errS] = fminsearch(@(x) fit_2gaus(x,inputs,dv(:,2)),[.07 log(Ndev) log([.5 .5])],opt);

Smean = bestparamsS(1);
Sdev = exp(bestparamsS(2));
Namp2 = exp(bestparamsS(3));
Samp = exp(bestparamsS(4));

gN2 = Namp2*exp(-.5*((Xs - Nmean)./Ndev).^2);
gS = Samp*exp(-.5*((Xs - Smean)./Sdev).^2);

 
 for x = 1:length(Xs)
     HR(x) = sum(gS(Xs>Xs(x)))/sum(gS);
     
     FA(x) = sum(gN2(Xs>Xs(x)))/sum(gN2);
 end;
  crit = sqrt(HR.^2 + (1-FA).^2);
  
  zHR = norminv(.01+.98*HR);
  zFA = norminv(.01+.98*FA);
  
  crit = zHR - zFA;
  
  fz = find(crit==max(crit));
  
%subplot(1,3,2)
%plot(Xs,[gN2 gS],'-',...
%     Xs,dv(:,2),'r-',...
%     Xs,sum([gN2 gS],2),'k.')
 
% hold on
% scatter(Xs,0*Xs,500*max(crit-1,0)+1,crit,'Filled');colormap(jet);
% plot(Xs(fz)*[1 1],[0 1],'b--')
% hold off
% axis square
% text(Xs(fz),-.1,num2str(PlotX(fz)),'FontSize',12,'Color','b')
fitSDT.PlotN=gN2;     % Noise
fitSDT.PlotA=dv(:,2); % All
fitSDT.PlotS=gS;      % Signal
fitSDT.PlotT=Xs(fz);  % Threshold
 
 %subplot(1,3,3)
 %scatter(zFA,zHR,500*max(crit-1,0)+1,crit,'Filled');colormap(jet)
 %hold on
 %plot([-3 3],[-3 3],'-','Color',.7+[0 0 0])
 %hold off
% axis(3*[-1 1 -1 1])
%axis square
 %%
%xs= linspace(0,.05,64);
 
 %for x = 1:64
 % critN(x,:) = norminv(xs(x)+(1-2*xs(x))*HR) - norminv(xs(x)+(1-2*xs(x))*FA);
 %end;