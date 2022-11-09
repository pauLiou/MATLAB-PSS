sca;

addpath('H:\Project Doris\helperFunctions');

[screenStruct, w] = screenSettings; % screen settings function
keyboardInfo;  % keyboard settings function
white = WhiteIndex(screenStruct.screenNumber); %define default colours white
black = BlackIndex(screenStruct.screenNumber); %define default colours black

% create the objects
baseRect = [0 0 200 250]; % size

centeredRect1 = CenterRectOnPointd(baseRect,screenStruct.xCenter/2,screenStruct.yCenter); %location
centeredRect2 = CenterRectOnPointd(baseRect,screenStruct.xCenter*1.5,screenStruct.yCenter); %location
boxes = [centeredRect1;centeredRect2]; % put the two box locations into 1 variable
rectColour1 = [1 0 0]; % colour
rectColour2 = [0 1 0]; % colour

numTrials = 10; %trials
numBlocks = 1; %blocks

SOAs = [0.2,0.4,0.4,0.2,0.4,0.2,0.4,0.2,0.4,0.2]; % set the SOAs

Screen('BlendFunction', w, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA'); % antialiasing


output.currentblock = 1; % generate output current block
output.currenttrial = 1; % generate output current trial

for block = output.currentblock:numBlocks % begin the block
    if block == 1
        DrawFormattedText(w, '\n Welcome to the Experiment', 'center','center',black);
        Screen('Flip',w);
        KbStrokeWait;
    end
    
    trialnr = 1;
    for trial = output.currenttrial:numTrials % begin the trial
        
        % set the boxes for this trial:
        firstBox = boxes(randsample(2,1),:); % currently we're just doing random side
        if ismember(firstBox,boxes(1,:),'rows')
            secondBox = boxes(2,:);
        else
            secondBox = boxes(1,:);
        end
        
        %~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        % step one draw the fixation cross (1 second)
        Screen('DrawLines', w, screenStruct.allCoords, 3, black, [screenStruct.circleXCenter screenStruct.yCenter], 2); % fixation cross
        Screen('Flip',w); % flip screen
        myWait(1); % duration in seconds
        
        %~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        % step two draw the first box
        Screen('DrawLines', w, screenStruct.allCoords, 3, black, [screenStruct.circleXCenter screenStruct.yCenter], 2); % fixation cross
        Screen('FillRect',w,rectColour1,firstBox); % first box
        Screen('Flip',w);
        myWait(SOAs(trialnr));
        
        %~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        % step three draw second box
        Screen('DrawLines', w, screenStruct.allCoords, 3, black, [screenStruct.circleXCenter screenStruct.yCenter], 2); % fixation cross
        Screen('FillRect',w,rectColour1,firstBox); % first box
        Screen('FillRect',w,rectColour2,secondBox); % second box
        Screen('Flip',w);
        
        %~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        % step four response
        [secs,keyCode] = KbWait;
        response = find(find(keyCode == 1) == [leftKey,rightKey]);
        
        %~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        % step five trial output
        output.responses((block-1)*numTrials+trial,1) = block; % current block
        output.responses((block-1)*numTrials+trial,2) = trial; % current trial
        output.responses((block-1)*numTrials+trial,3) = response; % response key
        output.responses((block-1)*numTrials+trial,4) = find(firstBox == boxes(:,1)); % first box to appear
        output.responses((block-1)*numTrials+trial,5) = find(secondBox == boxes(:,1)); % second box to appear
        output.responses((block-1)*numTrials+trial,6) = SOAs(trialnr);
    
        output.currenttrial = output.currenttrial + 1; % next trial
        trialnr = trialnr + 1;
    end
end
threshold = PSS_threshold(output.responses);
sca;
    
