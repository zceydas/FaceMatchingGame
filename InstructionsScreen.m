function []=InstructionsScreen(window)

DrawFormattedText(window, sprintf('%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s', ...
    'Welcome to the FACE MATCHING game.', ...
    'This game consists of two phases: Practice and Test.', ...
    'Press a key to read the game rules.'), 'center', 'center',[0 0 0],[100],[],[],[2]);
Screen('Flip',window); KbStrokeWait;

DrawFormattedText(window, sprintf('%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s', ...
    'On each trial, your task will be to decide if a FACE image changed or not.', ...
    '1) First you will see two arrows directing you to the side of the screen you should attend', ...
    '2) On that side of the screen, find the image that contains a FACE.', ...
    '3) On the next screen, you will indicate if the FACE you just saw changed or not'), 'center', 'center',[0 0 0],[100],[],[],[2]);
Screen('Flip',window); KbStrokeWait;

DrawFormattedText(window, sprintf('%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s', ...
    'For example, if you see two arrows pointing towards LEFT', ...
    'Look at the left side of the screen.', ...
    'Then find the face which can be either on the top or the bottom of the screen.', ...
    'Then wait for the next screen to see if that face is the same or not.'), 'center', 'center',[0 0 0],[100],[],[],[2]);
Screen('Flip',window); KbStrokeWait;

DrawFormattedText(window, sprintf('%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s', ...
    'If the face changed between screens, press the LEFT arrow key ', ...
    'If the face remained the same between screen, press the RIGHT arrow key', ...
    'Now press a key to start practicing.'), 'center', 'center',[0 0 0], [100],[],[],[2]);
Screen('Flip',window); KbStrokeWait;