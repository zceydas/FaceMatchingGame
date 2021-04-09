function [Accuracy,RT]=SimulateResponse(ProbeOnset,Match)

WaitSecs(1+rand)
matchresponse=randi(2)-1; RT=GetSecs-ProbeOnset;

if Match == 1 && matchresponse == 1
    Accuracy = 1;
elseif Match == 0 && matchresponse == 0
    Accuracy = 1;
else
    Accuracy = 0;
end

