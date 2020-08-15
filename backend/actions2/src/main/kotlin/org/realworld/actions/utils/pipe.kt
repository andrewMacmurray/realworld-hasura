package org.realworld.actions.utils

inline infix fun <P1, R> P1.pipe(t: (P1) -> R): R = t(this)
