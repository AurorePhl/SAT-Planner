import subprocess
import time
import os
import re  # ajout de l'import pour les expressions régulières
import matplotlib.pyplot as plt

# repérer les repertoire de domaine et pbs
RepBase = os.path.normpath(r"src\test\resources\benchmarks\pddl\ipc2000\blocks\strips-typed")
# RepBase = os.path.normpath(r"src\test\resources\benchmarks\pddl\ipc2002\depots\strips-automatic")
# RepBase = os.path.normpath(r"src\test\resources\benchmarks\pddl\ipc1998\gripper\adl")
# RepBase = os.path.normpath(r"src\test\resources\benchmarks\pddl\ipc1998\logistics\adl")

domaine = os.path.join(RepBase, "domain.pddl")
problemes = ["p001.pddl", "p005.pddl"]
# repérer les répertoires des classes et librairies
RepClasses = os.path.normpath(r"build\classes")
RepLib = os.path.normpath(r"build\libs\pddl4j-4.0.0.jar")

# listes pour temps d'exécution et taille de plan (nombre d'actions)
tempsASP, taillePlanASP = [], []
tempsSAT, taillePlanSAT = [], []

# fonction pour exécuter les planners
def lancerPlanner(cmdPlanner, probleme, label):  # on prend en paramètre la commande à exécuter, le problème et le label
    debut = time.time()  # temps de début
    try:
        res = subprocess.run(cmdPlanner, capture_output=True, text=True, check=True)  # exécution de la commande
        fin = time.time()  # temps de fin
        temps = (fin - debut) * 1000  # récup du temps

        sortie = res.stdout  # récup de la sortie
        # Utilisation d'une expression régulière pour trouver les lignes de plan
        taillePlan = sum(1 for line in sortie.splitlines() if re.match(r"^\d+:\s+\(.*\)\s+\[\d+\]$", line.strip()))

        # affichage des résultats
        print(f"{label} - Temps d'exécution pour {probleme}: {temps:.2f} ms")
        print(f"{label} - Longueur du plan pour {probleme}: {taillePlan} actions")
        
        return temps, taillePlan  # retourne le temps et la taille du plan (nb actions)

    except subprocess.CalledProcessError as e:  # si jamais il y a une erreur
        print(f"Erreur avec le problème {probleme} pour {label}: {e}")
        print("stdout:", e.stdout)
        print("stderr:", e.stderr)
        return None, None

# exécution des planners pour chaque problème (3 problèmes)
for probleme in problemes:
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

    # pour MCTS
    cmdSAT = [
        "java", "-cp", f"{RepClasses};{RepLib}", "fr.uga.pddl4j.sat.satPlanner.SAT",
        domaine, probFichier
    ]
    tempsSAT, tailleSAT = lancerPlanner(cmdSAT, probleme, "SAT") 
    # ajout dans la liste
    tempsSAT.append(tempsSAT)
    taillePlanSAT.append(tailleSAT)

labelsProblemes = ["p01", "p05"]

plt.figure(figsize=(10, 8))  # taille de la figure
plt.suptitle("Blocks", fontsize=16)  # titre

# graph temps d'exécution
plt.subplot(2, 1, 1)
plt.scatter(labelsProblemes, tempsASP, color="blue", marker="o", label="ASP")  # affichage des points
plt.scatter(labelsProblemes, tempsSAT, color="green", marker="s", label="SAT")  # affichage des points
plt.xlabel("Problèmes")
plt.ylabel("Temps d'exécution (ms)")
plt.title("Temps d'exécution pour chaque problème")
plt.xticks(rotation=45)
plt.legend()  # affichage de la légende

# graph taille du plan
plt.subplot(2, 1, 2)
plt.scatter(labelsProblemes, taillePlanASP, color="blue", marker="o", label="ASP")
plt.scatter(labelsProblemes, taillePlanSAT, color="green", marker="s", label="SAT")
plt.xlabel("Problèmes")
plt.ylabel("Longueur du plan (Nombre d'actions)")
plt.title("Longueur du plan pour chaque problème")
plt.xticks(rotation=45)
plt.legend()  # légende

plt.tight_layout(rect=[0, 0, 1, 0.96])
plt.show()