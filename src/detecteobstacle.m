function   [pcObsDetected,rect] = detecteobstacle(pcOrigin,pcObstacle)
%detetct obstacle
%
% INPUT
%   pcOrigin   - reference pointcloud data
%   pcObstacle - pointcloud data to detetct
% 
% OUTPUT:
%
% This program is only a demo of detetcting obstacle. It didn't consider 
% the working efficiency of algorithm. It may takes much time when you 
% process a mass of pointcloud.  
%

% The program is written by Chen Qichao in his period of studying in master
% degree at Tongji University. You can redistribute or modify the program
% for non-commercial use. Any commercial use of this program is forbidden
% except being authorized.
%
% mail : mailboxchen@foxmail.com
% Copyright (C) 2015 - 2018  Tongji University


%%%%%%%%%%%%%%%
% ICP perform poorly because road point cloud only has the strict 
% constraint on plan while loose constraint on vertical. It may result in 
% dislocation of matching. So before using ICP, you should make sure that 
% the ICP is suitable for your data.
% [tform,movingReg] = pcregrigid(pointCloud(pcObstacle(1:10:end,1:3)),pointCloud(pcOrigin(1:10:end,1:3)));
% tform = tform.T;
% matchedPcd = [pcObstacle(:,1:3) ones(size(pcObstacle,1),1)];
% matchedPcd = matchedPcd*tform;
% matchedPcd(:,4) = pcObstacle(:,4);
% savepointcloud2file(matchedPcd,'icp',0);
%%%%%%%%%%%%%%%

Mdl = KDTreeSearcher(pcOrigin(:,1:3));
Idx = rangesearch(Mdl,pcObstacle(:,1:3),0.5);
tem=cellfun(@isempty,Idx);
pcDetected = pcObstacle(tem==1,:);
index = clustereuclid(pcDetected(:,1:3),0.3,9999);
iObs = 0;
for i=1:size(unique(index),1)
    idx_tmp = find(index==i);
    np = size(idx_tmp,1);
    if np>5
        pcObs = pcDetected(idx_tmp,:);
        iObs = iObs+1;
        pcObsDetected(iObs) = {pcObs};
        minx = min(pcObs(:,1));
        maxx = max(pcObs(:,1));
        miny = min(pcObs(:,2));
        maxy = max(pcObs(:,2));
        minz = min(pcObs(:,3));
        maxz = max(pcObs(:,3));
        rect(iObs) = {[minx maxx;miny maxy;minz maxz]};
    end
end
if ~exist('pcObsDetected','var')
    pcObsDetected = {};
    rect = {};
end
end


