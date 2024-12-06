import subprocess
import time
import os
import re
import matplotlib.pyplot as plt

# repérer les repertoire de domaine et pbs
# RepBase = os.path.normpath(r"src\test\resources\benchmarks\pddl\ipc2000\blocks\strips-typed")
RepBase = os.path.normpath(r"src\test\resources\benchmarks\pddl\ipc2002\depots\strips-automatic")
# RepBase = os.path.normpath(r"src\test\resources\benchmarks\pddl\ipc1998\gripper\adl")
# RepBase = os.path.normpath(r"src\test\resources\benchmarks\pddl\ipc1998\logistics\adl")

domaine = os.path.join(RepBase, "domain.pddl")

problemesBlocks = [
    "p01.pddl", "p02.pddl", "p03.pddl", "p04.pddl", "p05.pddl", "p06.pddl", "p07.pddl", "p08.pddl", "p09.pddl", "p10.pddl",
]
    
# repérer les répertoires des classes et librairies
RepClasses = os.path.normpath(r"build\classes")
RepLib = os.path.normpath(r"build\libs\pddl4j-4.0.0.jar")

# listes pour temps d'exécution et taille de plan (nombre d'actions)
tempsASP, taillePlanASP = [], []
tempsSAT, taillePlanSAT = [], []

def extract_total_time(output):
    # Utilise une expression régulière pour capturer le temps total
    match = re.search(r"([\d,]+)\s*seconds total time", output, re.IGNORECASE)
    if match:
        # Remplace les virgules par des points pour garantir la conversion en float
        time_str = match.group(1).replace(',', '.')
        return float(time_str)
    return None



# fonction pour exécuter les planners
def lancerPlanner(cmdPlanner, probleme, label):  # on prend en paramètre la commande à exécuter, le problème et le label
    try:
        res = subprocess.run(cmdPlanner, capture_output=True, text=True, check=True)  # exécution de la commande
        sortie = res.stdout  # récup de la sortie
        
        # extraire le temps total passé
        temps = extract_total_time(sortie)
        
        # calculer la taille du plan
        taillePlan = sum(1 for line in sortie.splitlines() if re.match(r"^\d+:\s+\(.*\)\s+\[\d+\]$", line.strip()))

        # affichage des résultats
        if temps is not None:
            print()
            print(f"{label} - Temps d'exécution pour {probleme}: {temps:.2f} s")
        else:
            print(f"{label} - Temps d'exécution pour {probleme}: Non disponible")
        print(f"{label} - Longueur du plan pour {probleme}: {taillePlan} actions")
        
        return temps, taillePlan  # retourne le temps et la taille du plan (nb actions)

    except subprocess.CalledProcessError as e:  # si jamais il y a une erreur
        print(f"Erreur avec le problème {probleme} pour {label}: {e}")
        print("stdout:", e.stdout)
        print("stderr:", e.stderr)
        return None, None

# exécution des planners pour chaque problème (3 problèmes)
for probleme in problemesBlocks:
    probFichier = os.path.join(RepBase, probleme)

    # pour ASP
    cmdASP = [
        "java", "-cp", f"{RepClasses};{RepLib}", "fr.uga.pddl4j.examples.asp.ASP",
        domaine, probFichier, "-e", "FAST_FORWARD", "-w", "1.2", "-t", "1000"
    ] 
    tempsAsp, tailleAsp = lancerPlanner(cmdASP, probleme, "ASP")  # exécution de la fonction lancerPlanner
    # ajout dans la liste
    tempsASP.append(tempsAsp) 
    taillePlanASP.append(tailleAsp)

    # pour SAT
    cmdSAT = [
        "java", "-cp", f"{RepClasses};{RepLib}", "fr.uga.pddl4j.sat.SAT",
        domaine, probFichier
    ]
    tempsSat, tailleSat = lancerPlanner(cmdSAT, probleme, "SAT") 
    # ajout dans la liste
    tempsSAT.append(tempsSat)
    taillePlanSAT.append(tailleSat)

labelsProblemes = problemesBlocks

plt.figure(figsize=(10, 8))  # taille de la figure
plt.suptitle("Depots", fontsize=16)  # titre

# graph temps d'exécution
plt.subplot(2, 1, 1)
plt.scatter(labelsProblemes, tempsASP, color="blue", marker="o", label="ASP")  # affichage des points
plt.scatter(labelsProblemes, tempsSAT, color="green", marker="s", label="SAT")  # affichage des points
plt.xlabel("Problèmes")
plt.ylabel("Temps d'exécution (s)")
plt.title("Temps d'exécution pour chaque problème")
plt.xticks(rotation=45)
plt.legend()  # affichage de la légende

# graph taille du plan
plt.subplot(2, 1, 2)
plt.scatter(problemesBlocks, taillePlanASP, color="blue", marker="o", label="ASP")
plt.scatter(problemesBlocks, taillePlanSAT, color="green", marker="s", label="SAT")
plt.xlabel("Problèmes")
plt.ylabel("Longueur du plan (Nombre d'actions)")
plt.title("Longueur du plan pour chaque problème")
plt.xticks(rotation=45)
plt.legend()  # légende

plt.tight_layout(rect=[0, 0, 1, 0.96])
plt.show()