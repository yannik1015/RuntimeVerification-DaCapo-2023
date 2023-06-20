package com.runtimeverification.rvmonitor.java.rvj.output.codedom;

import com.runtimeverification.rvmonitor.java.rvj.output.codedom.analysis.ICodeVisitor;
import com.runtimeverification.rvmonitor.java.rvj.output.codedom.helper.ICodeFormatter;

/**
 * This class is the root of all statements.
 *
 * @author Choonghwan Lee <clee83@illinois.edu>
 */
public abstract class CodeStmt extends CodeObject {
    /**
     * Tells the code generator whether this statement generates a block, or a
     * single statement. The returned value is used to put a semicolon.
     *
     * @return true if this statement generates a block
     */
    public abstract boolean isBlock();

    /**
     * Creates a statement from the code generated by the old string-based
     * approach.
     *
     * @see CodeLegacyStmt
     * @param rawstmt
     *            the code generated by the old approach
     * @return statement that encapsulates the given code
     */
    public static CodeStmt fromLegacy(String rawstmt) {
        return new CodeLegacyStmt(rawstmt);
    }
}

/**
 * This class represents code generated by the old string-based method and
 * should be considered a statement. Although I replaced the old approach by the
 * new CodeDOM way in many places, the old way is still used. This class
 * encapsulates the string generated by the old method.
 *
 * @author Choonghwan Lee <clee83@illinois.edu>
 */
class CodeLegacyStmt extends CodeStmt {
    private final String rawstmt;

    CodeLegacyStmt(String rawstmt) {
        this.rawstmt = rawstmt;
    }

    @Override
    public boolean isBlock() {
        return true;
    }

    @Override
    public void getCode(ICodeFormatter fmt) {
        fmt.legacyStmt(this.rawstmt);
    }

    @Override
    public void accept(ICodeVisitor visitor) {
        // Ideally, one can parse the legacy code and mark referred variables.
        // Given that legacy code should disappear in the future, however, it
        // seems it's waste of time to implement that. The current
        // implementation
        // returns as if the legacy code does not refer to any variable.
    }
}