% Get the player's name
username = input('Please enter your name: ' , 's');

totalError = 0;
initialMarkerSize = 10;
decreaseRatio = 0.85;

errorTolerance = 0.05;
timeLimit = 20;

% Generate 6 random locations
x  = rand(1, 6);
y  = rand(1, 6);

% Variable to check if the time limit is over
timeLimitOver = false;


figure;
hold on;
axis([0 1 0 1])

tic 
for tr = 1:numel(x)
    
    % Reduce the marker size and error tolerance in each iteration
    markerSize = initialMarkerSize * decreaseRatio ^ (tr-1);
    errorTolerance = errorTolerance * decreaseRatio ^ (tr-1);    
    
    % Plot the new target
    plot(x(tr), y(tr), 'ob', 'MarkerSize', markerSize);    
    hit = false;
    
    while(~hit)
       % Get user clocked location
       [ix, iy] = ginput(1);       
       
       duration = toc;
       % Check if the time limit is over. If yes, the game is over
       if(duration > timeLimit)
            fprintf('Sorry %s! The time limit for this game has already been over! \n', username);
            timeLimitOver = true;
            
            break; % Jump out of the while loop
       end
       
       distance = sqrt((x(tr) - ix)^2 + (y(tr) - iy)^2);
       
       % Check if distance is less than the error tolerance 
       if(distance < errorTolerance)
           plot(x(tr), y(tr), 'xr', 'MarkerSize', 10);
           hit = true;
       else
           plot(ix, iy, 'xr', 'MarkerSize', 5);
           totalError = totalError + distance;
       end
    end  
    
    % If the time limit is over, jump out of the for loop. No new target
    % will be shown.
    if(timeLimitOver)
        break; 
    end
    
end


if(~timeLimitOver)
    fprintf('%s, your total error for this game is %.3f and you finished the game in %.3f seconds! \n', username, totalError, duration);

    gameScore = load('GameScoreFile');

    names = gameScore.names;
    errors = gameScore.errors;

    % Add the name and the error for the currenct user to the lists
    names{end+1} = username;
    errors(end+1) = totalError;

    save GameScoreFile names errors;
    
    % Show the minimum error for games played so far and the name of the user who
    % got that error.
    [minError, minIndex] = min(errors);
    fprintf('The lowest error so far is %f achieved by %s \n', minError, names{minIndex})    
end

