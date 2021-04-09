clear all
tic
st = dbstack;
namestr = st.name;
directory=fileparts(which([namestr, '.m']));
cd(directory)
addpath(directory) % set path to necessary files
endGame=0;
subjectId=input('What is subject ID?');
Session=input('What is study session? Test(1), ReTest(2): '); % this can be 1 or 2 (test and re-test)
simulation=input('Is this a simulation? Yes(1), No(0): '); % this can be 1 or 2 (test and re-test)
datafileName = ['ID_' num2str(subjectId) '_Data Folder'];
if ~exist(datafileName, 'dir')
  mkdir(datafileName);
end

% prepare practice and test condition order
ConditionList=readtable('ConditionList.xlsx');
OneCondition=[repmat([1:length(unique(ConditionList.Condition))],1,unique(ConditionList.TrialNumber))'];
OneCondition(:,2)=ones(length(OneCondition),1);
AllConditions=[OneCondition; OneCondition(:,1) OneCondition(:,2)*2; OneCondition(:,1) OneCondition(:,2)*3];
ConditionOrder = AllConditions(randperm(size(AllConditions,1)),:)';
PracticeOrder=Shuffle(1:24); PracticeOrder(2,:)=ones(1,24)*9; 
ConditionOrder=[PracticeOrder ConditionOrder]; % add the practice trials to the beginning

% prepare Psychtoolbox screen and keyboard
KbName('UnifyKeyNames')
KeyTemp=KbName('KeyNames');
rightkey = KbName('RightArrow');%'RightArrow';
leftkey = KbName('LeftArrow');%LeftArrow';
endcode =  KbName('ESCAPE'); %escape key - if you press Escape during the experiment, study will pause until next key stroke
Screen('Preference', 'SkipSyncTests', 1)
% Get the screen numbers
screens = Screen('Screens');
% Draw to the external screen if avaliable
screenNumber = max(screens);
% Define black and white
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);
% Do a simply calculation to calculate the luminance value for grey. This
% will be half the luminace values for white
grey = white / 2;
% Open an on screen window
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, grey);
% Get the size of the on screen window
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
% Get the centre coordinate of the window
[xCenter, yCenter] = RectCenter(windowRect);
% Make a base Rect of 200 by 200 pixels
baseRect = [0 0 200 200];
% Screen X positions of our three rectangle           s
squareXpos = [screenXpixels * 0.35 screenXpixels * 0.65];
numSquares = length(squareXpos);


% start the trial sequence
InstructionsScreen(window);
for trialNo=1:length(ConditionOrder(1,:))
    
    Content=[]; TargetSide=[]; Match=[]; EmotionType=[];
    EmotionType=ConditionOrder(2,trialNo); % 1 neutral, 2 joy, 3 fear, 9 practice
    Content=ConditionList.ContentType(find(ConditionList.Condition==ConditionOrder(1,trialNo)),:); % only 1 target or with 1 distractor
    Match=ConditionList.MatchType(find(ConditionList.Condition==ConditionOrder(1,trialNo)),:); % whether the target matches the probe or not
    TargetSide=ConditionList.TargetSide(find(ConditionList.Condition==ConditionOrder(1,trialNo)),:); % 1 and 2 target top, 3 and 4 target bottom
    [Accuracy,RT,ImageList,endGame]=DetermineTargetSide(Content,TargetSide,Match,EmotionType,window,xCenter, yCenter, baseRect, squareXpos, numSquares,rightkey, leftkey,endcode,simulation);
    
    % organize results
    Results(trialNo,1)=EmotionType; 
    Results(trialNo,2)=Content;
    Results(trialNo,3)=Match;
    Results(trialNo,4)=TargetSide;
    Results(trialNo,5)=Accuracy;
    Results(trialNo,6)=RT;
    
    for l=1:length(ImageList);AllImages{trialNo,l}=ImageList{l};end
    
    if endGame == 1
        
        break
    end
    
    if trialNo ~= length(ConditionOrder)
        if (ConditionOrder(2,trialNo+1) < 9 && ConditionOrder(2,trialNo) == 9)
            DrawFormattedText(window, sprintf('%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s', ...
                'You completed all the Practice trials. Press a key to start the TEST.'), 'center', 'center',[0 0 0], [100],[],[],[1.25]);
            Screen('Flip',window); KbStrokeWait;
        end
    end
    
    if mod(trialNo,100) == 0
        DrawFormattedText(window, sprintf('%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s', ...
            'Take a short break and press a key to continue.'), 'center', 'center',[0 0 0], [100],[],[],[1.25]);
        Screen('Flip',window); KbStrokeWait;
    end
    
end
toc
Screen('DrawText', window, sprintf( '%s', 'Study is over. Thanks for your participation! ' ), xCenter-400, yCenter,[0 0 0]);
Screen('Flip',window);
WaitSecs(1);
KbStrokeWait;
Screen('CloseAll');
EndTime = datestr(now);

% save data in excel form and place in them subject folder
Table=table(Results(:,1),Results(:,2),Results(:,3),Results(:,4),Results(:,5),Results(:,6), ...
    'VariableNames',{'EmotionType','DistractorContent','Match','TargetSide', 'Accuracy','RT' });
writetable(Table,['Results',num2str(Session),'_' 'subject',num2str(subjectId),'_',date,'.xlsx']);

ImageTable=cell2table(AllImages, ...
    'VariableNames',{'Image1','Image2','Image3','Image4', 'ChangedImage' });
writetable(ImageTable,['ImageTable',num2str(Session),'_' 'subject',num2str(subjectId),'_',date,'.xlsx']);

files = dir(['*_subject' num2str(subjectId) '*.xlsx']);
for f=1:length(files)
    movefile(fullfile(files(f).folder,files(f).name), datafileName)
end

