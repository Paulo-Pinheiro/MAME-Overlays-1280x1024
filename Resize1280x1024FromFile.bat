REM Resize 1920x1080 Mame overlay to 1280x1024 from VerticalGames.txt list

@echo off

set argCount=0
set argCountGood=0
set argCountBad=0

:: For each game in the file resize the overlay
FOR /F %%i IN (VerticalGames.txt) DO (

	echo processing %%i.png

	set /A argCount+=1

	IF EXIST %%i.png (

		magick %%i.png -resize 1280x1024\! -crop 2x1@ -resize 426x1024\! %%i.png
		magick convert -size 428x1024 xc:transparent transparent.png
		magick montage -mode concatenate -tile 3x %%i-0.png transparent.png %%i-1.png -background none %%i_1280x1024.png

		del transparent.png
		del %%i-0.png
		del %%i-1.png

		echo created %%i_1280x1024.png

		set /A argCountGood+=1
	
	) ELSE (

    	echo %%i.png not found!
		set /A argCountBad+=1
	)
)

echo Number of processed files %argCount%
echo Number of written files   %argCountGood%
echo Number of failed files    %argCountBad%
echo Done!
