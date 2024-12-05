package fr.uga.pddl4j.sat;

import java.io.*;
import java.util.*;

public class Encodage {

    private static int variableCounter = 1; // Compteur global pour les variables
    private static Map<String, Integer> variableMapping = new HashMap<>(); // Mapping fluents/actions -> CNF vars
    private static List<String> clauses = new ArrayList<>(); // Clauses CNF pour un état

    public static void main(String[] args) throws IOException {
        String domainFile = "src/test/resources/benchmarks/pddl/testForSAT/domain.pddl";
        String problemFile = "src/test/resources/benchmarks/pddl/testForSAT/p01.pddl";
        int maxStates = 10; // Limite des états temporels

        // Charger le domaine et le problème
        PDDLDomain domain = parseDomain(domainFile);
        PDDLProblem problem = parseProblem(problemFile);

        // Générer les fichiers CNF pour chaque état jusqu'à maxStates
        for (int t = 1; t <= maxStates; t++) {
            String outputFile = "output_t" + t + ".cnf";

            // Réinitialiser les variables et clauses
            variableCounter = 1;
            variableMapping.clear();
            clauses.clear();

            // Générer le CNF pour l'état `t`
            encodeCNFForState(domain, problem, t);

            // Écrire dans un fichier distinct
            writeCNFFile(outputFile, t);
            System.out.println("Fichier CNF généré : " + outputFile);
        }
    }

    private static void encodeCNFForState(PDDLDomain domain, PDDLProblem problem, int maxTime) {
        // Ajouter l'état initial
        encodeInitialState(problem.getInitialState(), 0);

        // Ajouter transitions et actions pour chaque état jusqu'à maxTime
        for (int t = 0; t < maxTime; t++) {
            for (PDDLAction action : domain.getActions()) {
                encodeAction(action, t);
            }
            encodeFrameAxioms(domain.getFluents(), t);
        }

        // Ajouter l'état final (objectif)
        encodeGoalState(problem.getGoals(), maxTime);
    }

    private static void encodeInitialState(List<String> initialState, int time) {
        for (String fluent : initialState) {
            int var = getVariable(fluent, time);
            clauses.add(var + " 0"); // Fluent vrai
        }
    }

    private static void encodeGoalState(List<String> goals, int time) {
        for (String goal : goals) {
            int var = getVariable(goal, time);
            clauses.add(var + " 0"); // Fluent objectif vrai
        }
    }

    private static void encodeAction(PDDLAction action, int time) {
        int actionVar = getVariable(action.getName(), time);

        // Ajouter préconditions : action -> préconditions
        for (String precondition : action.getPreconditions()) {
            int preVar = getVariable(precondition, time);
            clauses.add("-" + actionVar + " " + preVar + " 0");
        }

        // Ajouter effets : action -> effets
        for (String effect : action.getEffects()) {
            int effectVar = getVariable(effect, time + 1);
            clauses.add("-" + actionVar + " " + effectVar + " 0");
        }
    }

    private static void encodeFrameAxioms(List<String> fluents, int time) {
        for (String fluent : fluents) {
            int fluentVarT = getVariable(fluent, time);
            int fluentVarNextT = getVariable(fluent, time + 1);

            // Si pas modifié, alors reste vrai/faux
            clauses.add("-" + fluentVarT + " " + fluentVarNextT + " 0");
            clauses.add(fluentVarT + " -" + fluentVarNextT + " 0");
        }
    }

    private static int getVariable(String name, int time) {
        String key = name + "_t" + time;
        if (!variableMapping.containsKey(key)) {
            variableMapping.put(key, variableCounter++);
        }
        return variableMapping.get(key);
    }

    private static void writeCNFFile(String outputFile, int maxTime) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(outputFile))) {
            // En-tête CNF
            writer.write("p cnf " + (variableCounter - 1) + " " + clauses.size() + "\n");
            for (String clause : clauses) {
                writer.write(clause + "\n");
            }
        }
    }

    // Analyseur de domaine PDDL
    private static PDDLDomain parseDomain(String domainFile) throws IOException {
        PDDLDomain domain = new PDDLDomain();
        try (BufferedReader reader = new BufferedReader(new FileReader(domainFile))) {
            String line;
            while ((line = reader.readLine()) != null) {
                line = line.trim();
                if (line.startsWith("(:predicates")) {
                    while (!(line = reader.readLine().trim()).endsWith(")")) {
                        domain.addFluent(line.replace("(", "").replace(")", "").trim());
                    }
                } else if (line.startsWith("(:action")) {
                    String actionName = line.split(" ")[1].trim();
                    List<String> preconditions = new ArrayList<>();
                    List<String> effects = new ArrayList<>();

                    while (!(line = reader.readLine().trim()).startsWith(":effect")) {
                        if (line.startsWith(":precondition")) {
                            preconditions = parseConditions(line);
                        }
                    }
                    effects = parseConditions(line);

                    domain.addAction(new PDDLAction(actionName, preconditions, effects));
                }
            }
        }
        return domain;
    }

    // Analyseur de problème PDDL
    private static PDDLProblem parseProblem(String problemFile) throws IOException {
        PDDLProblem problem = new PDDLProblem();
        try (BufferedReader reader = new BufferedReader(new FileReader(problemFile))) {
            String line;
            while ((line = reader.readLine()) != null) {
                line = line.trim();
                if (line.startsWith("(:init")) {
                    while (!(line = reader.readLine().trim()).endsWith(")")) {
                        problem.addInitialState(line.replace("(", "").replace(")", "").trim());
                    }
                } else if (line.startsWith("(:goal")) {
                    while (!(line = reader.readLine().trim()).endsWith(")")) {
                        problem.addGoal(line.replace("(", "").replace(")", "").trim());
                    }
                }
            }
        }
        return problem;
    }

    private static List<String> parseConditions(String line) {
        line = line.replace("(", "").replace(")", "").replace(":effect", "").replace(":precondition", "").trim();
        return Arrays.asList(line.split(" "));
    }

    // Classe interne pour représenter le domaine
    static class PDDLDomain {
        private List<String> fluents = new ArrayList<>();
        private List<PDDLAction> actions = new ArrayList<>();

        public void addFluent(String fluent) {
            fluents.add(fluent);
        }

        public void addAction(PDDLAction action) {
            actions.add(action);
        }

        public List<String> getFluents() {
            return fluents;
        }

        public List<PDDLAction> getActions() {
            return actions;
        }
    }

    // Classe interne pour représenter le problème
    static class PDDLProblem {
        private List<String> initialState = new ArrayList<>();
        private List<String> goals = new ArrayList<>();

        public void addInitialState(String fluent) {
            initialState.add(fluent);
        }

        public void addGoal(String goal) {
            goals.add(goal);
        }

        public List<String> getInitialState() {
            return initialState;
        }

        public List<String> getGoals() {
            return goals;
        }
    }

    // Classe interne pour représenter une action
    static class PDDLAction {
        private String name;
        private List<String> preconditions;
        private List<String> effects;

        public PDDLAction(String name, List<String> preconditions, List<String> effects) {
            this.name = name;
            this.preconditions = preconditions;
            this.effects = effects;
        }

        public String getName() {
            return name;
        }

        public List<String> getPreconditions() {
            return preconditions;
        }

        public List<String> getEffects() {
            return effects;
        }
    }
}
