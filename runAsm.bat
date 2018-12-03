echo Corriendo: %1
ml /c /coff %1.asm
link /subsystem:console %1.obj
%1