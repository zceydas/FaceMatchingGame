function [Accuracy,RT,ImageList,endGame]=DetermineTargetSide(Content,TargetSide,Match,EmotionType,window,xCenter, yCenter, baseRect, squareXpos, numSquares,rightkey, leftkey,endcode,simulation)% Clear the workspace and the screen

% determine target and fixation cross durations below
arrowDur=.2;
fixFont=40;
firstFixDur=.3;
secondFixDur=.9;
targetDur=.25;
ITI=1.2+rand;

if TargetSide < 3
    targetrow=1; % top=1, bottom=3
    nontargetrow=3; % % top=1, bottom=3
else
    targetrow=3; % top=1, bottom=3
    nontargetrow=1; % % top=1, bottom=3
end

% nontargetColor=[.6;.6;0];
% targetColor=[.6;.2;0];
nontargetColor=[0;0;0];
targetColor=[0;0;0];

% Set the colors to Red, Green and Blue
if Content == 1
    allColors (:,1)=targetColor;
    allColors (:,2)=targetColor;
else
    allColors (:,targetrow)=targetColor;
    allColors (:,targetrow+1)=targetColor;
    allColors (:,nontargetrow)=nontargetColor;
    allColors (:,nontargetrow+1)=nontargetColor;
end

% Make our rectangle coordinates
allRects = nan(4, 2);
for i = 1:numSquares
    if Content == 1
        if TargetSide < 3
            allRects(:, i) = CenterRectOnPointd(baseRect, squareXpos(i), yCenter-200);
        else
            allRects(:, i) = CenterRectOnPointd(baseRect, squareXpos(i), yCenter+200);
        end
    else
        allRects(:, i) = CenterRectOnPointd(baseRect, squareXpos(i), yCenter-200);
        allRects(:, i+2) = CenterRectOnPointd(baseRect, squareXpos(i), yCenter+200);
    end
end
% Pen width for the frames
penWidthPixels = 6;

ImageDim(1:2,:)=allRects(1:2,:)+6;
ImageDim(3:4,:)=allRects(3:4,:)-6;

% Draw fixation cross for ITI
Screen('TextSize',window, fixFont);
Screen('DrawText', window, sprintf( '%s', '+' ), xCenter, yCenter,[0 0 0]);
Screen('Flip',window); WaitSecs(ITI);

% create an arrow
if mod(TargetSide,2) == 0 % target on the right
    draw_arrow(window, [xCenter, yCenter-200], 180, [0 0 0], [50 50 200 10])
    draw_arrow(window, [xCenter, yCenter+200], 180, [0 0 0], [50 50 200 10])
else % target on the left
    draw_arrow(window, [xCenter, yCenter-200], 360, [0 0 0], [50 50 200 10])
    draw_arrow(window, [xCenter, yCenter+200], 360, [0 0 0], [50 50 200 10])
end
Screen('DrawText', window, sprintf( '%s', '+' ), xCenter, yCenter,[0 0 0]);
Screen('Flip',window);
WaitSecs(arrowDur);

% Draw fixation cross
Screen('TextSize',window, fixFont);
Screen('DrawText', window, sprintf( '%s', '+' ), xCenter, yCenter,[0 0 0]);
Screen('Flip',window); WaitSecs(firstFixDur);

[LeftTop,RightTop,LeftBottom,RightBottom,LeftTop2,RightTop2,LeftBottom2,RightBottom2,ImageList]=pickImage(TargetSide,Content,Match,EmotionType);% Draw the rects to the screen

Screen('FrameRect', window, allColors, allRects, penWidthPixels);
Screen('DrawText', window, sprintf( '%s', '+' ), xCenter, yCenter,[0 0 0]);

if Content == 1 && TargetSide < 3
    Screen(window,'PutImage',LeftTop,ImageDim(:,1));
    Screen(window,'PutImage',RightTop,ImageDim(:,2));
elseif Content == 1 && TargetSide > 2
    Screen(window,'PutImage',LeftBottom,ImageDim(:,1));
    Screen(window,'PutImage',RightBottom,ImageDim(:,2));
else
    Screen(window,'PutImage',LeftTop,ImageDim(:,1));
    Screen(window,'PutImage',RightTop,ImageDim(:,2));
    Screen(window,'PutImage',LeftBottom,ImageDim(:,3));
    Screen(window,'PutImage',RightBottom,ImageDim(:,4));
end
Screen('Flip', window); WaitSecs(targetDur);

% Draw fixation cross
Screen('TextSize',window, fixFont);
Screen('DrawText', window, sprintf( '%s', '+' ), xCenter, yCenter,[0 0 0]);
Screen('Flip',window); WaitSecs(secondFixDur);

Accuracy = 9;
while Accuracy > 1
    % Wait for a key press
    % Draw the rects to the screen
    Screen('FrameRect', window, allColors, allRects, penWidthPixels);
    Screen('DrawText', window, sprintf( '%s', '+' ), xCenter, yCenter,[0 0 0]);
    if Content == 1 && TargetSide < 3
        Screen(window,'PutImage',LeftTop2,ImageDim(:,1));
        Screen(window,'PutImage',RightTop2,ImageDim(:,2));
    elseif Content == 1 && TargetSide > 2
        Screen(window,'PutImage',LeftBottom2,ImageDim(:,1));
        Screen(window,'PutImage',RightBottom2,ImageDim(:,2));
    else
        Screen(window,'PutImage',LeftTop2,ImageDim(:,1));
        Screen(window,'PutImage',RightTop2,ImageDim(:,2));
        Screen(window,'PutImage',LeftBottom2,ImageDim(:,3));
        Screen(window,'PutImage',RightBottom2,ImageDim(:,4));
    end
    Screen('Flip', window); ProbeOnset=GetSecs;
    if simulation == 0
        [Accuracy,RT,endGame]=DetermineResponse(window,rightkey,leftkey,endcode,ProbeOnset,Match,xCenter, yCenter);
        if (Accuracy < 9 || endGame == 1)
            break;
        end
    elseif simulation == 1
        endGame=0;
        [Accuracy,RT]=SimulateResponse(ProbeOnset,Match);
    end
end

