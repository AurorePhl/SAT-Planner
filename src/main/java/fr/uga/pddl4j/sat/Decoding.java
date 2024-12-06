package fr.uga.pddl4j.sat;

import java.io.BufferedReader; 
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.io.IOException;

public class Decoding {

    public String solve(String pathToCnf, Map<String, Integer> variableMapping){
        StringBuilder plan = new StringBuilder();        
        List<Integer> clauses = new ArrayList<Integer>();
        Boolean isSatisfiable = false;
        try {
            String[] command = {"java", "-jar", "sat4j-2_3_6/org.sat4j.core/2.3.6/org.ow2.sat4j.core-2.3.6.jar", pathToCnf};  
            ProcessBuilder processBuilder = new ProcessBuilder(command);
            Process process = processBuilder.start();
            BufferedReader br = new BufferedReader(new InputStreamReader(process.getInputStream())); 
            String line;
            while ((line = br.readLine()) != null) {
                int idx = line.indexOf("v")+1;
                if(isSatisfiable && idx!=-1){
                    // Vérification de si plan == plan solution
                    // Récupérer les actions (et clauses) du plan solution si trouvé
                    int i = 0;
                    String[] variables = line.substring(1).trim().split("\\s+");
                    for (String var : variables) {
                        clauses.add(Integer.parseInt(var));
                        int variable = Integer.parseInt(var);
                        if (variable > 0) {
                            // Récupérer l'action associée à la variable CNF
                            String action = getKeyFromValue(variableMapping, variable);
                            System.out.println("ici");
                            System.out.println(action);
                            if (action != null) {
                                plan.append("[" + i + "]");
                                plan.append(action).append("\n");
                                i++;
                            }
                        }
                    }
                    System.out.println("Clauses : " + clauses);
                    isSatisfiable = false;
                }
                
                if(line.contains("SATISFIABLE")) {
                    isSatisfiable = true;
                }
            }
            System.out.println("Fin de la recherche de plan");
        }
        catch (IOException e) { 
            e.printStackTrace(); 
        }
        return plan.toString();
    }

    private static String getKeyFromValue(Map<String, Integer> map, int value) { 
        for (Map.Entry<String, Integer> entry : map.entrySet()) { 
            System.out.println(entry.getKey());
            if (entry.getValue().equals(value)) { 
                System.out.println(entry.getKey());
                return entry.getKey(); 
            } 
        } 
        return null; 
    }
    
    /**
     * The main method of the <code>SAT</code> planner.
     *
     * @param args the arguments of the command line.
     */
    public static void main(String[] args) {
        Encodage e = new Encodage();
        Decoding d = new Decoding();
        StringBuilder plan = new StringBuilder();
        // d.solve("sat4j-2_3_6/org.sat4j.core/src/test/testfiles/ii/ii8a1.cnf");
        for (int i = 0;i<=10;i++){
            // Extraire les étapes du plan trouvé  
            plan.append(d.solve("output_t"+i+".cnf",e.getVariableMapping()));
        }
        if(!plan.toString().equals("")){
            System.out.println("Plan found : "+ plan.toString());
        }
        else {
            System.out.println("No plan found");
        }
    }

}