REM Resize 1920x1080 Mame overlay to 1280x1024.
REM Pass a list of overlays without the extension e.g. 1942
REM Requires Image Magick installed for image processing

@echo off

REM One png file as a minimum is needed
IF %1.==. GOTO No1

REM Let's keep track of the operations
set argCount=0
set argCountGood=0
set argCountBad=0

REM Process all the overlays in the arguments
for %%x in (%*) do (

	echo processing %%~x.png

	set /A argCount+=1

	IF EXIST %%~x.png (

		REM 1. Resize the image to the correct size 1280x1024
		REM 2. Crop into 2 equal tiles (left &right)
		REM 3. Resize the tiles by 0.666 (=1920/1280)
		magick %%~x.png -resize 1280x1024\! -crop 2x1@ -resize 426x1024\! %%~x.png

		REM 4. We need to increase the emulator view by introducing a transparency of size 428 so that 1280 = 426+428+426
		magick convert -size 428x1024 xc:transparent transparent.png

		REM 5. Rebuild final image by stiching the tiles
		magick montage -mode concatenate -tile 3x %%~x-0.png transparent.png %%~x-1.png -background none %%~x_1280x1024.png

		REM Delete all the temporary files
		del transparent.png
		del %%~x-0.png
		del %%~x-1.png

		echo created %%~x_1280x1024.png
		set /A argCountGood+=1
	
	) ELSE (

    	echo %%~x.png not found!
		set /A argCountBad+=1
	)
)

echo Number of processed files %argCount%
echo Number of written files   %argCountGood%
echo Number of failed files    %argCountBad%

GOTO Exit:

:No1
  	echo Error! Batch file needs at least one argument (e.g. 1942 = overlay filename without png extension)!

:Exit
	echo Done!
