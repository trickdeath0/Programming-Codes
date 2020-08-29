@echo off 
title My Batch Tutorial
color 0a
echo ------------------------------------------------------------------------
echo Welcome to my tutorial! Here I will tell you all I know about batch files.
echo ------------------------------------------------------------------------
echo.
pause
cls
echo A batch file is a mini program. They are fun and easy to make.
echo.
echo (sometimes)
echo.
echo In fact, this is a batch file!
echo.
pause
:to
cls
echo -Basic Commands
echo. 
echo Here are some commands. Type down the one you want to learn about.
echo.
echo When typing, DO NOT type spaces. If I were you, I'd take these in order. 
echo. 
echo set, set/a, set/p, echo, @echo off, cls, color, pause, goto
echo.
set/p learn=
if %learn%==set/a GOTO sa
if %learn%==set/p GOTO sp
if %learn%==set GOTO se
if %learn%==echo GOTO e
if %learn%==@echooff GOTO eo
if %learn%==cls GOTO c
if %learn%==color GOTO co
if %learn%==pause GOTO p
if %learn%==goto GOTO g
:se
cls
echo Open notepad. (all programs/accessories/notepad)
echo.
echo The first thing you need to know is what a variable is. A variable is a piece of information that the computer stores for later.
echo.
echo In notepad, type:
echo. 
echo set num1=hi!
echo. 
echo The command "set" stores num1 in the computer. Num1's carrying the message "hi!"
echo. 
echo So every time we type num1, Hi! appears, right?
echo.
echo WRONG
echo.
echo To do that, we need to type:
echo.
echo @echo off
echo set num1=hi!
echo echo %%num1%%
echo pause
echo.
pause
cls
echo Don't worry about echo, @echo off, and pause. We'll talk about those later.
echo.
echo Notice that instead of typing num1 I typed %%num1%%.
echo.
echo To make this a batch file, click file/save as. When you save be sure to type 
echo .bat at the end. This is what makes it a batch file. When you run it,it should 
echo say:
echo.
echo hi!
echo press any key to continue... 
echo.
echo -----------------------------------------------------------------------
echo.
pause
goto to
:sa
cls
echo Now that you know the basics of sets, let's get a little more complicated.
echo.
echo So you know that sets store info, right?  What if I wanted to do math?
echo.
echo Type this in notepad.
echo.
echo @echo off
echo set num=1
echo set num=%%num%%+1
echo echo %%num%%
echo pause
echo.
echo After you save it as .bat, run it.
echo.
echo But before that, predict what will be displayed.
echo.
echo So if num=1, then num=%%num%%+1, it should say 2,right?
echo.
echo To find out, run the program.
echo.
pause
cls
echo It said 1+1, didn't it?  That's because the computer took your command literaly.
echo.
echo To make your command mathematical, you need to type:
echo.
echo @echo off
echo set/a num=1
echo set/a num=%%num%%+1
echo echo %%num%%
echo pause
echo.
echo After you save it with .bat at the end, run it.
echo.
echo Now it should display 2.
echo.
echo That's because we used set/a. The set/a command makes a set that takes your 
echo input mathematicly.
echo.
pause
goto to
:sp
cls
echo This is the last portion of the set tutorials.
echo.
echo The set/p command lets the user name what a variable holds.
echo.
echo For example, I used the set/p command on this tutorial so you could 
echo choose what you wanted to learn about. 
echo.
echo With the set/p command comes the if command.
echo.
echo The if command lets you have two or more different places to go.
echo.
echo Type this in notepad.
echo.
echo @echo off
echo echo Press 1 to say hi or press 2 to say bye.
echo set/p go=
echo if %%go%%==1 ECHO Hi!
echo if %%go%%==2 ECHO Bye!
echo pause
echo.
echo ------------------------------------------------------------------------
echo.
pause
cls
echo Save it as .bat and run the file.
echo.
echo Basicly how this works is set/p waits for you to type in info for "go" to hold.
echo. 
echo Then, the if command ensures that if "go"=1, say Hi! And if "go"=2 say bye!
echo.
echo Yes, you have to type two equal signs.
echo.
pause
goto to
:e
cls
echo By now, you've probably guessed what echo does.
echo.
echo But if you haven't, let me explain.
echo.
echo The echo command lets you display a message.
echo.
echo In notepad, type:
echo.
echo @echo off
echo echo Type a math problem to solve!
echo set/p math=
echo set/a newmath=%%math%%
echo echo %%newmath%%
echo pause 
echo.
echo Save it as .bat and run the program! You've just made a caculator!
echo.
pause
cls
echo Here are some tips and facts on echo:
echo.
echo -Be sure to put a space after echo 
echo -If you type echo. you'll get a blank row
echo -Anything you type after echo will not take effect unless it's a set
echo -To type a set after echo and not make it have an effect, type 
echo %%%variablename%%% on each side, or just type without %%'s.
echo.
pause
goto to
:eo
cls
echo You also may have guessed what this command does.
echo.
echo However, this one is harder to predict.
echo.
echo Type this in notepad.
echo.
echo echo Type a math problem to solve!
echo set/p math=
echo set/a newmath=%%math%%
echo echo %%newmath%%
echo pause
echo.
echo As you can see, this is the caculator from the previous lesson, but without the @echo off command.
echo.
echo Try the program!
echo.
pause
cls
echo It did the same thing as the other caculator, but there was a whole lot more
echo computery stuff shown.
echo.
echo The @echo off command hides all of that.
echo.
echo It is not a mandatory command in a batch file,but it helps a lot in any program.
echo [It really, REALLY helps]
echo.
pause
goto to  
:c
cls
echo The cls command clears out the entire page like a dry-erase board.
echo.
echo An example of the cls command is in this very lesson!
echo.
echo To see it, proceed.
echo.
pause
cls
echo See? The page was "erased" and replaced with new text!
echo.
echo Type this in notepad. Type an insult where it says, "TYPE INSULT HERE."
echo.
echo @echo off
echo set pi=[TYPE INSULT HERE]
echo echo %%pi%%
echo echo Press 1 to make this message go away.
echo echo Press 2 to make this message repeat itself 8 times.
echo set/p choo=
echo if %%choo%%==1 GOTO over
echo if %%choo%%==2 ECHO %%pi%%%%pi%%%%pi%%%%pi%%%%pi%%%%pi%%%%pi%%%%pi%%
echo pause
echo goto end
echo :over
echo cls
echo pause
echo :end 
echo.
echo Pretty funny, eh? Anyway, this is is related to the lesson because the cls 
echo command was used to make the insult disapear.
echo.
pause
goto to 
:co
cls
echo I bet by now you're wondering how I got colored text.
echo.
echo The answer is the "color" command!
echo.
echo OK, a lot of stuff is about to show up. I didn't type down what you are about to see.
echo.
echo I used the "help color" command.
echo.
pause
cls
help color
echo ________________________________________________________________________
echo.
echo Told 'ya!
echo.
echo To test colors, type this in notepad.
echo.
echo @echo off
echo :test
echo help color
echo echo ------------------------------------------------------------------------
echo echo.
echo echo Type a color code to test colors!
echo set/p chrome=
echo color %%chrome%%
echo goto test
echo.
echo That program should help you test out color combos!
echo.
pause
goto to
:p
cls
echo To find out what pause means, type this in notepad:
echo.
echo @echo off
echo echo Hi! My name is Bob!
echo.
echo Test the file.
echo.
pause
cls
echo Too fast!
echo.
echo To let yourself actually read the text, add this to your notepad code.
echo.
echo @echo off
echo echo Hi! My name is Bob!
echo pause
echo.
echo The pause command made "press any key to continue..." appear.
echo.
echo This lets you type text without it disappearing as soon as you open the file.
echo.  
pause
goto to
:g
cls
echo The goto command is also pretty easy to guess.
echo. 
echo This command lets you go to a certain place in the file.
echo.
echo Type this in notepad.
echo.
echo @echo off
echo color 0a
echo echo Press 1 for info about 1 or 2 for info about 2.
echo set/p me=
echo if %%me%%==1 GOTO one
echo if %%me%%==2 GOTO two
echo :one
echo cls
echo The numaral value of a single object, being, etc.
echo pause
echo goto end
echo :two
echo cls
echo The nummeral with a value of 2. 
echo pause
echo :end
echo.
pause
cls
echo I bet you understand what's going on here.
echo.
echo To make the p.c. go somewhere, you have to put : before the location.
echo.
pause
goto to
