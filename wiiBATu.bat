@echo off

:: Uses curl, which is available free at https://curl.haxx.se

curl -O https://raw.githubusercontent.com/opendata26/wiiBATu/master/wiiBATu.bat
cls

::install git if it isnt installed already
if not exist git (
  echo Now downloading git and 7zip. This might take a while.
  curl -LO https://github.com/opendata26/opendata26.github.io/raw/master/7za.exe
  curl -LOk https://github.com/git-for-windows/git/releases/download/v2.10.2.windows.1/PortableGit-2.10.2-64-bit.7z.exe
  7za x PortableGit-2.10.2-64-bit.7z.exe -o%~dp0/git
  del PortableGit-2.10.2-64-bit.7z.exe
  cd git
  git-bash.exe --no-needs-console --hide --no-cd --command=post-install.bat
  cd %~dp0/
  mkdir temp
  mkdir appcache
  mkdir for_sd
  mkdir for_sd\wiiu
  copy 7za.exe temp\
  copy curl.exe temp\
  copy curl.exe appcache\
  copy 7za.exe appcache\
  cls
)
if not exist C:\python27 (
  curl -LO https://www.python.org/ftp/python/2.7.12/python-2.7.12.msi
  echo Now installing python.
  set /p tmp="Press any key to install python, Make sure you select add to path"
  python-2.7.12.msi
  del python-2.7.12.msi
  mkdir temp
  mkdir appcache
  mkdir for_sd
  mkdir for_sd\wiiu
  copy 7za.exe temp\
  copy curl.exe temp\
  copy curl.exe appcache\
  copy 7za.exe appcache\
  cls
)

mkdir temp
mkdir appcache
mkdir for_sd
mkdir for_sd\wiiu
copy 7za.exe temp\
copy curl.exe temp\
copy curl.exe appcache\
copy 7za.exe appcache\
cls


::add git too path temporaryly
set gitdir=%~dp0/git
set path=%gitdir%\cmd;%path%

::Datebase for hombrew

::Url for getting zips from
set zipsurl=http://www.wiiubru.com/appstore/zips/

::Define zip file name
set otp2sd=otp2sd.zip
set hblzip=homebrew_launcher.zip
set wupyzip=wupymod.zip
set hbaszip=appstore.zip
set hbldarkzip=hbl_dark.zip
set ftpiiuzip=ftpiiu.zip
set ftpiiueverywherezip=ftpiiu_everywhere.zip
set cfwbooterzip=cfwbooter.zip
set ourloaderzip=ourloader.zip
set saviinezip=saviine.zip
set ftpiiuezip=ftpiiu_everywhere.zip
set geckiinezip=geckiine.zip
set ft2sdzip=ft2sd.zip
set fsdumperzip=fsdumper.zip
set wuphaxzip=wuphax.zip
set haxchizip=haxchi.zip

::Define presets
set simple={%otp2sd%,%hblzip%,%wupyzip%,%hbaszip%}
set simple_dark={%otp2sd%,%hbldarkzip%,%wupyzip%,%hbaszip%}
set conventional={%otp2sd%,%hblzip%,%wupyzip%,%hbaszip%,%ftpiiuzip%,%cfwbootzip%,%ourloaderzip%,%saviinezip%}
set conventional_dark={%otp2sd%,%hbldarkzip%,%wupyzip%,%hbaszip%,%ftpiiuzip%,%cfwbooterzip%,%ourloaderzip%,%saviinezip%}
set hacker={%otp2sd%,%hbldarkzip%,%wupyzip%,%hbaszip%,%ftpiiuzip%,%cfwbooterzip%,%ourloaderzip%,%saviinezip%,%ftpiiueverywherezip%,%geckiinezip%,%ft2sdzip%,%fsdumperzip%}
set hacker_light={%otp2sd%,%hblzip%,%wupyzip%,%hbaszip%,%ftpiiuzip%,%cfwbooterzip%,%ourloaderzip%,%saviinezip%,%ftpiiueverywherezip%,%geckiinezip%,%ft2sdzip%,%fsdumperzip%}
::Database end

