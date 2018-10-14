@echo off
rem This script adds metadata to the individual tracks and mix them.

rem ------------------------------------------------------------
rem Beginning of parameters
rem ------------------------------------------------------------

SET title=Cool Song
SET album=Teach tracks
SET year=2018
SET genre=Teach tracks

rem input files
SET in_base=raw/Cool Song
SET in_fext=.flac
SET in_soprano=%in_base%-Soprano%in_fext%
SET in_alto=%in_base%-Alto%in_fext%
SET in_tenor=%in_base%-Tenor%in_fext%
SET in_bass=%in_base%-Bass%in_fext%

rem output files
SET out_base=Cool Song
SET out_fext=.ogg
SET out_soprano=%out_base% - Soprano%out_fext%
SET out_alto=%out_base% - Alto%out_fext%
SET out_tenor=%out_base% - Tenor%out_fext%
SET out_bass=%out_base% - Bass%out_fext%
SET out_soprano_dom=%out_base% - Soprano Dominant%out_fext%
SET out_alto_dom=%out_base% - Alto Dominant%out_fext%
SET out_tenor_dom=%out_base% - Tenor Dominant%out_fext%
SET out_bass_dom=%out_base% - Bass Dominant%out_fext%
SET out_all=%out_base% - All parts%out_fext%

rem mixing weights
SET dom_w=150
SET nondom_w=50

rem ------------------------------------------------------------
rem End of parameters
rem ------------------------------------------------------------

ffmpeg -y ^
-i "%in_soprano%" ^
-metadata title="%title% - Soprano" ^
-metadata album="%album%" ^
-metadata year="%year%" ^
-metadata genre="%genre%" ^
"%out_soprano%"

ffmpeg -y ^
-i "%in_alto%" ^
-metadata title="%title% - Alto" ^
-metadata album="%album%" ^
-metadata year="%year%" ^
-metadata genre="%genre%" ^
"%out_alto%"

ffmpeg -y ^
-i "%in_tenor%" ^
-metadata title="%title% - Tenor" ^
-metadata album="%album%" ^
-metadata year="%year%" ^
-metadata genre="%genre%" ^
"%out_tenor%"

ffmpeg -y ^
-i "%in_bass%" ^
-metadata title="%title% - Bass" ^
-metadata album="%album%" ^
-metadata year="%year%" ^
-metadata genre="%genre%" ^
"%out_bass%"

ffmpeg -y ^
-i "%in_soprano%" -i "%in_alto%" -i "%in_tenor%" -i "%in_bass%" ^
-filter_complex "amix=inputs=4:duration=first:dropout_transition=3:weights=%dom_w% %nondom_w% %nondom_w% %nondom_w%" ^
-metadata title="%title% - Soprano Dominant" ^
-metadata album="%album%" ^
-metadata year="%year%" ^
-metadata genre="%genre%" ^
"%out_soprano_dom%"

ffmpeg -y ^
-i "%in_soprano%" -i "%in_alto%" -i "%in_tenor%" -i "%in_bass%" ^
-filter_complex "amix=inputs=4:duration=first:dropout_transition=3:weights=%nondom_w% %dom_w% %nondom_w% %nondom_w%" ^
-metadata title="%title% - Alto Dominant" ^
-metadata album="%album%" ^
-metadata year="%year%" ^
-metadata genre="%genre%" ^
"%out_alto_dom%"

ffmpeg -y ^
-i "%in_soprano%" -i "%in_alto%" -i "%in_tenor%" -i "%in_bass%" ^
-filter_complex "amix=inputs=4:duration=first:dropout_transition=3:weights=%nondom_w% %nondom_w% %dom_w% %nondom_w%" ^
-metadata title="%title% - Tenor Dominant" ^
-metadata album="%album%" ^
-metadata year="%year%" ^
-metadata genre="%genre%" ^
"%out_tenor_dom%"

ffmpeg -y ^
-i "%in_soprano%" -i "%in_alto%" -i "%in_tenor%" -i "%in_bass%" ^
-filter_complex "amix=inputs=4:duration=first:dropout_transition=3:weights=%nondom_w% %nondom_w% %nondom_w% %dom_w%" ^
-metadata title="%title% - Bass Dominant" ^
-metadata album="%album%" ^
-metadata year="%year%" ^
-metadata genre="%genre%" ^
"%out_bass_dom%"

ffmpeg -y ^
-i "%in_soprano%" -i "%in_alto%" -i "%in_tenor%" -i "%in_bass%" ^
-filter_complex "amix=inputs=4:duration=first:dropout_transition=3" ^
-metadata title="%title% - All parts" ^
-metadata album="%album%" ^
-metadata year="%year%" ^
-metadata genre="%genre%" ^
"%out_all%"

