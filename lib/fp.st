// Functional Programming
import collection
import fp

alias collection/dimensionsOf dimensionsOf

@ function fn
@ coll collection/iterable
fn map (function coll) -> typeOf coll
  # = collection/clear . coll
  let dims be dimensionsOf . coll
  let index be 0
  for i in 0 .. dims, for e in 0 .. dims[i]
    let indices be collection/indicesOf . index dims
    index += 1

@ function fn
  & arityOf 1
  & params @all typeOf coll[0]
@ coll collection/iterable
fn filter (function coll) -> typeOf coll
  # = collection/clear . coll
  coll : each {
    if function . item
      # = collection/append . item coll
  }


@ function fn
  & arityOf 2
  & params @all typeOf coll[0]
@ coll collection/iterable
fn reducel (function coll) -> typeOf coll[0]
  # = coll[0]
  coll[1 .. ] : each {
    # = function . # item
  }

@ function fn
  & arityOf 2
  & params @all typeOf coll[0]
@ coll collection/iterable
fn reducer (function coll) -> typeOf coll[0]
  # = coll[-1]
  coll[-2 .. 0] : each {
    # = function . # item
  }

@ function fn
  & arityOf 2
  & params @all typeOf coll[0]
@ coll collection/iterable
@ sameType init coll[0]
fn foldl (init function coll) -> typeOf init
  # = init
  coll : each {
    # = function . # item
  }

@sameType init coll[0]
fn foldr (init function coll) -> typeOf init
  # = init
  coll[-1 .. ] : each {
    # = function . # item
  }

curry
curryr
uncurry
uncurryl
defer
once
debounce
throttle
delay
memoize
repeat
after
before
apply
call
car
cdr
cadr
cddr
caddr
cdddr
cadddr
