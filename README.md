# MAME Overlays 1280x1024
1280x1024 MAME Retroarch overlays for vertical games.

The folder 1280x1024 contains resized overlays resized from 1920x1080 from the Bezel Project for **vertical games only**.

The conversion process consisted of running the batch file `Resize280x1024fromFile.bat` in the overlays folder with the png files. The batch file only converts the files listed in VerticalGames.txt

**Image Magick** (https://imagemagick.org/) needs to be installed on your PC. 

# Usage

To resize a given set of overlays

`Resize1280x1024.bat <overlay_1 overlay_2 ... overlay_n>`

For example, to resize a set of 1920x1080 overlays such as 1941.png 1942.png and bombjack.png to 1280x1024 then:
* Copy the batch file to the location of the same folder as the overlays
* At the command prompt type `Resize1280x1024.bat 1941 1942 bombjack`
* This will generate 3 png files: 1941_1280x1024.png  1941_1280x1024.png bombjack_1280x1024
