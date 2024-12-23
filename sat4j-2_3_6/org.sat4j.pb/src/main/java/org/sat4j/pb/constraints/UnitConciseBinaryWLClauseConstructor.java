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
package org.sat4j.pb.constraints;

import org.sat4j.minisat.constraints.cnf.BinaryClauses;
import org.sat4j.minisat.constraints.cnf.LearntBinaryClause;
import org.sat4j.minisat.constraints.cnf.LearntWLClause;
import org.sat4j.minisat.constraints.cnf.OriginalWLClause;
import org.sat4j.minisat.constraints.cnf.UnitClause;
import org.sat4j.minisat.core.ILits;
import org.sat4j.specs.Constr;
import org.sat4j.specs.IVecInt;
import org.sat4j.specs.UnitPropagationListener;

public class UnitConciseBinaryWLClauseConstructor
        implements IClauseConstructor {

    private BinaryClauses[] binaryClauses;

    public Constr constructClause(UnitPropagationListener solver, ILits voc,
            IVecInt v) {
        if (v == null) {
            // tautological clause
            return Constr.TAUTOLOGY;
        }
        if (v.size() == 1) {
            return new UnitClause(v.last());
        }
        if (v.size() == 2) {
            // return OriginalBinaryClause.brandNewClause(solver, voc, v);
            return createConciseBinaryClause(v, voc);
        }
        return OriginalWLClause.brandNewClause(solver, voc, v);
    }

    private Constr createConciseBinaryClause(IVecInt literals, ILits voc) {
        assert literals.size() == 2;
        if (binaryClauses == null) {
            binaryClauses = new BinaryClauses[voc.nVars() * 2 + 2];
        } else if (binaryClauses.length < voc.nVars() * 2 + 1) {
            BinaryClauses[] newBinaryClauses = new BinaryClauses[voc.nVars() * 2
                    + 2];
            System.arraycopy(binaryClauses, 0, newBinaryClauses, 0,
                    binaryClauses.length);
            binaryClauses = newBinaryClauses;
        }
        BinaryClauses first, second;
        if ((first = binaryClauses[literals.get(0)]) == null) {
            first = new BinaryClauses(voc, literals.get(0));
            voc.watch(literals.get(0) ^ 1, first);
            binaryClauses[literals.get(0)] = first;
        }
        if ((second = binaryClauses[literals.get(1)]) == null) {
            second = new BinaryClauses(voc, literals.get(1));
            voc.watch(literals.get(1) ^ 1, second);
            binaryClauses[literals.get(1)] = second;
        }
        first.addBinaryClause(literals.get(1));
        second.addBinaryClause(literals.get(0));
        return first;
        // return new BinaryClauseHandle(literals.get(0), literals.get(1),
        // first,
        // second);
    }

    public Constr constructLearntClause(ILits voc, IVecInt literals) {
        if (literals.size() == 1) {
            return new UnitClause(literals.last(), true);
        }
        if (literals.size() == 2) {
            return new LearntBinaryClause(literals, voc);
        }
        return new LearntWLClause(literals, voc);
    }

}
