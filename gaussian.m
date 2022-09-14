function gaussian(xo,yo,x,y,rowTodelete)

x(x(isnan(y)==1),:) = [];
y((isnan(y)==1),:) = [];

if exist('rowTodelete','var')
    if isempty(rowTodelete)
        rowTodelete = [];
    else
        x(rowTodelete,:)=[]; 
        y(rowTodelete,:)=[];
    end
end

[f, G] = fit( x, y, 'gauss1' );
rG = G.rmse; assignin('base','rG',rG); 
a1 = f.a1;b1 = f.b1;c1 = f.c1;
assignin('base','a1',a1);assignin('base','b1',b1);assignin('base','c1',c1);
adjG = G.adjrsquare; assignin('base','adjG',adjG);

% fgauss = @(x,a1,b1,c1) a1*exp(-((x-b1)./c1).^2);
% xx = min(x):((max(x)-min(x))/1000):max(x);
% yy = fgauss(xx,a1,b1,c1);
% figure;
% plot(x,y,'bo',xx,yy,'r-')
% line(xx, yy + 3*rG, 'Color', 'r', 'LineStyle', '--', 'LineWidth', 2)
% line(xx, yy - 3*rG, 'Color', 'r', 'LineStyle', '--', 'LineWidth', 2) %

ind = y-(f(x)+3*rG)>0 | y-(f(x)-3*rG)<0; 
if ~isempty(find(ind==1,1))
    rowTodelete = find(ind==1);
    gaussian(xo,yo,x,y,rowTodelete);
% else
%     cab last
%     hold on;
%     plot(xo(setdiff(xo,x),:),yo(setdiff(xo,x),:),'r*');
%     legend('Impervious Surface Median Value (year)',['y =' num2str(a1) '*exp(-((x-' num2str(b1) ')/' num2str(c1)],'Upper Bound','Lower Bound','Deleted Points');
%     legend('boxoff');
%     title(['Gaussian Curve (RMSE = ' num2str(rG) ', AdjRsquared ='  num2str(adjG) ')'],'FontSize',20);
%     ylim([0 inf]);
%     xlim([0 length(xo)]);
%     xlabel('Years');
%     xticks([1 3 5 7 9 11 13 15 17 18])
%     xticklabels({'2000','2002','2004','2006','2008','2010','2012','2014','2016','2017'})
%     ylabel('Impervious Surface Percentage');
%     hold off; %
end

