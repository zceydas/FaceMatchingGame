%Results=readtable('Results1_subject333_10-Aug-2021.xlsx');

% emotion type: 1- neutral, 2- Joy, 3- Fear
% Content type: 1- no distractor, 2- neutral distractor, 3- alcohol
% distractor
% Match: 0- no match, 1- match
% Target side: 1 and 2 target top, 3 and 4 target bottom
WM=[]; RTs=[];
for emo=1:3  
    EmoResults=[]; EmoResults=Results((Results.EmotionType==emo),:);
    for dist=1:3
        DistResults=[]; DistResults=EmoResults((EmoResults.DistractorContent==dist),:);
        Hits=[]; Hits=size(DistResults((DistResults.Match==1 & DistResults.Accuracy==1),1),1);
        FAs=[]; FAs=size(DistResults((DistResults.Match==0 & DistResults.Accuracy==0),1),1);
        WM(emo,dist)=(Hits-FAs);
        
        HitRTs=[]; HitRTs=DistResults((DistResults.Match==1 & DistResults.Accuracy==1),end);
        RTs(emo,dist)=mean(HitRTs{:,:});

    end 
end

WMResults=table(WM(:,1), WM(:,2), WM(:,3), 'VariableNames', {'Neutral','Joy','Fear'}, ...
    'RowNames', {'noDistractor', 'Neutral','Alcohol'})

RTResults=table(RTs(:,1), RTs(:,2), RTs(:,3), 'VariableNames', {'Neutral','Joy','Fear'}, ...
    'RowNames', {'noDistractor', 'Neutral','Alcohol'})
