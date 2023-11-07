# Projets randoms DE1-SoC
(re)Prise en main de la DE1-SoC et des FPGA en général

J'ai mis le dossier systemCD dans le .gitignore pour ne pas alourdir le projet (Quasi 1GB!)

Re-télécharger sur les différents PC en cherchant un truc du genre "DE1-SoC Board" dans un truc du genre "Google".

## Installation sous Linux
Penser à installer avec les droits root. Ça se passe sans trop de problèmes (testé que sur ubuntu pour l'instant).

L'exécutable se trouve dans le dossier suivant (si on l'a installé au bon endroit) :
```bash
/opt/intelFPGA_lite/22.1std/quartus/bin/
```

L'exécutable s'appelle tout simplement quartus

### Pour programmer la carte (sous Linux toujours)
Il n'y a pas besoin de drivers, mais il faut penser aux règles udev :

```bash
sudo vim /etc/udev/rules.d/51-usbblaster.rules
```

```bash
# Intel FPGA Download Cable

SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6001", MODE="0666"

SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6002", MODE="0666"

SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6003", MODE="0666"

# Intel FPGA Download Cable II

SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6010", MODE="0666"

SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6810", MODE="0666"
```

## Configuration du FPGA
Si on ne fait pas les choses comme il faut, quartus plante. C'est nul!

Dans "Programmer", (/opt/intelFPGA_lite/22.1std/quartus/bin/quartus_pgmw, ou bien sûr à travers Quartus) :

* Cliquer sur Auto Detect
	* Ça fait apparaître une pop-up, cliquez sur OK ou whatever
	* On voit deux puces : le micro-processeur à gauche et le FPGA à droite
* Sur le FPGA (à droite) : Click droit > Edit > Change File
* Sélectionner le fichier .sof dans le dossier output_file
* Ça devrait marcher
* On peut laisser Programmer ouvert et ne pas refaire cette manip à chaque fois.
	* Je crois même qu'on peut sauvegarder, mais j'ai pas encore essayé.
	* Ouais, ça marche

## Fichier de contraintes
On peut utiliser l'outil graphique : Assignments > Pin Planner, mais il faut lancer "Analysis & Synthesis" avant.

On peut aussi éditer le fichier .qsf

Syntaxe : 
```tcl
set_location_assignment PIN_V16 -to leds[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to leds[0]
```

## Horloges et PLL
Il y a 4 clocks à 50MHz : PIN_AF14, PIN_AA16, PIN_Y26, PIN_K14. Elles sont en 3.3-V LVTTL.

### Pour la PLL
Tools > IP Catalog. On dirait que rien ne se passe, mais ça ouvre un truc sur la droite.

Utiliser "PLL Intel FPGA IP". Pour l'instancier :

```vhdl
library pll;
use pll.all;

pll_0 : entity pll.pll
	port map (
```

Le signal rst est en logique positive (il faut mettre '0' pour que la pll fonctionne, ou "not nrst")

## Quelques trucs cools en vrac
Fenetre de compilation à gauche : 
* Compile Desing > Analysis & Synthesis > Netlist Viewers > RTL Viewer

## Chasse au warnings
Certains warnings sont nuls, mais comme en C, ça risque de masquer les warnings plus graves.

### Synopsys Design Constraints File file not found: 'pll_test.sdc'
A Synopsys Design Constraints File is required by the Timing Analyzer to get proper timing constraints. Without it, the Compiler will not properly optimize the design.

File > New > Synopsys Design Constraints File

```tcl
# 50MHz means 20ns
create_clock -name clk -period 20 [get_ports {clk}]

# I don't know why yet, but it seems important
derive_pll_clocks
derive_clock_uncertainty
```

J'ai encore des petits warnings, va falloir se tapper cette vidéo : https://www.youtube.com/watch?v=GItefNliYpM

### Number of processors has not been specified which may cause overloading on shared machines.  
Set the global assignment NUM_PARALLEL_PROCESSORS in your QSF to an appropriate value for best performance.

Ajouter la ligne suivante dans le .qsf. Soyez pas con, changez 4 par votre nombre de CPU.
set_global_assignment -name NUM_PARALLEL_PROCESSORS 4

### Feature LogicLock is only available with a valid subscription license. 
You can purchase a software subscription to gain full access to this feature.

Ouaip ouaip ouaip

### Some pins have incomplete I/O assignments. 
Refer to the I/O Assignment Warnings report for details

cf vidéo timings plus haut
 
### Ignored locations or region assignments to the following nodes
C'est temporaire

### Found invalid Fitter assignments. 
See the Ignored Assignments panel in the Fitter Compilation Report for more information.

On verra plus tard

