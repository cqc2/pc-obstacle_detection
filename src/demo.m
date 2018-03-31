pcOrigin = readpointcloudfile2('data1.xyz');
pcObstacle = readpointcloudfile2('data2.xyz');
[pcObsDetected,rect] = detecteobstacle(pcOrigin,pcObstacle);
figure(1);scatter3(pcObstacle(:,1),pcObstacle(:,2),pcObstacle(:,3),1,pcObstacle(:,4));hold on
for i=1:size(pcObsDetected,2)
    Rect =  rect{i};
    pcObs = pcObsDetected{i};
    minx = Rect(1,1);
    maxx = Rect(1,2);
    miny = Rect(2,1);
    maxy = Rect(2,2);
    minz = Rect(3,1);
    maxz = Rect(3,2);
    if (maxz-minz)>0.5
        figure(1); text(maxx,maxy,maxz+1,'stu');
        figure(2);  text(maxx,maxy,maxz+1,'stu');
    elseif (maxz-minz)<0.5
        figure(1);  text(maxx,maxy,maxz+1,'bird');
        figure(2);  text(maxx,maxy,maxz+1,'bird');
    end
    np = size(pcObs,1);
    figure(1); plot3([maxx minx minx maxx],[miny miny miny miny],[maxz maxz minz minz],'r-');hold on;
    figure(1); plot3([maxx maxx maxx maxx],[maxy miny miny maxy],[maxz maxz minz minz],'r-');hold on;
    figure(1); plot3([minx maxx maxx minx],[maxy maxy maxy maxy],[maxz maxz minz minz],'r-');hold on;
    figure(1);plot3([minx minx minx minx],[miny maxy maxy miny],[maxz maxz minz minz],'r-');hold on;
    figure(2); plot3([maxx minx minx maxx],[miny miny miny miny],[maxz maxz minz minz],'r-');hold on;
    figure(2); plot3([maxx maxx maxx maxx],[maxy miny miny maxy],[maxz maxz minz minz],'r-');hold on;
    figure(2); plot3([minx maxx maxx minx],[maxy maxy maxy maxy],[maxz maxz minz minz],'r-');hold on;
    figure(2); plot3([minx minx minx minx],[miny maxy maxy miny],[maxz maxz minz minz],'r-');hold on;
    figure(1);scatter3(pcObs(:,1),pcObs(:,2),pcObs(:,3),ones(np,1).*4,ones(np,1).*rand);hold on;axis equal
    figure(2);scatter3(pcObs(:,1),pcObs(:,2),pcObs(:,3),ones(np,1).*4,ones(np,1).*rand);hold on;axis equal
end