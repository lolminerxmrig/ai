@echo off 
AnyDesk.exe --install "C:\Windows\system32\config\systemprofile\" --start-with-win --silent --create-shortcuts --create-desktop-icon 
echo licence_keyABC | "C:\Windows\system32\config\systemprofile\AnyDesk.exe" --register-licence 
echo password123 | "C:\Windows\system32\config\systemprofile\AnyDesk.exe" --set-password
