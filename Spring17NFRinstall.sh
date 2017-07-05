#!/bin/bash
echo "======================================"
echo "||Instalation of Avid Plugins for HD||"
echo "======================================"
echo
if [[ $UID != 0 ]]; then
    echo "Execute this script as ROOT user:"
    echo "sudo $0 $*"
    echo
    exit 1
fi
echo
echo “Mounting DMGs files…”
find ./ -name '*.dmg' -exec sh -c 'hdiutil attach -nobrowse -noverify "$0"' {} \;

installer -pkg /Volumes/Flanger\ Plug-In/Install\ Flanger.pkg -target /
installer -pkg /Volumes/Pro\ Multiband\ Dynamics\ Plug-In/Install\ Pro\ Multiband\ Dynamics.pkg -target /
installer -pkg /Volumes/Tel-Ray\ Variable\ Delay\ Plug-In/Install\ Tel-Ray\ Variable\ Delay.pkg -target /
installer -pkg /Volumes/Reel\ Tape\ Suite\ Plug-In/Install\ Reel\ Tape\ Suite.pkg -target /
installer -pkg /Volumes/Eleven\ Plug-In/Install\ Eleven.pkg -target /
installer -pkg /Volumes/ReVibe\ Plug-In/Install\ ReVibe.pkg -target /
installer -pkg /Volumes/Impact\ Plug-In/Install\ Impact.pkg -target /
installer -pkg /Volumes/Smack!\ Plug-In/Install\ Smack!.pkg -target /
installer -pkg /Volumes/Black\ Shiny\ Wah\ Plug-In/Install\ Black\ Shiny\ Wah.pkg -target /
installer -pkg /Volumes/Eleven\ MK\ II\ Plug-In/Install\ Eleven\ MK\ II.pkg -target /
installer -pkg /Volumes/Pro\ Expander\ Plug-In/Install\ Pro\ Expander.pkg -target /
installer -pkg /Volumes/Pultec\ Bundle\ Plug-In/Install\ Pultec\ Bundle.pkg -target /
installer -pkg /Volumes/moogerfooger\ Bundle\ Plug-In/Install\ moogerfooger\ Bundle.pkg -target /
installer -pkg /Volumes/JOEMEEK\ Bundle\ Plug-In/Install\ JOEMEEK\ Bundle.pkg -target /
installer -pkg /Volumes/Studio\ Reverb\ Plug-In/Install\ Studio\ Reverb.pkg -target /
installer -pkg /Volumes/XPand\ II\ Plug-In/Install\ XPand\ II.pkg -target /
installer -pkg /Volumes/BBD\ Delay\ Plug-In/Install\ BBD\ Delay.pkg -target /
installer -pkg /Volumes/Space\ Plug-In/Install\ Space.pkg -target /
installer -pkg /Volumes/Reverb\ One\ Plug-In/Install\ Reverb\ One.pkg -target /
installer -pkg /Volumes/Tape\ Echo\ Plug-In/Install\ Tape\ Echo.pkg -target /
installer -pkg /Volumes/Vibe\ Phaser\ Plug-In/Install\ Vibe\ Phaser.pkg -target /
installer -pkg /Volumes/Graphic\ EQ\ Plug-In/Install\ Graphic\ EQ.pkg -target /
installer -pkg /Volumes/Green\ JRC\ Overdrive\ Plug-In/Install\ Green\ JRC\ Overdrive.pkg -target /
installer -pkg /Volumes/Pro\ Compressor\ Plug-In/Install\ Pro\ Compressor.pkg -target /
installer -pkg /Volumes/Pro\ Subharmonic\ Plug-In/Install\ Pro\ Subharmonic.pkg -target /
installer -pkg /Volumes/Pro\ Limiter\ Plug-In/Install\ Pro\ Limiter.pkg -target /
installer -pkg /Volumes/C1\ Chorus\ Plug-In/Install\ C1\ Chorus.pkg -target /
installer -pkg /Volumes/DC\ Distortion\ Plug-In/Install\ DC\ Distortion.pkg -target /
installer -pkg /Volumes/Orange\ Phaser\ Plug-In/Install\ Orange\ Phaser.pkg -target /
installer -pkg /Volumes/White\ Boost\ Plug-In/Install\ White\ Boost.pkg -target /
installer -pkg /Volumes/Gray\ Compressor\ Plug-In/Install\ Gray\ Compressor.pkg -target /
installer -pkg /Volumes/Tri-Knob\ Fuzz\ Plug-In/Install\ Tri-Knob\ Fuzz.pkg -target /
installer -pkg /Volumes/X-Form\ Plug-In/Install\ X-Form.pkg -target /
installer -pkg /Volumes/Classic\ Compressors\ Plug-In/Install\ Classic\ Compressors.pkg -target /
installer -pkg /Volumes/Black\ Spring\ Plug-In/Install\ Black\ Spring.pkg -target /
installer -pkg /Volumes/Black\ Op\ Distortion\ Plug-In/Install\ Black\ Op\ Distortion.pkg -target /
installer -pkg /Volumes/Roto\ Speaker\ Plug-In/Install\ Roto\ Speaker.pkg -target /
installer -pkg /Volumes/Focusrite\ d2-d3\ Plug-In/Install\ Focusrite\ d2-d3.pkg -target /


