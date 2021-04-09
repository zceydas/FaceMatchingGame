function [Accuracy,RT]=DetermineResponse(window,rightkey, leftkey,endcode,ProbeOnset,Match,xCenter, yCenter)
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
            answer=1;
            Screen('DrawText', window, sprintf( '%s', 'Press ESC to quit or press a key to continue.' ), xCenter-400, yCenter,[0 0 0]); 
            Screen('Flip',window);
            WaitSecs(1)
            while KbCheck;
            end;
            while 1
                [keyIsDown,TimeStamp,keyCode] = KbCheck;
                if keyIsDown
                    if (keyCode(endcode))
                        Screen('DrawText', window, sprintf( '%s', 'Study is over. Thanks for your participation! ' ), xCenter-400, yCenter,[0 0 0]); 
                        Screen('Flip',window);
                        WaitSecs(2);
                        Screen('CloseAll');
                        ListenChar(0);
                    elseif (~keyCode(endcode))
                        break;
                    end
                end
            end
        end
        while KbCheck;end; % wait until key is released.
    end
end

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
    

