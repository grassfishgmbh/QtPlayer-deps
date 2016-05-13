set GYP_DEFINES="proprietary_codecs=1 ffmpeg_branding=Chrome target_arch=x64 buildtype=Official"
set GYP_GENERATORS="ninja,msvs-ninja"
set GYP_MSVS_VERSION="2013"

if not exist .\cef-buildspace mkdir .\cef-buildspace
if not exist .\cef-buildspace\automate-git.py copy automate-git.py .\cef-buildspace\
