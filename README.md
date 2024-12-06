# SAT-Planner

Example test of the sat4j solver :
```
java -jar sat4j-2_3_6/org.sat4j.core/2.3.6/org.ow2.sat4j.core-2.3.6.jar sat4j-2_3_6/org.sat4j.core/src/test/testfiles/ii/ii8a1.cnf
```


Test avec MyPlanner : 

Compilation : 

```
 javac -d build/classes -cp build/libs/pddl4j-4.0.0.jar src\main\java\fr\uga\pddl4j\sat\MyPlanner.java    
```

```
java -cp "build/classes;build/libs/pddl4j-4.0.0.jar" fr.uga.pddl4j.sat.MyPlanner  src/test/resources/benchmarks/pddl/ipc2002/depots/strips-automatic/domain.pddl src/test/resources/benchmarks/pddl/ipc2002/depots/strips-automatic/p01.pddl -e FAST_FORWARD -w 1.2 -t 1000 
```


