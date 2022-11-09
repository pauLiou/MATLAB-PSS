function [screenStruct,w] = screenSettings


PsychDefaultSetup(2);
warning('off','all');
Screen('Preference','SkipSyncTests', 2);
Screen('Preference', 'SuppressAllWarnings', 1);
KbName('UnifyKeyNames');
Screen('Preference','TextRenderer',0)
screenStruct.screens = Screen('Screens');
screenStruct.screenNumber = 2; %max(Screens);

[w,windowRect] = PsychImaging('OpenWindow', screenStruct.screenNumber, 1);

[screenStruct.screenXpixels, screenStruct.screenYpixels] = Screen('WindowSize',w);
screenStruct.circleXCenter = screenStruct.screenXpixels * 0.5;

[screenStruct.xCenter, screenStruct.yCenter] = RectCenter(windowRect);

% Here we set the size of the arms of our fixation cross
fixCrossDimPix = 12;

% Now we set the coordinates (these are all relative to zero we will let
% the drawing routine center the cross in the center of our monitor for us)
xCoords = [-fixCrossDimPix fixCrossDimPix 0 0];
yCoords = [0 0 -fixCrossDimPix fixCrossDimPix];
screenStruct.allCoords = [xCoords; yCoords];

end
