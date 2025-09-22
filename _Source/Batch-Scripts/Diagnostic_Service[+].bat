@echo off
set "LOG=%~dp0\apply_perf_preset.log"
sc config diagsvc start=demand >>"%LOG%" 2>&1
sc config WdiServiceHost start=demand >>"%LOG%" 2>&1
sc config Diagtrack start=demand >>"%LOG%" 2>&1
sc start diagsvc >>"%LOG%" 2>&1
sc start WdiServiceHost >>"%LOG%" 2>&1
sc start Diagtrack >>"%LOG%" 2>&1
echo ==== Diagnostic Services END [+] %DATE% %TIME% ====>>"%LOG%"
exit