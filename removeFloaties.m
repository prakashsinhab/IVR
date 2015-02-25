function count = removeFloaties(inputImage)
    
    % get the centroid of every remaining object
    stats  = regionprops(inputImage, 'centroid');
    centroids = cat(1, stats.Centroid);
    
    % calculate the average centroid (i.e. objects' center of mass)
    averageCentroid = mean(centroids);
    x = averageCentroid(1);
    y = averageCentroid(2);
    
    % if object is too far from average centroid, then remove it from the
    % regionprops list
    totalDist = 0;
    for i = 1:size(centroids, 1)
        X = [x, y; centroids(i,:)];
        d = pdist(X,'euclidean');
        totalDist = totalDist + d;
        
    end
    averageDist = totalDist / size(centroids, 1);
    
    count = 0;
    for i = 1:size(centroids, 1)
        
        X = [x, y; centroids(i,:)];
        d = pdist(X,'euclidean');
        
        % if the distance from the object's centroid to the average
        % centroid is two times greater than the average distance, then do
        % not count the object
        if d < (2.5 * averageDist)
           
            count = count + 1;
            
        end 
    end;
    
    % TODO: remove objects outside of a boundary (i.e. unwanted objects)

end

