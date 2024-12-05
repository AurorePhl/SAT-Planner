package fr.uga.pddl4j.sat.satPlanner;

import java.io.BufferedReader; 
import java.io.InputStreamReader;
import java.io.IOException;

public class Decoding {

    public String solve(String pathToCnf){
        String plan = "";
        Boolean isSatisfiable = false;
        try {
            String[] command = {"java", "-jar", "build/libs/org.sat4j.core.jar", pathToCnf};  
            ProcessBuilder processBuilder = new ProcessBuilder(command);
            Process process = processBuilder.start();
            BufferedReader br = new BufferedReader(new InputStreamReader(process.getInputStream())); 
            String line = br.readLine();
            while ((line = br.readLine()) != null) {
                int idx = line.indexOf("v")+1;
                if(isSatisfiable && idx!=-1){
                    while(idx < line.length() && line.charAt(idx) == ' ')
                        idx++;
                    plan = line.substring(idx, line.length());
                    // Récupérer les actions (avec clauses et variables) du plan solution si trouvé !
                    // Extraire les étapes du plan trouvé  
                    // Vérification de si plan == plan solution
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
        if(!plan.equals("")){
            System.out.println("Plan found : "+ plan);
        }
        else {
            System.out.println("No plan found");
        }
        return plan;
    }

    /**
     * The main method of the <code>ASP</code> planner.
     *
     * @param args the arguments of the command line.
     */
    public static void main(String[] args) {
        Decoding d = new Decoding();
        d.solve("sat4j-2_3_6/org.sat4j.core/src/test/testfiles/ii/ii8a1.cnf");
    }

}