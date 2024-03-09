@echo off 
AnyDesk.exe --install "C:\Program Files (x86)\AnyDesk" --start-with-win --silent --create-shortcuts --create-desktop-icon 
echo licence_keyABC | "C:\Windows\system32\config\systemprofile\AnyDesk.exe" --register-licence 
echo password123 | "C:\Windows\system32\config\systemprofile\AnyDesk.exe" --set-password
