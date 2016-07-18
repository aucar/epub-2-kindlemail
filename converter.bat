@ECHO OFF

SET MYKINDLEMAIL="mymail@kindle.com"

SET CURRENTDIR=%~dp0
SET SOURCEFILE=%~f1
SET ORIGINALFILEPATH=%~p1
SET ORIGINALFILENAME=%~n1
SET ORIGINALFILEEXTENTSION=%~x1
SET ORIGINALFILENAMEWITHEXT=%~n1%~x1

SET TARGETEPUB=%CURRENTDIR%epub
SET TARGETMOBI=%CURRENTDIR%mobi

SET DESTINATIONFILEPATH=%ORIGINALFILEPATH%
SET DESTINATIONFILENAME=%~n1.mobi
SET DESTINATIONFILE=%~d1%DESTINATIONFILEPATH%%DESTINATIONFILENAME%
SET DESTINATIONFILEINARCHIVE=%TARGETMOBI%\%DESTINATIONFILENAME%


SET KINDLEGENBIN="%CURRENTDIR%apps\KindleGen\kindlegen.exe"
SET OUTLOOKBIN="C:\Program Files\Microsoft Office\Office14\OUTLOOK.EXE"

if not exist %TARGETEPUB% mkdir %TARGETEPUB%
if not exist %TARGETMOBI% mkdir %TARGETMOBI%


    IF NOT %ORIGINALFILEEXTENTSION%==.epub (
        Echo "This is not an ePub file."    
        
     ) ELSE ( 

        Echo "This is an ePub file."
        
        START /wait "" %KINDLEGENBIN% "%SOURCEFILE%" -o "%DESTINATIONFILENAME%"
        
            IF EXIST "%DESTINATIONFILE%" (
            
                Echo "Mobi is created"
                
                MOVE /-Y "%DESTINATIONFILE%" "%DESTINATIONFILEINARCHIVE%"
                MOVE /-Y "%SOURCEFILE%" "%TARGETEPUB%\%ORIGINALFILENAMEWITHEXT%"

                
                IF EXIST "%DESTINATIONFILEINARCHIVE%" (

                        Echo "Mobi is moved."       
                        START /wait "" %OUTLOOKBIN% /c ipm.note /m %MYKINDLEMAIL% /a "%DESTINATIONFILEINARCHIVE%"
                        
                        ) ELSE (
                            Echo "Mobi is NOT moved."
                        )               
                                
            ) ELSE (  
            
                Echo "Mobi is NOT created"
            )

     )

PAUSE