echo Version 1.2
echo Wupserver is also known as sigpatched sysnand.
pause
:start
cls
cd %~dp0/
echo An all in one script for wiiu things.
echo What would you like to do?
echo 1: Setup SDcard
echo 2: Prepare things to compile rednand and wupserver
echo 3: Download / Update rednand and wupserver
echo 4: Compile wupserver and rednand
echo 5: Install haxchi
echo 6: Install regionhax
echo 7: Install wuphax
echo 8: Exit
set /p choice="What do you want to do: "

if %choice%==1 goto prepare_sd
if %choice%==2 goto prepare_env
if %choice%==3 goto download
if %choice%==4 goto compile
if %choice%==5 goto haxchi_select
if %choice%==6 goto regionhax
if %choice%==7 goto wuphax_select
if %choice%==8 goto exit

:prepare_sd
cls
echo 'What homebrew preset would you like to install, You will be able to install emulators and games from the homebrew appstore. They all include otp2sd as its needed later'
echo '1: Simple (Hombrew launcher, WUP Installer Y Mod, Hombrew App Store)'
echo '2: Simple Dark (Hombrew launcher Dark, WUP Installer Y Mod, Hombrew App Store)'
echo '3: Conventional (Hombrew launcher, WUP Installer Y Mod, Hombrew App Store, Ftpiiu, CFW Booter, OurLoader, Saviine)'
echo '4: Conventional Dark (Hombrew launcher Dark, WUP Installer Y Mod, Hombrew App Store, Ftpiiu, CFW Booter, OurLoader, Saviine)'
echo '5: Hacker (Everything in Conventional Dark + Ftpiiu Everywhere, Geckiine, FT2SD, FS Dumper)'
echo '6: Hacker Light (Everything in Conventional + Ftpiiu Everywhere, Geckiine, FT2SD, FS Dumper)'
set /p  preset_choice="What preset do you want: "
cd appcache
if %preset_choice% == 1 curl --remote-name-all -e "http://www.wiiubru.com" %zipsurl%%simple%
if %preset_choice% == 2 curl --remote-name-all -e "http://www.wiiubru.com" %zipsurl%%simple_dark%
if %preset_choice% == 3 curl --remote-name-all -e "http://www.wiiubru.com" %zipsurl%%conventional%
if %preset_choice% == 4 curl --remote-name-all -e "http://www.wiiubru.com" %zipsurl%%conventional_dark%
if %preset_choice% == 5 curl --remote-name-all -e "http://www.wiiubru.com" %zipsurl%%hacker%
if %preset_choice% == 6 curl --remote-name-all -e "http://www.wiiubru.com" %zipsurl%%hacker_light%
7za x *.zip -o%~dp0\for_sd\wiiu
echo put everything in the for_sd folder onto your sdcard
pause
goto start

:prepare_env
cls
cd temp
curl -LO https://github.com/opendata26/armips/releases/download/9.0/armips.exe
curl -LOk "https://sourceforge.net/projects/devkitpro/files/Automated Installer/devkitProUpdater-1.6.0.exe"
echo Files downloaded successfully! Now installing programs.
echo Now installing python and pycrypto. Check the add python to PATH box and click the install now button to install.
set /p tmp="Press any key to pycrypto"
C:\python27\python.exe -m pip install --use-wheel --no-index --find-links=https://bitbucket.org/alexandrul/wheels/downloads/pycrypto-2.6.1-cp27-none-win32.whl pycrypto
echo Now installing devkitarm and armips. Use default options until the choose components screen where you should untick everything except devkitarm and minimal system
set /p tmp="Press any key to install devkitarm and armips"
devkitProUpdater-1.6.0.exe
copy armips.exe C:\devkitPro\msys\bin
echo done!
pause
goto start

