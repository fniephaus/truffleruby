/*
 * Copyright (c) 2013, 2017 Oracle and/or its affiliates. All rights reserved. This
 * code is released under a tri EPL/GPL/LGPL license. You can use it,
 * redistribute it and/or modify it under the terms of the:
 *
 * Eclipse Public License version 1.0, or
 * GNU General Public License version 2, or
 * GNU Lesser General Public License version 2.1.
 */
package org.truffleruby.language.locals;

import com.oracle.truffle.api.frame.VirtualFrame;
import org.truffleruby.core.cast.BooleanCastNode;
import org.truffleruby.core.cast.BooleanCastNodeGen;
import org.truffleruby.language.RubyNode;

public class FlipFlopNode extends RubyNode {

    private final boolean exclusive;

    @Child private BooleanCastNode begin;
    @Child private BooleanCastNode end;
    @Child private FlipFlopStateNode stateNode;

    public FlipFlopNode(RubyNode begin, RubyNode end,
                        FlipFlopStateNode stateNode, boolean exclusive) {
        this.exclusive = exclusive;
        this.begin = BooleanCastNodeGen.create(begin);
        this.end = BooleanCastNodeGen.create(end);
        this.stateNode = stateNode;
    }

    @Override
    public Object execute(VirtualFrame frame) {
        if (exclusive) {
            if (stateNode.getState(frame)) {
                if (end.executeBoolean(frame)) {
                    stateNode.setState(frame, false);
                }

                return true;
            } else {
                final boolean newState = begin.executeBoolean(frame);
                stateNode.setState(frame, newState);
                return newState;
            }
        } else {
            if (stateNode.getState(frame)) {
                if (end.executeBoolean(frame)) {
                    stateNode.setState(frame, false);
                }

                return true;
            } else {
                if (begin.executeBoolean(frame)) {
                    stateNode.setState(frame, !end.executeBoolean(frame));
                    return true;
                }

                return false;
            }
        }
    }

}
