function [r,p]=corrNaN(x,y,T1,T2)

xUse=x(find(x<10^100&y<10^100));
yUse=y(find(x<10^100&y<10^100));
if length(xUse)==0||length(yUse)==0
    r=NaN; p=NaN;
else
    [r,p]=corr(xUse,yUse,T1,T2);
end