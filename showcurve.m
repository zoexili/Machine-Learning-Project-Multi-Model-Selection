function showcurve(F,RMSE,adjRsquared,C,CC,xcoord,ycoord,index)

param = F{index};
if size(param,2) == 4 % class 1,2
    fplot(@(x) param(1)+(param(2)-param(1))./(1+10.^((param(3)-x)*param(4))),[0 19],'Color',[79/255,193/255,233/255],'LineWidth',3);
    hold on;
    scatter(cell2mat(xcoord(index)),cell2mat(ycoord(index)),100,[240/255,2/255,127/255],'o','filled');
    title('Decrease (Logistic)');
    % lgd = legend(['Y = ' num2str(param(1)) ' + (' num2str(param(2)) '-' num2str(param(1)) ') / (1+10^{(' num2str(param(3)) '-x)*' num2str(param(4)) '})']);
    lgd = legend(['RMSE = ' num2str((round(RMSE(index),4))*100) '%'],['Adjusted R^{2} = '  num2str((round(adjRsquared(index),2)))]);
    lgd.FontSize = 16;
    legend('boxoff');
    xlabel('Years','FontWeight','bold');
    ylabel('Impervious Surface Percentage','FontWeight','bold');
    xlim([0 19])
    xticks([1 3 5 7 9 11 13 15 17 19])
    xticklabels({'2000','2002','2004','2006','2008','2010','2012','2014','2016','2018'})
    ylim([0 1])
    yticklabels({'0%','10%','20%','30%','40%','50%','60%','70%','80%','90%','100%'});
    ax = gca;
    ax.FontSize = 16;
elseif C(index) == 3 || CC(index) == 4.1 || CC(index) == 5.1 || CC(index) == 6.1 || CC(index) == 7.1
    fplot(@(x) param(1)*exp(-((x-param(2))./param(3)).^2),[0 19],'Color',[79/255,193/255,233/255],'LineWidth',3); % gaussian
    hold on;
    scatter(cell2mat(xcoord(index)),cell2mat(ycoord(index)),100,[240/255,2/255,127/255],'o','filled');
    title('4.1');
    %lgd = legend(['Y = ' num2str(param(1)) ' * exp(-((x-' num2str(param(2)) ') / ' num2str(param(3)) ')^2)']);
    lgd = legend(['RMSE = ' num2str((round(RMSE(index),4))*100) '%'],['Adjusted R^{2} = '  num2str((round(adjRsquared(index),2)))]);
    lgd.FontSize = 16;
    legend('boxoff');
    xlabel('Years','FontWeight','bold');
    ylabel('Impervious Surface Percentage','FontWeight','bold');
    xlim([0 19])
    xticks([1 3 5 7 9 11 13 15 17 19])
    xticklabels({'2000','2002','2004','2006','2008','2010','2012','2014','2016','2018'})
    ylim([0 1])
    yticklabels({'0%','10%','20%','30%','40%','50%','60%','70%','80%','90%','100%'});
    ax = gca;
    ax.FontSize = 16;    
elseif CC(index) == 4.2 || CC(index) == 5.2 || CC(index) == 6.2 || CC(index) == 7.2
    fplot(@(x) param(1)*x.^2 + param(2)*x + param(3),[0 19],'Color',[79/255,193/255,233/255],'LineWidth',3); % polynomial 2nd
    hold on;
    scatter(cell2mat(xcoord(index)),cell2mat(ycoord(index)),100,[240/255,2/255,127/255],'o','filled');
    title('');
    %lgd = legend(['Y = ' num2str(param(1)) '*x^2 + (' num2str(param(2)) ')*x + ' num2str(param(3))]);
    lgd = legend(['RMSE = ' num2str((round(RMSE(index),4))*100) '%'],['Adjusted R^{2} = '  num2str((round(adjRsquared(index),2)))]);
    lgd.FontSize = 16;
    legend('boxoff');
    xlabel('Years','FontWeight','bold');
    ylabel('Impervious Surface Percentage','FontWeight','bold');
    xlim([0 19])
    xticks([1 3 5 7 9 11 13 15 17 19])
    xticklabels({'2000','2002','2004','2006','2008','2010','2012','2014','2016','2018'})
    ylim([0 1])
    yticklabels({'0%','10%','20%','30%','40%','50%','60%','70%','80%','90%','100%'});
    ax = gca;
    ax.FontSize = 16;   
