function [Accuracy,RT,endGame]=DetermineResponse(window,rightkey, leftkey,endcode,ProbeOnset,Match,xCenter, yCenter)
endGame=0;
while KbCheck;
end;
while 1
    [keyIsDown,TimeStamp,keyCode] = KbCheck;
    if keyIsDown
        if (~keyCode(endcode))
            if (keyCode(leftkey)); matchresponse=0; RT=GetSecs-ProbeOnset; answer=1;  end
            if (keyCode(rightkey)); matchresponse=1; RT=GetSecs-ProbeOnset; answer=1;  end
            if (~keyCode(rightkey) && ~keyCode(leftkey))
                Screen('DrawText', window, sprintf( '%s', 'Only use left or right arrow keys.' ), xCenter-300, yCenter,[0 0 0]);
                Screen('Flip',window); WaitSecs(1); answer = 9;
            end  
            break;
        else
            Screen('DrawText', window, sprintf( '%s', 'Press ESC to quit or press a key to continue.' ), xCenter-400, yCenter,[0 0 0]); 
            Screen('Flip',window);
            while KbCheck;
            end;
            while 1
                [keyIsDown,TimeStamp,keyCode] = KbCheck;
                if keyIsDown
                    if (keyCode(endcode))
                        endGame=1; answer=1; 
                    else
                        answer = 9;
                    end
                    break;
                end
            end
        end
       while KbCheck;end; % wait until key is released.
    end
end
if endGame < 1
    if answer < 9
        if Match == 1 && matchresponse == 1
            Accuracy = 1;
        elseif Match == 0 && matchresponse == 0
            Accuracy = 1;
        else
            Accuracy = 0;
        end
    else
        RT=999;
        Accuracy = 9;
    end
else
    Accuracy = 0; RT=999; 
end


