package fr.uga.pddl4j.problem;

/**
 * This class implements a fluent, i.e., a proposition whose truth value changes during planning process.
 *
 * @author D. Pellier
 * @version 1.0 - 28.04.2020
 * @since 4.0
 */
public class Fluent extends AbstractAtomicFormula {

    /**
     * Create a new fluent from an other one. This constructor make a deep copy of the fluent in parameter.
     *
     * @param other the fluent.
     */
    public Fluent(final Fluent other) {
        super(other);
    }

    /**
     * Creates a new fluent with a specified symbol and list of arguments.
     *
     * @param symbol the symbol of the fluent.
     * @param arguments the list of arguments of the fluent.
     */
    public Fluent(final int symbol, final int[] arguments) {
        super(symbol, arguments);
    }

    /**
     * Returns the index of the fluent.
     *
     * @return the index of the fluent.
     */
    public int getIndex() {
        return this.getSymbol();
    }
}