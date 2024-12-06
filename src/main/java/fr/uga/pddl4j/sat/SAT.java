
// inspiration de https://github.com/gaspard-quenard/SAT_planner/blob/master/app/src/main/java/sat/SAT.java 

package fr.uga.pddl4j.sat;

import fr.uga.pddl4j.parser.DefaultParsedProblem;
import fr.uga.pddl4j.parser.RequireKey;
import fr.uga.pddl4j.plan.Plan;
import fr.uga.pddl4j.plan.SequentialPlan;
import fr.uga.pddl4j.planners.AbstractPlanner;
import fr.uga.pddl4j.problem.DefaultProblem;
import fr.uga.pddl4j.problem.Fluent;
import fr.uga.pddl4j.problem.Problem;
import fr.uga.pddl4j.problem.operator.Action;
import fr.uga.pddl4j.util.BitVector;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.sat4j.core.Vec;
import org.sat4j.core.VecInt;
import org.sat4j.minisat.SolverFactory;
import org.sat4j.specs.*;
import picocli.CommandLine;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.InvalidPathException;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashSet;


@CommandLine.Command(name = "SAT", version = "SAT 1.0", description = "Solves a specified planning problem using a SAT solver.", sortOptions = false, mixinStandardHelpOptions = true, headerHeading = "Usage:%n", synopsisHeading = "%n", descriptionHeading = "%nDescription:%n%n", parameterListHeading = "%nParameters:%n", optionListHeading = "%nOptions:%n")
public class SAT extends AbstractPlanner {

    /**
     * The class logger.
     */
    private static final Logger LOGGER = LogManager.getLogger(SAT.class.getName());


    /**
     * nombre de pas du plan
     */
    private int taillePlan = 1;

    /**
     * 
     *
     * @param args the arguments of the command line.
     */
    public static void main(String[] args) {
        try {
            final SAT planner = new SAT();
            CommandLine cmd = new CommandLine(planner);
            cmd.execute(args);
        } catch (IllegalArgumentException e) {
            LOGGER.fatal(e.getMessage());
        }
    }

    /**
     * Instantiates the planning problem from a parsed problem.
     *
     * @param problem the problem to instantiate.
     * @return the instantiated planning problem or null if the problem cannot be
     * instantiated.
     */
    @Override
    public Problem instantiate(DefaultParsedProblem problem) {
        LOGGER.info("Instantiate ADL problem");
        final Problem pb = new DefaultProblem(problem);
        pb.instantiate();
        return pb;
    }

    
    // méthode pour afficher un fluent pour que ce soit lisible, pour débugguer
    public void prettyPrintFluent(Fluent f, Problem problem) {  
        StringBuilder fluentToDisplay = new StringBuilder(); // construire la chaine
        fluentToDisplay.append(problem.getPredicateSymbols().get(f.getSymbol())); // ajouter le symbole du prédicat
        for (int fluentArg : f.getArguments()) { // pour chaque argument du fluent
            fluentToDisplay.append(" " + problem.getConstantSymbols().get(fluentArg)); // ajouter l'argument dans la chaine
        }
        LOGGER.info("Fluent: {}\n", fluentToDisplay);
    }

    // pareil mais pour action
    public void prettyPrintAction(Action a, Problem problem) { // afficher une action
        StringBuilder actionToDisplay = new StringBuilder();    // construire la chaine
        actionToDisplay.append(a.getName()); // ajouter le nom de l'action
        for (int actionArg : a.getInstantiations()) { // pour chaque argument de l'action
            actionToDisplay.append(" " + problem.getConstantSymbols().get(actionArg)); // ajouter l'argument dans la chaine
        }

        LOGGER.info("Action: {}\n", actionToDisplay);
    }
    
    // méthode pour obtenir l'identifiant unique d'un fluent à un pas de temps donné
    public int getFluentUniqueIDforTimeStep(Problem problem, Fluent state, int timeStep) { 
        int idxState = problem.getFluents().indexOf(state); // obtenir index du fluent
        return (problem.getFluents().size() + problem.getActions().size()) * timeStep + 1 + idxState; // calculer l'identifiant unique 
    }