:download
cls
if exist iosuhax (
  cd iosuhax
  git pull
  pause
) else (
  git clone https://github.com/dimok789/iosuhax.git
  echo Please put your otp.bin dumped with otp2sd, which is included in all the app presets, in the same directory as this batch file and hit enter.
  pause
  cd iosuhax/bin
  C:\python27\python.exe getfwimg.py
  echo if you get eny errors you need to redump your otp.bin
  pause
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

:haxchi_select
cls
echo 1: Use HBL Method (Recomended, Haxchi game cant be on USB)
echo 2: Use WupServer Method (Needs you to launch wupserver from cfwbooter)
set /p haxchi_choice="What would you like to do: "
if %haxchi_choice% == 1 goto haxchi_hbl
if %haxchi_choice% == 2 goto haxchi_wupserv

:haxchi_hbl
cls
cd appcache
curl -LO https://github.com/FIX94/haxchi/releases/download/v2.2u1/Haxchi_v2.2u1.zip
curl -LO https://github.com/opendata26/opendata26.github.io/raw/master/config.txt
7za x Haxchi_v2.2u1.zip -o%~dp0\for_sd\
copy config.txt %~dp0\for_sd\haxchi\
echo Make sure you have unplugged all usbs from your wiiu then put all the things in the for_sd folder on your sd.
echo Put your sd in your wiiu and run the Haxchi Installer in homebrew launcher, select the game you want to install it on and you are done.
pause
echo The button map is as follows:
echo Hold A when booting haxchi to launch WupServer
echo Hold B when booting haxchi to launch redNAND
echo Do nothing when booting haxchi to launch HBL
pause
goto start

:haxchi_wupserv
cls
cd %~dp0/temp
echo Downloading required files
curl -LO https://github.com/vickdu31/Haxchi_Installer/archive/master.zip
7za x master.zip
rm master.zip
cd Haxchi_Installer-master
echo Now running haxchi installer python script.
C:\python27\python.exe haxchi_installer_v1.2.py
echo done!
pause
goto start

:regionhax
cls
cd %~dp0/temp
echo Downloading required files
curl -LO https://github.com/opendata26/regionHAX-installer/archive/master.zip
7za x master.zip
rm master.zip
cd regionHAX-installer-master
echo Now running regionHAX installer python script.
C:\python27\python.exe regionhax_installer_v1.0.py
echo done!
pause
goto start


:wuphax_select
cls
echo 1: Use HBL Method (Recomended)
echo 2: Use WupServer Method (Needs you to launch wupserver from cfwbooter)
set /p wuphax_choice="What would you like to do: "
if %wuphax_choice% == 1 goto wuphax_hbl
if %wuphax_choice% == 2 goto wuphax_wupserv

:wuphax_hbl
cls
cd appcache
curl -Oe "http://www.wiiubru.com" %zipsurl%%wuphaxzip%
7za x wuphax.zip -o%~dp0\for_sd\wiiu
cd %~dp0\temp\
curl -LO "https://github.com/opendata26/opendata26.github.io/raw/master/boot.elf"
copy boot.elf %~dp0\for_sd\
echo Make sure you have unplugged all usbs from your wiiu then put all the things in the for_sd folder on your sd.
echo Put your sd into your wiiu and boot wuphax from hbl. Follow the instructions and when your wiiu reboots run mii maker in vwii.
pause
goto start

:wuphax_wupserv
cls
cd temp
curl -LO  https://github.com/opendata26/wuphax/releases/download/1.2/wuphax.zip
7za x wuphax.zip
cd wuphax
C:\python27\python.exe ip.py
C:\python27\python.exe backup.py
C:\python27\python.exe injectdol.py
C:\python27\python.exe writedol.py
echo Shut down your wiiu, unplug its power, make sure that no usb devices are currently plugged into your wiiu, replug it and go
echo into wii mode. In wii mode, run the mii channel, this should start hackmii install the homebrew channel from there.
pause
goto start



:exit
rmdir temp /s /q
exit
