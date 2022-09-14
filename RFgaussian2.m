function RFgaussian2(xo,yo,x,y,rowTodelete)

x(find(isnan(y)==1),:) = [];
y(find(isnan(y)==1),:) = [];

if exist('rowTodelete','var')
    if isempty(rowTodelete)
        rowTodelete = [];
    else
        x(rowTodelete,:)=[]; 
        y(rowTodelete,:)=[];
    end
end

[f, G] = fit( x, y, 'gauss2' );
rG2 = G.rmse; assignin('base','rG2',rG2); 
adjG2 = G.adjrsquare; assignin('base','adjG2',adjG2); 
a1 = f.a1;b1 = f.b1;c1 = f.c1;a2 = f.a2;b2 = f.b2;c2 = f.c2;
assignin('base','a1',a1);assignin('base','b1',b1);assignin('base','c1',c1);
assignin('base','a2',a2);assignin('base','b2',b2);assignin('base','c2',c2);
fgauss = @(x,a1,b1,c1,a2,b2,c2) a1*exp(-((x-b1)./c1).^2) + a2*exp(-((x-b2)./c2).^2);
xx = min(x):((max(x)-min(x))/1000):max(x);
yy = fgauss(xx,a1,b1,c1,a2,b2,c2);assignin('base','yy',yy);


% plot(x,y,'bo',xx,yy,'r-') %
% line(xx, yy + 3*rG2, 'Color', 'r', 'LineStyle', '--', 'LineWidth', 2)
% line(xx, yy - 3*rG2, 'Color', 'r', 'LineStyle', '--', 'LineWidth', 2) %


ind = y-(f(x)+3*rG2)>0 | y-(f(x)-3*rG2)<0; 
if ~isempty(find(ind==1))
    rowTodelete = [find(ind==1)];
    RFgaussian2(xo,yo,x,y,rowTodelete);
% else  %
%     cab last
%     hold on;
%     plot(xo(setdiff(xo,x),:),yo(setdiff(xo,x),:),'r*');
%     legend('Impervious Surface Median Value (year)',['y =' num2str(a1) '*exp(-((x-' num2str(b1) ')/' num2str(c1) '+' num2str(a2) '*exp(-((x-' num2str(b2) ')/' num2str(c2)],'Upper Bound','Lower Bound','Deleted Points');
%     legend('boxoff');
%     title(['Gaussian Curve Term 2 (RMSE = ' num2str(rG2) ', AdjRsquared ='  num2str(adjG2) ')'],'FontSize',16);
%     ylim([0 inf]);
%     xlim([0 length(xo)]);
%     xlabel('Years');
%     xticks([1 3 5 7 9 11 13 15 17 19])
%     xticklabels({'2000','2002','2004','2006','2008','2010','2012','2014','2016','2018'})
%     ylabel('Impervious Surface Percentage');
%     hold off; %
end

