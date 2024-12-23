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

import org.sat4j.core.LiteralsUtils;
import org.sat4j.minisat.constraints.cnf.OriginalHTClause;
import org.sat4j.minisat.core.ILits;
import org.sat4j.specs.IVecInt;
import org.sat4j.specs.UnitPropagationListener;

public final class OriginalHTClausePB extends OriginalHTClause
        implements PBConstr {

    public OriginalHTClausePB(IVecInt ps, ILits voc) {
        super(ps, voc);
    }

    /**
     * 
     */
    private static final long serialVersionUID = 1L;

    public IVecInt computeAnImpliedClause() {
        return null;
    }

    public BigInteger getCoef(int literal) {
        return BigInteger.ONE;
    }

    public BigInteger[] getCoefs() {
        BigInteger[] tmp = new BigInteger[size()];
        for (int i = 0; i < tmp.length; i++) {
            tmp[i] = BigInteger.ONE;
        }
        return tmp;
    }

    public BigInteger getDegree() {
        return BigInteger.ONE;
    }

    /**
     * Creates a brand new clause, presumably from external data. Performs all
     * sanity checks.
     * 
     * @param s
     *            the object responsible for unit propagation
     * @param voc
     *            the vocabulary
     * @param literals
     *            the literals to store in the clause
     * @return the created clause or null if the clause should be ignored
     *         (tautology for example)
     */
    public static OriginalHTClausePB brandNewClause(UnitPropagationListener s,
            ILits voc, IVecInt literals) {
        OriginalHTClausePB c = new OriginalHTClausePB(literals, voc);
        c.register();
        return c;
    }

    @Override
    public String dump() {
        StringBuilder stb = new StringBuilder();
        stb.append("+1 ");
        stb.append(LiteralsUtils.toOPB(this.head));
        for (int p : middleLits) {
            stb.append(" +1 ");
            stb.append(LiteralsUtils.toOPB(p));
        }
        stb.append(" +1 ");
        stb.append(LiteralsUtils.toOPB(this.tail));
        stb.append(" >= 1");
        return stb.toString();
    }

    @Override
    public BigInteger getSumCoefs() {
        return BigInteger.valueOf(size());
    }
}
