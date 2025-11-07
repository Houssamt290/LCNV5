@echo off
REM ---- Lancer le serveur Flask ----
start "" python app.py
REM ---- Attendre 3 secondes pour que le serveur démarre ----
timeout /t 3 /nobreak >nul
REM ---- Ouvrir ESCOMPTE dans le navigateur ----
start "" "http://localhost:5000/"
REM ---- Fin du script ----
exit