    // méthode pour obtenir l'identifiant unique d'une action à un pas de temps donné
    public int getActionUniqueIDforTimeStep(Problem problem, Action action, int timeStep) {
        int idxAction = problem.getActions().indexOf(action); // obtenir index de l'action
        return (problem.getFluents().size() + problem.getActions().size()) * timeStep + 1 + problem.getFluents().size() // calculer l'identifiant unique
                + idxAction;
    }

    // méthode pour obtenir une action à partir de son identifiant unique
    public Action getActionWithIdx(Problem problem, int actionUniqueID) {
        if (actionUniqueID <= 0) { // si l'identifiant est négatif
            return null;
        }
        // calculer l'index de l'action
        int idx = (actionUniqueID - 1) % (problem.getFluents().size() + problem.getActions().size());
        if (idx >= problem.getFluents().size()) {
            return problem.getActions().get(idx - problem.getFluents().size());
        } else {
            return null;
        }
    }

    
    public Vec<IVecInt> encodeInitialState(final Problem problem, int planSize) {

        Vec<IVecInt> clausesInitState = new Vec<IVecInt>(); // vecteur de clausesEtat initial
        BitVector initStatePosFluents = problem.getInitialState().getPositiveFluents(); // vecteur de fluents positifs de l'état initial
        HashSet<Integer> fluentsNotInInitState = new HashSet<Integer>(); // fluents qui ne sont pas dans l'état initial
        for (int i = 0; i < problem.getFluents().size(); i++) {  // pour chaque fluent
            fluentsNotInInitState.add(i); // ajouter le fluent dans la liste des fluents qui ne sont pas dans l'état initial
        }

        for (int p = initStatePosFluents.nextSetBit(0); p >= 0; p = initStatePosFluents.nextSetBit(p + 1)) { // pour chaque fluent positif de l'état initial
            Fluent f = problem.getFluents().get(p); // obtenir le fluent

            fluentsNotInInitState.remove(p); 

            int idxFluent = getFluentUniqueIDforTimeStep(problem, f, 0); // obtenir l'identifiant unique du fluent
            VecInt clause = new VecInt(new int[]{idxFluent}); // créer une clause avec l'identifiant unique du fluent
            clausesInitState.push(clause); // ajouter la clause dans le vecteur de clausesEtat initial

            initStatePosFluents.set(p); // ajouter le fluent dans l'état initial
        }

        
        for (Integer stateNotInInitState : fluentsNotInInitState) { // pour chaque fluent qui n'est pas dans l'état initial
            VecInt clause = new VecInt(new int[]{-(stateNotInInitState + 1)}); // créer une clause avec le fluent
            clausesInitState.push(clause); // ajouter la clause dans le vecteur de clausesEtat initial
        }

        LOGGER.debug("Clause init state: {}\n", clausesInitState);

        return clausesInitState;
    }

