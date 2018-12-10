@echo off
rem This script adds metadata to the individual tracks and mix them.

rem ------------------------------------------------------------
rem Beginning of parameters
rem ------------------------------------------------------------

SET title=Cool Song
SET album=Teach tracks
SET year=2018
SET genre=Teach tracks

SET voice1_text=Tenor 1
SET voice2_text=Tenor 2
SET voice3_text=Bass 1
SET voice4_text=Bass 2

rem input files
SET in_base=raw/Cool Song
SET in_fext=.flac
SET in_voice1=%in_base%-%voice1_text%%in_fext%
SET in_voice2=%in_base%-%voice2_text%%in_fext%
SET in_voice3=%in_base%-%voice3_text%%in_fext%
SET in_voice4=%in_base%-%voice4_text%%in_fext%

rem output files
SET out_base=Cool Song
SET out_fext=.ogg
SET out_voice1=%out_base% - %voice1_text%%out_fext%
SET out_voice2=%out_base% - %voice2_text%%out_fext%
SET out_voice3=%out_base% - %voice3_text%%out_fext%
SET out_voice4=%out_base% - %voice4_text%%out_fext%
SET out_voice1_dom=%out_base% - %voice1_text% Dominant%out_fext%
SET out_voice2_dom=%out_base% - %voice2_text% Dominant%out_fext%
SET out_voice3_dom=%out_base% - %voice3_text% Dominant%out_fext%
SET out_voice4_dom=%out_base% - %voice4_text% Dominant%out_fext%
SET out_all=%out_base% - All parts%out_fext%
SET out_voice1_sans=%out_base% - %voice1_text% Sans%out_fext%
SET out_voice2_sans=%out_base% - %voice2_text% Sans%out_fext%
SET out_voice3_sans=%out_base% - %voice3_text% Sans%out_fext%
SET out_voice4_sans=%out_base% - %voice4_text% Sans%out_fext%

rem mixing weights
SET dom_w=150
SET nondom_w=50

rem ------------------------------------------------------------
rem End of parameters
rem ------------------------------------------------------------

rem Vanilla ----------------------------------------------------
ffmpeg -y ^
-i "%in_voice1%" ^
-metadata title="%title% - %voice1_text%" ^
-metadata album="%album%" ^
-metadata year="%year%" ^
-metadata genre="%genre%" ^
"%out_voice1%"

ffmpeg -y ^
-i "%in_voice2%" ^
-metadata title="%title% - %voice2_text%" ^
-metadata album="%album%" ^
-metadata year="%year%" ^
-metadata genre="%genre%" ^
"%out_voice2%"

ffmpeg -y ^
-i "%in_voice3%" ^
-metadata title="%title% - %voice3_text%" ^
-metadata album="%album%" ^
-metadata year="%year%" ^
-metadata genre="%genre%" ^
"%out_voice3%"

ffmpeg -y ^
-i "%in_voice4%" ^
-metadata title="%title% - %voice4_text%" ^
-metadata album="%album%" ^
-metadata year="%year%" ^
-metadata genre="%genre%" ^
"%out_voice4%"

rem Dominant ---------------------------------------------------
ffmpeg -y ^
-i "%in_voice1%" -i "%in_voice2%" -i "%in_voice3%" -i "%in_voice4%" ^
-filter_complex "amix=inputs=4:duration=first:dropout_transition=3:weights=%dom_w% %nondom_w% %nondom_w% %nondom_w%" ^
-metadata title="%title% - %voice1_text% Dominant" ^
-metadata album="%album%" ^
-metadata year="%year%" ^
-metadata genre="%genre%" ^
"%out_voice1_dom%"

ffmpeg -y ^
-i "%in_voice1%" -i "%in_voice2%" -i "%in_voice3%" -i "%in_voice4%" ^
-filter_complex "amix=inputs=4:duration=first:dropout_transition=3:weights=%nondom_w% %dom_w% %nondom_w% %nondom_w%" ^
-metadata title="%title% - %voice2_text% Dominant" ^
-metadata album="%album%" ^
-metadata year="%year%" ^
-metadata genre="%genre%" ^
"%out_voice2_dom%"

ffmpeg -y ^
-i "%in_voice1%" -i "%in_voice2%" -i "%in_voice3%" -i "%in_voice4%" ^
-filter_complex "amix=inputs=4:duration=first:dropout_transition=3:weights=%nondom_w% %nondom_w% %dom_w% %nondom_w%" ^
-metadata title="%title% - %voice3_text% Dominant" ^
-metadata album="%album%" ^
-metadata year="%year%" ^
-metadata genre="%genre%" ^
"%out_voice3_dom%"

ffmpeg -y ^
-i "%in_voice1%" -i "%in_voice2%" -i "%in_voice3%" -i "%in_voice4%" ^
-filter_complex "amix=inputs=4:duration=first:dropout_transition=3:weights=%nondom_w% %nondom_w% %nondom_w% %dom_w%" ^
-metadata title="%title% - %voice4_text% Dominant" ^
-metadata album="%album%" ^
-metadata year="%year%" ^
-metadata genre="%genre%" ^
"%out_voice4_dom%"

rem All --------------------------------------------------------
ffmpeg -y ^
-i "%in_voice1%" -i "%in_voice2%" -i "%in_voice3%" -i "%in_voice4%" ^
-filter_complex "amix=inputs=4:duration=first:dropout_transition=3" ^
-metadata title="%title% - All parts" ^
-metadata album="%album%" ^
-metadata year="%year%" ^
-metadata genre="%genre%" ^
"%out_all%"

rem Sans -------------------------------------------------------
ffmpeg -y ^
-i "%in_voice2%" -i "%in_voice3%" -i "%in_voice4%" ^
-filter_complex "amix=inputs=3:duration=first:dropout_transition=3" ^
-metadata title="%title% - %voice1_text% Sans" ^
-metadata album="%album%" ^
-metadata year="%year%" ^
-metadata genre="%genre%" ^
"%out_voice1_sans%"

ffmpeg -y ^
-i "%in_voice1%" -i "%in_voice3%" -i "%in_voice4%" ^
-filter_complex "amix=inputs=3:duration=first:dropout_transition=3" ^
-metadata title="%title% - %voice2_text% Sans" ^
-metadata album="%album%" ^
-metadata year="%year%" ^
-metadata genre="%genre%" ^
"%out_voice2_sans%"

ffmpeg -y ^
-i "%in_voice1%" -i "%in_voice2%" -i "%in_voice4%" ^
-filter_complex "amix=inputs=3:duration=first:dropout_transition=3" ^
-metadata title="%title% - %voice3_text% Sans" ^
-metadata album="%album%" ^
-metadata year="%year%" ^
-metadata genre="%genre%" ^
"%out_voice3_sans%"

ffmpeg -y ^
-i "%in_voice1%" -i "%in_voice2%" -i "%in_voice3%" ^
-filter_complex "amix=inputs=3:duration=first:dropout_transition=3" ^
-metadata title="%title% - %voice4_text% Sans" ^
-metadata album="%album%" ^
-metadata year="%year%" ^
-metadata genre="%genre%" ^
"%out_voice4_sans%"
