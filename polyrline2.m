function polyrline2(xo,yo,x,y,rowTodelete)

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

ft = fittype( 'poly2' );
[fitresult, G] = fit( x, y, ft );
rP2 = G.rmse; assignin('base','rP2',rP2); 
pp2 = polyfit(x,y,2); %% y = pp(1)x^2 + pp(2)x + pp(3)
assignin('base','pp2',pp2);
adjP2 = G.adjrsquare; assignin('base','adjP2',adjP2);
vx = -pp2(2)/(2*pp2(1));vy = pp2(1)*vx^2 + pp2(2)*vx + pp2(3);assignin('base','vx',vx);assignin('base','vy',vy);

% xx =min(x):((max(x)-min(x))/1000):max(x);
% yy = fitresult(xx);
% figure;
% plot(fitresult,x,y,'bo');
% line(xx, yy + 3*rP2, 'Color', 'r', 'LineStyle', '--', 'LineWidth', 2);
% line(xx, yy - 3*rP2, 'Color', 'r', 'LineStyle', '--', 'LineWidth', 2); %

ind = y-(fitresult(x)+3*rP2)>0 | y-(fitresult(x)-3*rP2)<0;assignin('base','ind',ind);
if ~isempty(find(ind==1,1))
    rowTodelete = find(ind==1);
    polyrline2(xo,yo,x,y,rowTodelete);
% else %
%     cab last
%     hold on;
%     plot(xo(setdiff(xo,x),:),yo(setdiff(xo,x),:),'r*');
%     legend('Impervious Surface Median Value (year)',['y =' num2str(pp2(1)) '*x^2 + (' num2str(pp2(2)) ')x + ' num2str(pp2(3))],'Upper Bound','Lower Bound','Deleted Points');
%     legend('boxoff');
%     title(['Polynomial Term 2 (RMSE = ' num2str(rP2) ', AdjRsquared ='  num2str(adjP2) ')'],'FontSize',16);
%     ylim([0 inf]);
%     xlim([0 length(xo)]);
%     xlabel('Years');
%     xticks([1 3 5 7 9 11 13 15 17 18])
%     xticklabels({'2000','2002','2004','2006','2008','2010','2012','2014','2016','2017'})
%     ylabel('Impervious Surface Percentage');
%     hold off; %
end