    public Vec<IVecInt> encodeFinalState(final Problem problem, int planSize) {

        Vec<IVecInt> clausesGoalState = new Vec<IVecInt>(); // vecteur de clausesEtat final
        BitVector goalPosFluents = problem.getGoal().getPositiveFluents();  // vecteur de fluents positifs de l'état final

        for (int p = goalPosFluents.nextSetBit(0); p >= 0; p = goalPosFluents.nextSetBit(p + 1)) {
            Fluent f = problem.getFluents().get(p);
            // prettyPrintFluent(f, problem);

            // Add the fluent into the clauseGoalState
            int idxFluent = getFluentUniqueIDforTimeStep(problem, f, planSize);
            VecInt clause = new VecInt(new int[]{idxFluent});
            clausesGoalState.push(clause);

            goalPosFluents.set(p);
        }

        return clausesGoalState;
    }

    
    public Vec<IVecInt> encodeActions(final Problem problem, int planSize) {

        Vec<IVecInt> clausesActions = new Vec<IVecInt>();

        Fluent f;

        for (int timeStep = 0; timeStep < planSize; timeStep++) {
            for (Action action : problem.getActions()) {
                int actionUniqueIDforTimeStep = getActionUniqueIDforTimeStep(problem, action, timeStep); // obtenir l'identifiant unique de l'action
               
                BitVector precondPos = action.getPrecondition().getPositiveFluents();
                for (int p = precondPos.nextSetBit(0); p >= 0; p = precondPos.nextSetBit(p + 1)) {
                    f = problem.getFluents().get(p);
                    int fluentUniqueIDforTimeStep = getFluentUniqueIDforTimeStep(problem, f, timeStep);
                    VecInt clause = new VecInt(new int[]{-actionUniqueIDforTimeStep, fluentUniqueIDforTimeStep});
                    clausesActions.push(clause);
                    precondPos.set(p);
                }

                BitVector precondNeg = action.getPrecondition().getNegativeFluents();
                for (int p = precondNeg.nextSetBit(0); p >= 0; p = precondNeg.nextSetBit(p + 1)) {
                    f = problem.getFluents().get(p);

                    int idxFluent = getFluentUniqueIDforTimeStep(problem, f, timeStep);
                    VecInt clause = new VecInt(new int[]{-actionUniqueIDforTimeStep, -idxFluent});
                    clausesActions.push(clause);
                    precondNeg.set(p);
                }

                BitVector effectPos = action.getUnconditionalEffect().getPositiveFluents();
                for (int p = effectPos.nextSetBit(0); p >= 0; p = effectPos.nextSetBit(p + 1)) {
                    f = problem.getFluents().get(p);

                   
                    int idxFluent = getFluentUniqueIDforTimeStep(problem, f, timeStep + 1);
                    VecInt clause = new VecInt(new int[]{-actionUniqueIDforTimeStep, idxFluent});
                    clausesActions.push(clause);

                    effectPos.set(p);
                }

                BitVector effectNeg = action.getUnconditionalEffect().getNegativeFluents();
                for (int p = effectNeg.nextSetBit(0); p >= 0; p = effectNeg.nextSetBit(p + 1)) {
                    f = problem.getFluents().get(p);

                   
                    int idxFluent = getFluentUniqueIDforTimeStep(problem, f, timeStep + 1);
                    VecInt clause = new VecInt(new int[]{-actionUniqueIDforTimeStep, -idxFluent});
                    clausesActions.push(clause);

                    effectNeg.set(p);
                }
            }
        }

        LOGGER.debug("Clauses action: {}\n", clausesActions);

        return clausesActions;
    }

    
    public Vec<IVecInt> encodeExplanatoryFrameAxioms(final Problem problem, int planSize) {

        Vec<IVecInt> clausesExplanatoryFrameAxioms = new Vec<IVecInt>();
        ArrayList<Action>[] positiveEffectOnFluent = (ArrayList<Action>[]) new ArrayList[problem.getFluents().size()];
        ArrayList<Action>[] negativeEffectOnFluent = (ArrayList<Action>[]) new ArrayList[problem.getFluents().size()];

        for (int i = 0; i < problem.getFluents().size(); i++) {
            positiveEffectOnFluent[i] = new ArrayList<Action>();
            negativeEffectOnFluent[i] = new ArrayList<Action>();
        }

        for (Action action : problem.getActions()) {
            BitVector effectPos = action.getUnconditionalEffect().getPositiveFluents();

            for (int p = effectPos.nextSetBit(0); p >= 0; p = effectPos.nextSetBit(p + 1)) {
                positiveEffectOnFluent[p].add(action);
                effectPos.set(p);
            }

            BitVector effectNeg = action.getUnconditionalEffect().getNegativeFluents();

            for (int p = effectNeg.nextSetBit(0); p >= 0; p = effectNeg.nextSetBit(p + 1)) {
                negativeEffectOnFluent[p].add(action);
                effectNeg.set(p);
            }
        }

       
        for (int stateIdx = 0; stateIdx < problem.getFluents().size(); stateIdx++) {
            for (int timeStep = 0; timeStep < planSize; timeStep++) {
                if (positiveEffectOnFluent[stateIdx].size() != 0) {
            

                    Fluent f = problem.getFluents().get(stateIdx);
                    VecInt clause = new VecInt();

                    clause.push(getFluentUniqueIDforTimeStep(problem, f, timeStep));
                    clause.push(-getFluentUniqueIDforTimeStep(problem, f, timeStep + 1));

                    
                    for (Action action : positiveEffectOnFluent[stateIdx]) {
                        clause.push(getActionUniqueIDforTimeStep(problem, action, timeStep));
                    }

                    clausesExplanatoryFrameAxioms.push(clause);
                }

                if (negativeEffectOnFluent[stateIdx].size() != 0) {
                
                    Fluent f = problem.getFluents().get(stateIdx);
                    VecInt clause = new VecInt();

                    clause.push(-getFluentUniqueIDforTimeStep(problem, f, timeStep));
                    clause.push(getFluentUniqueIDforTimeStep(problem, f, timeStep + 1));

                    // And add all the actions which have this fluent has negative effect
                    for (Action action : negativeEffectOnFluent[stateIdx]) {
                        clause.push(getActionUniqueIDforTimeStep(problem, action, timeStep));
                    }

                    clausesExplanatoryFrameAxioms.push(clause);
                }
            }
        }

        return clausesExplanatoryFrameAxioms;
    }

    
    public Vec<IVecInt> encodeCompleteExclusionAxioms(final Problem problem, int planSize) {

        Vec<IVecInt> clausesCompleteExclusionAxioms = new Vec<IVecInt>();

        for (int iteratorAction1 = 0; iteratorAction1 < problem.getActions().size(); iteratorAction1++) {
            for (int iteratorAction2 = 0; iteratorAction2 < iteratorAction1; iteratorAction2++) {

                Action action1 = problem.getActions().get(iteratorAction1);
                Action action2 = problem.getActions().get(iteratorAction2);

                int initAction1Idx = getActionUniqueIDforTimeStep(problem, action1, 0);
                int initAction2Idx = getActionUniqueIDforTimeStep(problem, action2, 0);

                int offsetToNextActionIdx = problem.getActions().size() + problem.getFluents().size();

                for (int timeStep = 0; timeStep < planSize; timeStep++) {

                    int offset = offsetToNextActionIdx * timeStep;
                    VecInt clause = new VecInt(
                            new int[]{-(initAction1Idx + offset),
                                    -(initAction2Idx + offset)});
                    clausesCompleteExclusionAxioms.push(clause);
                }
            }
        }

        return clausesCompleteExclusionAxioms;
    }

    
    public int[] solverSAT(Vec<IVecInt> allClauses, Problem problem) throws TimeoutException {
        final int MAXVAR = (problem.getFluents().size() + problem.getActions().size()) * this.taillePlan
                + problem.getFluents().size();

        LOGGER.debug("Number clauses: {}\n", allClauses.size());

        ISolver solver = SolverFactory.newDefault();

        solver.newVar(MAXVAR);
        solver.setExpectedNumberOfClauses(allClauses.size());

        try {
            solver.addAllClauses(allClauses);
        } catch (ContradictionException e) {
            return null;
        }

        IProblem problemSAT = solver;
        try {
            if (problemSAT.isSatisfiable()) {
                LOGGER.info("Is satisfiable !\n");
                return problemSAT.model();

            } else {
                LOGGER.error("Is not satisfiable\n");
                return null;
            }
        } catch (TimeoutException e) {
            LOGGER.error("Timeout !\n");
            throw new TimeoutException("Timeout to find a model for the problem");
        }
    }

    
    public Vec<IVecInt> encodeProblemAsCNF(Problem problem, int planSize) {
        LOGGER.info("Encode the inital state into clauses\n");
        Vec<IVecInt> clausesInitState = encodeInitialState(problem, planSize);
        LOGGER.info("Encode the final state into clauses\n");
        Vec<IVecInt> clausesGoalState = encodeFinalState(problem, planSize);
        LOGGER.info("Encode the actions into clauses\n");
        Vec<IVecInt> clausesActions = encodeActions(problem, planSize);
        LOGGER.info("Encode the explanatory frame axioms into clauses\n");
        Vec<IVecInt> clausesExplanatoryFrameAxioms = encodeExplanatoryFrameAxioms(problem, planSize);
        LOGGER.info("Encode complete excusion axiom into clauses\n");
        Vec<IVecInt> clausesCompleteExclusionAxioms = encodeCompleteExclusionAxioms(problem, planSize);

        // Merge all the clauses into a single vector
        Vec<IVecInt> allClauses = new Vec<IVecInt>(clausesInitState.size() + clausesGoalState.size()
                + clausesActions.size() + clausesExplanatoryFrameAxioms.size() + clausesCompleteExclusionAxioms.size());
        clausesInitState.copyTo(allClauses);
        clausesGoalState.copyTo(allClauses);
        clausesActions.copyTo(allClauses);
        clausesExplanatoryFrameAxioms.copyTo(allClauses);
        clausesCompleteExclusionAxioms.copyTo(allClauses);

        LOGGER.debug("Init state size: {}\n", clausesInitState.size());
        LOGGER.debug("Goal state size: {}\n", clausesGoalState.size());
        LOGGER.debug("Action state size: {}\n", clausesActions.size());
        LOGGER.debug("clausesExplanatoryFrameAxioms state size: {}\n", clausesExplanatoryFrameAxioms.size());
        LOGGER.debug("clausesCompleteExclusionAxioms state size: {}\n", clausesCompleteExclusionAxioms.size());

        return allClauses;
    }


