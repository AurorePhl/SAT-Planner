# Results 

## Blocks 
```
ASP - Temps d'exécution pour p001.pddl: 0.29 s
ASP - Longueur du plan pour p001.pddl: 6 actions

SAT - Temps d'exécution pour p001.pddl: 0.51 s
SAT - Longueur du plan pour p001.pddl: 8 actions

ASP - Temps d'exécution pour p002.pddl: 0.29 s
ASP - Longueur du plan pour p002.pddl: 10 actions
```

## Depots
```

```

## Gripper
```

```

## Logistics
```
ASP - Temps d'exécution pour p01.pddl: 0.75 s
ASP - Longueur du plan pour p01.pddl: 25 actions

SAT - Temps d'exécution pour p01.pddl: 12.22 s
SAT - Longueur du plan pour p01.pddl: 1 actions

ASP - Temps d'exécution pour p02.pddl: 36.64 s
ASP - Longueur du plan pour p02.pddl: 28 actions

SAT - Temps d'exécution pour p02.pddl: 214.50 s
SAT - Longueur du plan pour p02.pddl: 1 actions
```

# SAT-Planner

Example test of the sat4j solver :
```
java -jar sat4j-2_3_6/org.sat4j.core/2.3.6/org.ow2.sat4j.core-2.3.6.jar sat4j-2_3_6/org.sat4j.core/src/test/testfiles/ii/ii8a1.cnf
```


Test avec MyPlanner : 

Compilation : 

```
javac -d build/classes -cp build/libs/pddl4j-4.0.0.jar src\main\java\fr\uga\pddl4j\sat\SAT.java              
```

Exécution :
```
java -cp "build/classes;build/libs/pddl4j-4.0.0.jar" fr.uga.pddl4j.sat.SAT  src\test\resources\benchmarks\pddl\testForSAT\domain.pddl  src\test\resources\benchmarks\pddl\testForSAT\p01.pddl  
```
# Scripts 

Compile ASP and SAT classes before, then : 
```
python src/scripts/script.py                            
```

# References : 
Pellier, D. (2021). SAT Planning — PDDL4J Exercises 0.1 documentation. http://pddl4j.imag.fr/repository/exercices/sat_planning.html 
 
Pellier, D. (2021). Writing your own Planner — PDDL4J 4.0 documentation.  http://pddl4j.imag.fr/writing_your_own_planner.html 

Quenard, G. (2022). SAT_planner. GitHub. https://github.com/gaspard-quenard/SAT_planner/blob/master/app/src/main/java/sat/SAT.java

