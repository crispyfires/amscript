#!/bin/bash
echo "Hi Am! Starting Am\'s Fedora install script now..."
echo "Please run this script as root (like sudo /path/to/script), mmkay?"

# Checking if script is running as root
  if [ $(id -u) -eq 0 ]; then
    return 0
  else
    echo "Error: This script must be run as root."
    exit 1
  fi

# Enable RPM Fusion repos for access to more software (including non-FOSS) and hardware codecs/drivers (like Nvidia drivers or multimedia codecs)
echo "Enabling RPM Fusion repos..."
dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm &&
dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
echo "Finished enabling RPM Fusion repos"

# Install multimedia codescs
# Multimedia codecs are needed for some stuff like watching films, but they're not installed by default due to Fedora's stance on non-FOSS software
echo "Installing multimedia codecs..."
dnf swap --y ffmpeg-free ffmpeg --allowerasing
dnf update -y @multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
dnf update -y @sound-and-video
echo "Multimedia codecs install finished"

# Switch Flatpak repos to the Flathub because Fedora's Flathub repos are outdated a lot of the time and sometimes broken (idk why they even exist or ship by default)
echo "Switching Flatpak repo to Flathub instead of Fedora's..."
dnf install -y flatpak &&
flatpak remote-delete fedora --force 2>/dev/null || true && 
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo && 
flatpak repair &&
flatpak update -y &&
echo "Switching done"

# Internet shit

# Replace Firefox with the Flatpak version
# The Flatpak is directly from upstream, so more up-to-date than the version in Fedora's repositories
echo "Replacing Fedora repository Firefox with the Flatpak from upstream..."
dnf remove -y firefox &&
flatpak install -y org.mozilla.firefox &&
echo "Flatpak Firefox install finished"

# Install Librewolf from Flathub
# Librewolf is a debloated Firefox fork. It has uBlock Origin built in, hardened-by-default, no pesky telemetry, and disables Firefox's annoying AI features. What more could you want?
# Installing both so that you have a backup browser in case Librewolf breaks somehow. I personally use Librewolf.
echo "Installing Librewolf from Flathub..."
flatpak install -y io.gitlab.librewolf-community.Librewolf &&
echo "Librewolf install finished"

# Install Discord from Flathub
echo "Installing Discord from Flathub..."
flatpak install -y com.discordapp.Discord &&
echo "Discord install finished"

# Gaming shit

# Install Steam from RPM Fusion
echo "Installing Steam from RPM Fusion..."
dnf install -y steam &&
echo "Steam install finished"

# Install Protontricks from Flathub
echo "Installing Protontricks from Flathub..."
flatpak install -y io.github.Matoking.protontricks &&
echo "Setting up Protontricks permissions..."
echo "alias protontricks='flatpak run com.github.Matoking.protontricks'" >> ~/.bashrc &&
echo "alias protontricks-launch='flatpak run --command=protontricks-launch com.github.Matoking.protontricks'" >> ~/.bashrc &&
echo "Protontricks install finished"

# Install ProtonPlus
# ProtonPlus is a GUI for managing Proton versions in Steam
echo "Installing ProtonPlus from Flathub..."
flatpak install flathub com.vysp3r.ProtonPlus &&
echo "ProtonPlus install finished"

# Productivity shit

# Install OBS Studio from Flathub
echo "Installing OBS Studio from Flathub..."
flatpak install -y org.obsproject.Studio &&
echo "OBS Studio install finished"

# Install Kdenlive from Flathub
# Kdenlive is a basic video editor.
echo "Installing Kdenlive from Flathub..."
flatpak install -y org.kde.kdenlive &&
echo "Kdenlive install finished"

# Replace LibreOffice with the Flatpak version
# The Flatpak is directly from upstream, so more up-to-date than the version in Fedora's repositories.
echo "Replacing Fedora repository LibreOffice with the Flatpak from upstream..."
dnf remove -y libreoffice &&
flatpak install -y org.libreoffice.LibreOffice &&
echo "Flatpak LibreOffice install finished"

