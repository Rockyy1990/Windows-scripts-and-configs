@echo off
sc config EventSystem start= auto
sc start EventSystem
exit