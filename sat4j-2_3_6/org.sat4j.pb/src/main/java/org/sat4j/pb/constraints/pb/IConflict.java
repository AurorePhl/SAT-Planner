/*******************************************************************************
 * SAT4J: a SATisfiability library for Java Copyright (C) 2004, 2012 Artois University and CNRS
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 *  http://www.eclipse.org/legal/epl-v10.html
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU Lesser General Public License Version 2.1 or later (the
 * "LGPL"), in which case the provisions of the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of the LGPL, and not to allow others to use your version of
 * this file under the terms of the EPL, indicate your decision by deleting
 * the provisions above and replace them with the notice and other provisions
 * required by the LGPL. If you do not delete the provisions above, a recipient
 * may use your version of this file under the terms of the EPL or the LGPL.
 *
 * Based on the original MiniSat specification from:
 *
 * An extensible SAT solver. Niklas Een and Niklas Sorensson. Proceedings of the
 * Sixth International Conference on Theory and Applications of Satisfiability
 * Testing, LNCS 2919, pp 502-518, 2003.
 *
 * See www.minisat.se for the original solver in C++.
 *
 * Contributors:
 *   CRIL - initial API and implementation
 *******************************************************************************/
package org.sat4j.pb.constraints.pb;

import java.math.BigInteger;

import org.sat4j.minisat.core.VarActivityListener;

public interface IConflict extends IDataStructurePB {

    /**
     * Effectue une resolution avec une contrainte PB. Met a jour le Conflict.
     * 
     * @param cpb
     *            contrainte avec laquelle on va faire la resolution
     * @param litImplied
     *            litteral devant etre resolu
     * @param val
     *            TODO
     * @return la mise a jour du degre
     */
    BigInteger resolve(PBConstr cpb, int litImplied, VarActivityListener val);

    BigInteger slackConflict();

    void postProcess(int dl);

    boolean isAssertive(int dl);

    void setDecisionLevel(int dl);

    boolean isUnsat();

    /**
     * Reduction d'une contrainte On supprime un litteral non assigne
     * prioritairement, vrai sinon. En aucun cas on ne supprime litImplied.
     * 
     * @return mise a jour du degre
     */
    BigInteger reduceInConstraint(IWatchPb wpb, final BigInteger[] coefsBis,
            final int indLitImplied, final BigInteger degreeBis,
            final BigInteger slackResolve);

    /**
     * retourne le niveau de backtrack : c'est-?-dire le niveau le plus haut
     * pour lequel la contrainte est assertive
     * 
     * @param maxLevel
     *            le plus bas niveau pour lequel la contrainte est assertive
     * @return the highest level (smaller int) for which the constraint is
     *         assertive.
     */
    int getBacktrackLevel(int maxLevel);

    void updateSlack(int level);

    boolean slackIsCorrect(int decisionLevel);

    void undoOne(int lit);
}