# Install Calligra from Flathub
# Calligra is KDE's in-house alternative to LibreOffice. If LibreOffice is classic Microsoft Office, Calligra is Mac Pages. Calligra is less feature rich, but is sleeker and has less distractions.
echo "Installing Calligra from Flathub..."
flatpak install -y org.kde.calligra &&
echo "Calligra install finished"

# Utilities

# Install Bottles
# Bottles is a GUI for running Windows applications in a containerised environment
echo "Installing Bottles from Flathub..."
flatpak install -y com.usebottles.bottles &&
echo "Bottles install finished"

# Install Wine
# Wine is a compatibility layer for running Windows applications. Bottles uses Wine under the hood, but I installed it seperately in case you need it.
echo "Installing Wine..."
dnf install -y wine-common wine-mono winetricks &&
echo "Wine install finished"

# Install WineZGUI
# WineZGUI is a GUI for managing Wine prefixes
echo "Installing WineZGUI from Flathub..."
flatpak install -y io.github.fastrizwaan.WineZGUI &&
echo "WineZGUI install finished"

# Install Gear Lever
# Gear Lever is a GUI for managing AppImages.
echo "Installing Gear Lever from Flathub..."
flatpak install -y it.mijorus.gearlever &&
echo "Gear Lever install finished"

# Install Pika Backup
# Pika Backup is a GUI frontend for BorkBackup, which makes and restores backups. It can make backups at specified intervals.
echo "Installing Pika Backup from Flathub..."
flatpak install -y org.gnome.World.PikaBackup &&
echo "Pika Backup install finished"

# Install Sitra
# Sitra is a GUI to download and manage fonts.
echo "Installing Sitra from Flathub..."
flatpak install flathub io.github.sitraorg.sitra &&
echo "Sitra install finished"

# Install Mission Center
# Mission Center is a detailed GUI for viewing system informance
echo "Installing Mission Center from Flathub..."
flatpak install io.missioncenter.MissionCenter &&
echo "Mission Center install finished"

# Install Flatseal
# Flatseal is a GUI for managing Flatpak permissions. 
echo "Installing Flatseal from Flathub..."
flatpak install github.tchx84.Flatseal &&
echo "Flatseal install finished"

# Install Distrobox
# Distrobox is a CLI tool for running other Linux distros in a containerised environment
echo "Installing Distrobox..."
echo "Installing Podman for Distrobox..."
dnf install -y podman &&
echo "Installing Distrobox..." &&
dnf install -y distrobox &&
echo "Distrobox install finished"
echo "Installing Distroshelf from Flathub..." &&
flatpak install flathub com.ranfdev.DistroShelf &&
echo "DistroShelf install finished"
echo "Distrobox and DistroShelf are now installed. You can use Distrobox to run other Linux distros in a containerised environment, and DistroShelf is a GUI for managing your Distrobox containers."
echo "Adding Ubuntu 24 Distrobox..."
distrobox create --image docker.io/library/ubuntu:24.04 --name  ubuntu --hostname "$(uname -n)" &&
echo "Ubuntu 24 Distrobox created. You can enter it with 'distrobox enter ubuntu'"

# Install btrfs-assistant
# btrfs-assistant is a GUI for managing btrfs snapshots to roll back if something breaks.
echo "Installing btrfs-assistant..."
sudo dnf install btrfs-assistant -y &&
echo "btrfs-assistant install finished" &&
echo "Please read this for setup instructions: https://knowledgebase.frame.work/en_us/fedora-system-restore-root-snapshots-using-btrfs-assistant-rkHNxajS3"

# End script
dnf update -y &&
echo "Finished running install script! Please reboot your system now to apply all changes, mmkay?"
echo "Launch the Nvidia script that came with this after you reboot your system."