ALL_DMGs="$(df -h | awk '{print $1}' | grep -i dev/)"

for current_disk in $ALL_DMGs
do
  DISK_TYPE="$(diskutil info $current_disk | grep -i protocol | awk '{print $3}')"
  
  if [ "$DISK_TYPE" == "Image" ]
  then
    DMGs_ONLY="$DMGs_ONLY $current_disk"
  fi
done

for current_disk in $DMGs_ONLY
do
  hdiutil detach ${current_disk}
done

echo "======================================"
echo "||Instalation of ProTools||"
echo "======================================"
echo
if [[ $UID != 0 ]]; then
    echo "Execute this script as ROOT user:"
    echo "sudo $0 $*"
    echo
    exit 1
fi
echo
echo “Mounting DMGs files…”
find ./ -name '*.dmg' -exec sh -c 'hdiutil attach -nobrowse -noverify "$0"' {} \;

installer -pkg /Volumes/Pro Tools\ /Install\ Protools\ 12.7.0.pkg -target /

ALL_DMGs="$(df -h | awk '{print $1}' | grep -i dev/)"

for current_disk in $ALL_DMGs
do
  DISK_TYPE="$(diskutil info $current_disk | grep -i protocol | awk '{print $3}')"
  
  if [ "$DISK_TYPE" == "Image" ]
  then
    DMGs_ONLY="$DMGs_ONLY $current_disk"
  fi
done

for current_disk in $DMGs_ONLY
do
  hdiutil detach ${current_disk}
done

# Copy the com.avid.bsd.ShoeTool Helper Tool
PHT_SHOETOOL="/Library/PrivilegedHelperTools/com.avid.bsd.shoetoolv120"
 
/bin/cp -f "/Applications/Pro Tools.app/Contents/Library/LaunchServices/com.avid.bsd.shoetoolv120" $PHT_SHOETOOL
/usr/sbin/chown root:wheel $PHT_SHOETOOL
/bin/chmod 544 $PHT_SHOETOOL
 
# Create the Launch Deamon Plist for com.avid.bsd.ShoeTool
PLIST="/Library/LaunchDaemons/com.avid.bsd.shoetoolv120.plist"
FULL_PATH="/Library/PrivilegedHelperTools/com.avid.bsd.shoetoolv120"
 
rm $PLIST # Make sure we are idempotent
 
/usr/libexec/PlistBuddy -c "Add Label string" $PLIST
/usr/libexec/PlistBuddy -c "Set Label com.avid.bsd.shoetoolv120" $PLIST
 
/usr/libexec/PlistBuddy -c "Add MachServices dict" $PLIST
/usr/libexec/PlistBuddy -c "Add MachServices:com.avid.bsd.shoetoolv120 bool" $PLIST
/usr/libexec/PlistBuddy -c "Set MachServices:com.avid.bsd.shoetoolv120 true" $PLIST
 
/usr/libexec/PlistBuddy -c "Add ProgramArguments array" $PLIST
/usr/libexec/PlistBuddy -c "Add ProgramArguments:0 string" $PLIST
/usr/libexec/PlistBuddy -c "Set ProgramArguments:0 $FULL_PATH" $PLIST
 
/bin/launchctl load $PLIST

mkdir -p "/Library/Application Support/Avid/Audio/Plug-Ins"
mkdir -p "/Library/Application Support/Avid/Audio/Plug-Ins (Unused)"

chmod a+w "/Library/Application Support/Avid/Audio/Plug-Ins"
chmod a+w "/Library/Application Support/Avid/Audio/Plug-Ins (Unused)"

mkdir /Users/Shared/Pro\ Tools
mkdir /Users/Shared/AvidVideoEngine

chown -R root:wheel /Users/Shared/Pro\ Tools
chmod -R a+rw /Users/Shared/Pro\ Tools
chown -R root:wheel /Users/Shared/AvidVideoEngine
chmod -R a+rw /Users/Shared/AvidVideoEngine

# Get rid of old workspace
rm -rf /Users/Shared/Pro\ Tools/Workspace.wksp

exit 0
exit