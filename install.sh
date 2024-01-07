#!/bin/bash

set -e  # Exit immediately if a command returns a non-zero status

echo "Updating system with Pacman..."
sudo pacman -Syu
echo "System updated successfully!"

echo -n "Do you want to install standard Arch utils? [neofetch, btop, distrobox, yay, firefox, flatpak, pavucontrol, nano, base-devel, git] (y/n): "
read answer

if [ "$answer" = "y" ]; then
  echo "Installing utils..."

  # Install standard Arch utilities
  sudo pacman -S --needed neofetch btop distrobox firefox flatpak nano pavucontrol base-devel git

  # Check if the installation was successful
  echo "Checking installation status..."
  if [ $? -eq 0 ]; then
    echo "Installed utils successfully!"

    # Attempt to install 'yay'
    echo "Attempting to install 'yay'..."
    git clone https://aur.archlinux.org/yay.git

    # Check if the 'yay' clone was successful
    echo "Checking 'yay' installation status..."
    if [ $? -eq 0 ]; then
      cd yay || { echo "Failed to enter 'yay' directory. Installation aborted."; exit 1; }
      makepkg -si
      cd ..
      echo "'yay' installed successfully!"
    else
      echo "Failed to clone 'yay' repository. Installation aborted."
    fi
  else
    echo "Failed to install standard Arch utilities. Installation aborted."
  fi
elif [ "$answer" = "n" ]; then
  echo "Skipping utils installation"
else
  echo "Invalid choice. Please enter 'y' or 'n'."
fi

echo -n "Do you want to install KDE-Plasma? (This will also install yakuake) (y/n): "
read answer

if [ "$answer" = "y" ]; then
  echo "Installing KDE-Plasma..."
  sudo pacman -S plasma yakuake
  echo "KDE-Plasma installation complete."
elif [ "$answer" = "n" ]; then
  echo "Skipping KDE-Plasma installation."
else
  echo "Invalid choice. Please enter 'y' or 'n'."
fi

echo -n "Do you want to install SDDM? (y/n): "
read answer

if [ "$answer" = "y" ]; then
  echo "Installing SDDM..."
  sudo pacman -S sddm

  # Check if the installation was successful
  echo "Checking installation status..."
  if [ $? -eq 0 ]; then
    echo "Enabling sddm.service..."
    sudo systemctl enable sddm.service
  else
    echo "Failed to install SDDM. Installation aborted."
  fi
elif [ "$answer" = "n" ]; then
  echo "Skipping SDDM installation."
else
  echo "Invalid choice. Please enter 'y' or 'n'."
fi
