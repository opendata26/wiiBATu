@echo off


:: Uses curl, which is available free at https://curl.haxx.se
mkdir temp
mkdir appcache
mkdir for_sd
mkdir for_sd\wiiu
cls
curl -LO https://github.com/opendata26/opendata26.github.io/raw/master/7za.exe
copy 7za.exe temp\
copy curl.exe temp\
copy curl.exe appcache\
cls

if not exist git (
  echo Now downloading git and 7zip. This might take a while.
  curl -LO https://github.com/opendata26/opendata26.github.io/raw/master/7za.exe
  copy 7za.exe temp\
  copy 7za.exe appcache\
  curl -LOk https://github.com/git-for-windows/git/releases/download/v2.10.2.windows.1/PortableGit-2.10.2-64-bit.7z.exe
  7za x PortableGit-2.10.2-64-bit.7z.exe -o%~dp0/git
  cd git
  git-bash.exe --no-needs-console --hide --no-cd --command=post-install.bat
)

::add git too path temporaryly
set gitdir=c:\portablegit
set path=%gitdir%\cmd;%path%

::Datebase for hombrew

::Url for getting zips from
set zipsurl=http://www.wiiubru.com/appstore/zips/

::Define zip file name
set hblzip=homebrew_launcher.zip
set wupyzip=wupymod.zip
set hbaszip=appstore.zip
set hbldarkzip=hbldark.zip
set hbasdarkzip=Appstore-dark.zip
set ftpiiuzip=ftpiiu.zip
set cfwbooterzip=cfwbooter.zip
set ourloaderzip=ourloader.zip
set saviinezip=saviine.zip
set ftpiiuezip=ftpiiu_everywhere.zip
set geckiinezip=geckiine.zip
set ft2sdzip=ft2sd.zip
set fsdumperzip=fsdumper.zip

::Define presets
set simple={%hblzip%,%wupyzip%,%hbaszip%}
set simple_dark={%hbldarkzip%,%wupyzip%,%hbasdarkzip%}
set conventional={%hblzip%,%wupyzip%,%hbaszip%,%ftpiiuzip%,%cfwbootzip%,%ourloaderzip%,%saviinezip%}
set conventional_dark={%hbldarkzip%,%wupyzip%,%hbasdarkzip%,%ftpiiuzip%,%cfwbooterzip%,%ourloaderzip%,%saviinezip%}
set hacker={%hbldarkzip%,%wupyzip%,%hbasdarkzip%,%ftpiiuzip%,%cfwbooterzip%,%ourloaderzip%,%saviinezip%,%ftpiiueverywherezip%,%geckiinezip%,%ft2sdzip%,%fsdumperzip%}
set hacker_light={%hblzip%,%wupyzip%,%hbaszip%,%ftpiiuzip%,%cfwbooterzip%,%ourloaderzip%,%saviinezip%,%ftpiiueverywherezip%,%geckiinezip%,%ft2sdzip%,%fsdumperzip%}
::Database end

echo Wupserver is also known as sigpatched sysnand.
pause
:start
cls
cd %~dp0/
echo An all in one script for wiiu things.
echo What would you like to do?
echo 1: Setup SDcard
echo 2: Prepare things to compile rednand / wupserver
echo 3: Download / Update rednand / wupserver
echo 4: Compile wupserver and rednand
echo 5: Install haxchi
echo 6: Exit
set /p choice="What do you want to do: "

if %choice%==1 goto prepare_sd
if %choice%==2 goto prepare_env
if %choice%==3 goto download
if %choice%==4 goto compile
if %choice%==5 goto haxchi
if %choice%==6 goto exit

:prepare_sd
cls
echo 'What homebrew preset would you like to install, You will be able to install emulatoprs and games in the next step.'
echo '1: Simple (Hombrew launcher, WUP Installer Y Mod, Hombrew App Store)'
echo '2: Simple Dark (Hombrew launcher Dark, WUP Installer Y Mod, Hombrew App Store Dark)'
echo '3: Conventional (Hombrew launcher, WUP Installer Y Mod, Hombrew App Store, Ftpiiu, CFW Booter, OurLoader, Saviine)'
echo '4: Conventional Dark (Hombrew launcher Dark, WUP Installer Y Mod, Hombrew App Store Dark, Ftpiiu, CFW Booter, OurLoader, Saviine)'
echo '5: Hacker (Everything in Conventional Dark + Ftpiiu Everywhere, Geckiine, FT2SD, FS Dumper)'
echo '6: Hacker Light (Everything in Conventional + Ftpiiu Everywhere, Geckiine, FT2SD, FS Dumper)'
set /p  preset_choice="What preset do you want: "
@echo off
cd appcache
if %preset_choice% == 1 curl --remote-name-all %zipsurl%%simple%
if %preset_choice% == 2 curl --remote-name-all %zipsurl%%simple_dark%
if %preset_choice% == 3 curl --remote-name-all %zipsurl%%conventional%
if %preset_choice% == 4 curl --remote-name-all %zipsurl%%conventional_dark%
if %preset_choice% == 5 curl --remote-name-all %zipsurl%%hacker%
if %preset_choice% == 6 curl --remote-name-all %zipsurl%%hacker_light%
7za x * -o%~dp0\for_sd
pause
goto start

:prepare_env
cls
cd temp
curl -LO https://github.com/opendata26/armips/releases/download/9.0/armips.exe
curl https://www.python.org/ftp/python/3.5.2/python-3.5.2.exe > python-setup.exe
curl -LOk "https://sourceforge.net/projects/devkitpro/files/Automated Installer/devkitProUpdater-1.6.0.exe"
echo Files downloaded successfully! Now installing programs.
echo Now installing python and pycrypto. Check the add python to PATH box and click the install now button to install.
set /p tmp="Press any key to install python and pycrypto"
python-setup
C:\Users\%USERNAME%\AppData\Local\Programs\Python\Python35-32\python.exe -m pip install --use-wheel --no-index --find-links=https://github.com/sfbahr/PyCrypto-Wheels/raw/master/pycrypto-2.6.1-cp35-none-win32.whl pycrypto
echo Now installing devkitarm and armips. Use default options until the choose components screen where you should untick everything except devkitarm and minimal system
set /p tmp="Press any key to install devkitarm and armips"
devkitProUpdater-1.6.0.exe
copy armips.exe C:\devkitPro\msys\bin
goto start

:download
cls
if exist iosuhax (
  cd iosuhax
  git pull
  pause 1
) else (
  git clone https://github.com/dimok789/iosuhax.git
  echo Please put your otp.bin dumped with http://wiiubru.com/appstore/zips/otp2sd.zip in the same directory as this batch file and hit enter.
  pause
  cd iosuhax/bin
  C:\Users\%USERNAME%\AppData\Local\Programs\Python\Python35-32\python.exe getfwimg.py
)
goto start

:compile
cls
cd %~dp0\iosuhax
make cfw
copy fw.img %~dp0\for_sd\
mkdir %~dp0\for_sd\rednand
make redNAND
copy fw.img %~dp0\for_sd\rednand\
goto start

:haxchi
cls
cd %~dp0/temp
echo Downloading required files
curl -LO https://github.com/opendata26/Haxchi_Installer/archive/master.zip
7za x master.zip
rm master.zip
cd Haxchi_Installer-master
echo Now running haxchi installer python script.
C:\Users\%USERNAME%\AppData\Local\Programs\Python\Python35-32\python.exe haxchi.py
goto start

:exit
rmdir temp /s /q
exit
