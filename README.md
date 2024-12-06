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

## Logistics


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


