#!/bin/bash

# Das Beispielprojekt benötigt eine EXE, die es in ein MSI verpacken kann:
cp ~/.wine/drive_c/windows/system32/netfx_setupverifier.exe ~/wix-project/example.exe

# Nun können wir dem Wix-Toolset sagen, dass es das MSI erzeugen soll
wine ../wix/candle.exe wix-beispiel-projekt.wxs
wine ../wix/light.exe -sval wix-beispiel-projekt.wixobj

# Jetzt noch probieren ob das neue MSI auch wirklich installiert werden kann
wine msiexec /l*vx install.log /i wix-beispiel-projekt.msi /q
