% This algorithm is developed to monitor and categorize urban expansion
% patterns in Ho Chi Minh City at Vietnam btn 2000 and 2017. I apologize
% that this version of algorithm is only partial because the associated
% research is being prepared for publication by GEMA Lab led by Dr.
% Chengbin Deng at Ohio State University now (previously at Binghamton
% University).
% Author: Li Xi (BU CS master student), contact email: lxi@bu.edu

tic
for i = 1:3164
    for j = 1:2813
        for h = 1
            try
                x = xcoord{i,j};
                y = ycoord{i,j};
                pp = polyfit(x,y,1);                                       % estimate linear regression slope
                if isempty(x)
                    break
                elseif C(i,j) == 0                                % Unchanged # 0
                    break
                elseif C(i,j) == -1                               % Background+NA
                    break
                else
                    rowTodelete = [];
                    xo = x;
                    yo = y;
                    gaussian(xo,yo,x,y,rowTodelete);
                    polyrline2(xo,yo,x,y,rowTodelete);
                    sigrline(xo,yo,x,y,rowTodelete);
                    polyrline(xo,yo,x,y,rowTodelete);
                    [M,I] = min([rG,rP2,rS,rP]);
                    [N,J] = max([adjG, adjP2, adjS, adjP]);
                    RMSE(i,j) = M;
                    if N <= 0.3                                            % adjusted Rsquared <= 0.3
                        try
                            RFgaussian2(xo,yo,x,y,rowTodelete);
                            if adjG2 <= 0.3                                % adjusted Rsquared <= 0.3
                                C(i,j) = 11;                      % Cannot fit # 11 
                                RMSE(i,j) = -1;
                                F{i,j} = [];
                            elseif max(yy) > 1 || min(yy) < 0              % max(fitted IS) > 1 or min(fitted IS) < 0
                                C(i,j) = 11;                      % Cannot fit # 11
                                RMSE(i,j) = -1;
                                F{i,j} = [];
                            else
                                RMSE(i,j) = rG2;      
                                adjRsquared(i,j) = adjG2;
                                F{i,j} = [a1 b1 c1 a2 b2 c2];
                                C(i,j) = 10;CC(i,j) = -1;         % Compound function # 10
                            end
                        catch
                            disp('gauss 2 cannot fit');disp(i);disp(j);
                        end
                        break
                    end
                    if I == 1 % gaussian, only keep bell curve shape.
                        F{i,j} = [a1 b1 c1];
                        adjRsquared(i,j) = adjG; %
                        if b1 > 0 && b1 < 18                               % 0<mean<18
                            if b1 + 3*(c1/sqrt(2)) < 18 && b1 - 3*(c1/sqrt(2)) > 0     % mean+3*SD < 18 & mean-3*SD>0
                                C(i,j) = 3;                       % Gaussian # 3
                            else
                                if pp(1) > 0                               % linear regression slope > 0
                                    C(i,j) = 4;CC(i,j) = 4.1;     % Gaussian #4 Increase+stable
                                elseif pp(1) < 0                           % linear regression slope < 0
                                    C(i,j) = 5;CC(i,j) = 5.1;     % Gaussian #5 Stable+decrease
                                end
                            end
                        elseif b1 > 18                                     % mean > 18
                            if abs((c1/sqrt(2))) < abs(b1)                 % abs(SD) < abs(mean)
                                C(i,j) = 6;CC(i,j) = 6.1;         % Gaussian #6 stable+increase  
                            else
                                C(i,j) = 4;CC(i,j) = 4.1;         % Gaussian #4 increase+stable
                            end
                        elseif b1 < 0                                      % mean < 0
                            if abs((c1/sqrt(2))) < abs(b1)                 % abs(SD) < abs(mean)
                                C(i,j) = 7;CC(i,j) = 7.1;         % Gaussian #7 Decrease+stable
                            else
                                C(i,j) = 5;CC(i,j) = 5.1;         % Gaussian #5 Stable+decrease
                            end
                        end
                    elseif I == 2  % Quadratic polynomial
                        F{i,j} = pp2;
                        adjRsquared(i,j) = adjP2;
                        if pp2(1) > 0                                      % polynomial regression slope > 0
                            if pp(1) > 0                                   % linear regression slope > 0
                                C(i,j) = 6;CC(i,j) = 6.2;         % Polynomial #6 stable+increase           
                            elseif pp(1) < 0                               % linear regression slope < 0
                                C(i,j) = 7;CC(i,j) = 7.2;         % Polynomial #7 Decrease+stable
                            end
                        elseif pp2(1) < 0                                  % polynomial regression slope < 0
                            if pp(1) > 0                                   % linear regression slope > 0
                                C(i,j) = 4;CC(i,j) = 4.2;         % Polynomial #4 increase+stable
                            elseif pp(1) < 0                               % linear regression slope < 0
                                C(i,j) = 5;CC(i,j) = 5.2;         % Polynomial #5 Stable+decrease
                            end
                        end
                    elseif I == 3 % Logistic
                        if pp(1) > 0                                       % linear regression slope > 0
                            if param(3) > 0 && param(3) < 18 && abs(param(4)) >= 0.4   % 0<x50<18 & abs(slope)>=0.4
                                
                                % Increasing-sigmoidal-curve logistic model # 1
                            elseif param(3) < 0 && abs(param(4)) > 0.4     % x50<0 & abs(slope)>0.4
                                         
                                % Polynomial #4 increase+stable
                            elseif param(3) > 18 && abs(param(4)) > 0.4    % x50>18 & abs(slope)>0.4
                                         
                                % Polynomial #6 stable+increase  
                            elseif abs(param(4)) < 0.4                     % abs(slope)<0.4   
                                                      
                                % positive linear regression  #8
                            end
                        elseif pp(1) < 0                                   % linear regression slope < 0
                            if param(3) > 0 && param(3) < 18 && abs(param(4)) > 0.4    % 0<x50<18 & abs(slope)>=0.4
                                
                                % Decreasing-sigmoidal-curve logistic model # 2
                            elseif param(3) < 0 && abs(param(4)) > 0.4     % x50<0 & abs(slope)>0.4
                                
                                % Polynomial #7 Decrease+stable
                            elseif param(3) > 18 && abs(param(4)) > 0.4    % x50>18 & abs(slope)>0.4
                                
                                % Polynomial #5 Stable+decrease
                            elseif abs(param(4)) < 0.4                     % abs(slope)<0.4 
                                
                                % Negative linear regression #9
                            end
                        end
                    elseif I == 4  % Linear regression
                        if size(Out,1) == 1 && ismember(18,Out)            % Outlier is one row and 2017 IS is an outlier
                            
                            % Polynomial #6 stable+increase  
                        elseif adjP2 >= 0.8                                % Adjusted Rsquared >=0.8
                            F{i,j} = pp;
                            adjRsquared(i,j) = adjP;
                            if pp(1) > 0                                   %  linear regression slope > 0
                                C(i,j) = 8;                       % positive linear regression  #8
                            elseif pp(1) < 0                               % linear regression slope < 0
                                C(i,j) = 9;                       % Negative linear regression  #8
                            end
                        else
                            C(i,j) = 11;                          % Cannot fit. 
                            RMSE(i,j) = -1;
                        end
                    end
                end
            catch
                disp('Error in gaussian');disp(i);disp(j);
                try
                    sigrline(xo,yo,x,y,rowTodelete);
                    polyrline(xo,yo,x,y,rowTodelete);
                    polyrline2(xo,yo,x,y,rowTodelete);
                    [M,I] = min([rP2, rS, rP]);
                    [N,J] = max([adjP2, adjS, adjP]);
                    RMSE(i,j) = M;
                    if N <= 0.3
                        try
                            RFgaussian2(xo,yo,x,y,rowTodelete);
                            if adjG2 <= 0.3 %
                                C(i,j) = 11;
                                RMSE(i,j) = -1;
                                F{i,j} = [];
                            elseif max(yy) > 1 || min(yy) < 0
                                C(i,j) = 11;
                                RMSE(i,j) = -1;
                                F{i,j} = [];
                            else
                                RMSE(i,j) = rG2;
                                adjRsquared(i,j) = adjG2;
                                C(i,j) = 10;
                                F{i,j} = [a1 b1 c1 a2 b2 c2];
                                CC(i,j) = -1;
                            end
                        catch
                            disp('gauss 2 cannot fit');disp(i);disp(j);
                        end
                        break
                    end
                    if I == 1 % P2
                        
                    elseif I == 2 % logistic
                        
                    elseif I == 3 % P1
                      
                catch
                    disp('Unexpected Error');disp(i);disp(j);
                end
            end
        end
    end
end
toc