    public Plan constructPlanFromModel(int[] model, Problem problem) {
        Plan plan = new SequentialPlan();
        int idxActionInPlan = 0;
        for (Integer idx : model) {
            Action a = getActionWithIdx(problem, idx);
            if (a != null) {
                plan.add(idxActionInPlan, a);
                idxActionInPlan++;
            }
        }
        return plan;
    }

    
    @Override
    public Plan solve(final Problem problem) {

        int[] model;

        while (true) {

            LOGGER.info("Encode the model for a plan of maximum size: {}\n", this.taillePlan);

            // Encode the problem into its CNF form
            final long beginEncodeTime = System.currentTimeMillis();
            Vec<IVecInt> allClauses = encodeProblemAsCNF(problem, this.taillePlan);
            final long endEncodeTime = System.currentTimeMillis();
            this.getStatistics()
                    .setTimeToEncode(this.getStatistics().getTimeToEncode() + (endEncodeTime - beginEncodeTime));

            LOGGER.info("Number clauses: {}\n", allClauses.size());
            // We have encoded the full problem into its CNF form, now, pass it to the
            // solver
            final long beginSolveTime = System.currentTimeMillis();
            LOGGER.info("Launch the solver !\n");
            try {
                model = solverSAT(allClauses, problem);
            } catch (TimeoutException e) {
                final long endSolveTime = System.currentTimeMillis();
                this.getStatistics()
                        .setTimeToSearch(this.getStatistics().getTimeToSearch() + endSolveTime - beginSolveTime);
                return null;
            }

            final long endSolveTime = System.currentTimeMillis();
            this.getStatistics()
                    .setTimeToSearch(this.getStatistics().getTimeToSearch() + endSolveTime - beginSolveTime);

            if (model == null) {
                LOGGER.info(
                        "Failed to model a model with a maximum number of actions = {}.\n",
                        this.taillePlan);

                this.taillePlan *= 2;
            } else {
                break;
            }
        }
        Plan plan = constructPlanFromModel(model, problem);

        return plan;
    }

    @Override
    public boolean isSupported(Problem problem) {
        return !problem.getRequirements().contains(RequireKey.ACTION_COSTS)
                && !problem.getRequirements().contains(RequireKey.CONSTRAINTS)
                && !problem.getRequirements().contains(RequireKey.CONTINOUS_EFFECTS)
                && !problem.getRequirements().contains(RequireKey.DERIVED_PREDICATES)
                && !problem.getRequirements().contains(RequireKey.DURATIVE_ACTIONS)
                && !problem.getRequirements().contains(RequireKey.DURATION_INEQUALITIES)
                && !problem.getRequirements().contains(RequireKey.FLUENTS)
                && !problem.getRequirements().contains(RequireKey.GOAL_UTILITIES)
                && !problem.getRequirements().contains(RequireKey.METHOD_CONSTRAINTS)
                && !problem.getRequirements().contains(RequireKey.NUMERIC_FLUENTS)
                && !problem.getRequirements().contains(RequireKey.OBJECT_FLUENTS)
                && !problem.getRequirements().contains(RequireKey.PREFERENCES)
                && !problem.getRequirements().contains(RequireKey.TIMED_INITIAL_LITERALS)
                && !problem.getRequirements().contains(RequireKey.HIERARCHY);
    }
}