elseif size(param,2) == 2 % class 8,9
    fplot(@(x) param(1) * x + param(2),[0 19],'Color',[79/255,193/255,233/255],'LineWidth',3);
    hold on;
    scatter(cell2mat(xcoord(index)),cell2mat(ycoord(index)),100,[240/255,2/255,127/255],'o','filled');
    title('');
%     lgd = legend(['Y =' num2str(param(1)) '*x+' num2str(param(2))]);
    lgd = legend(['RMSE = ' num2str((round(RMSE(index),4))*100) '%'],['Adjusted R^{2} = '  num2str((round(adjRsquared(index),2)))]);
    legend('boxoff');
    lgd.FontSize = 16;
    xlabel('Years','FontWeight','bold');
    ylabel('Impervious Surface Percentage','FontWeight','bold');
    xlim([0 19])
    xticks([1 3 5 7 9 11 13 15 17 19])
    xticklabels({'2000','2002','2004','2006','2008','2010','2012','2014','2016','2018'})
    ylim([0 1])
    yticklabels({'0%','10%','20%','30%','40%','50%','60%','70%','80%','90%','100%'});
    ax = gca;
    ax.FontSize = 16;  
elseif size(param,2) == 6 % class 10
    x = cell2mat(xcoord(index));y = cell2mat(ycoord(index));xo = x;yo = y;
    rowTodelete = [];
    RFgaussian2(xo,yo,x,y,rowTodelete)
    hold on;
    scatter(cell2mat(xcoord(index)),cell2mat(ycoord(index)),100,[240/255,2/255,127/255],'o','filled');
    title('Unstable Gauss');
    lgd = legend(['RMSE = ' num2str((round(RMSE(index),4))*100) '%'],['Adjusted R^{2} = '  num2str((round(adjRsquared(index),2)))]);
    legend('boxoff');
    lgd.FontSize = 16;
    xlabel('Years','FontWeight','bold');
    ylabel('Impervious Surface Percentage','FontWeight','bold');
    xlim([0 19])
    xticks([1 3 5 7 9 11 13 15 17 19])
    xticklabels({'2000','2002','2004','2006','2008','2010','2012','2014','2016','2018'})
    ylim([0 1])
    yticklabels({'0%','10%','20%','30%','40%','50%','60%','70%','80%','90%','100%'});
    ax = gca;
    ax.FontSize = 16;
elseif size(param,2) == 1 % class 0
    fplot(@(x) param,[0 19],'Color',[79/255,193/255,233/255],'LineWidth',3);
    hold on;scatter(cell2mat(xcoord(index)),cell2mat(ycoord(index)),100,[240/255,2/255,127/255],'o','filled');
%     title(['Unchanged (RMSE = ' num2str(RMSE(index)) ')']);
%     lgd = legend(['Y = ' num2str(param)]);
    lgd = legend(['RMSE = ' num2str((round(RMSE(index),4))*100) '%']);
    lgd.FontSize = 16;
    legend('boxoff');
    xlabel('Years','FontWeight','bold');
    ylabel('Impervious Surface Percentage','FontWeight','bold');
    xlim([0 19])
    xticks([1 3 5 7 9 11 13 15 17])
    xticklabels({'2000','2002','2004','2006','2008','2010','2012','2014','2016','2018'})
    ylim([0 1]);
    yticklabels({'0%','10%','20%','30%','40%','50%','60%','70%','80%','90%','100%'});
    ax = gca;
    ax.FontSize = 16;
else
    error('Param is []')
end