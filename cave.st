// cave.st
// Generate a cave using a cellular automaton

import {
  io                   // input and output
  functional as fp     // functional programming
  dynamicMemory as mem // dynamic memory
  collection           // iterators, collection functions
}

let seed:Int32? // RNG seed
let board:[[Bool]] be [[false]] // The game board
const generations be 2:Int8 // Number of generations to run survival for
const fill_percent be 35:Int8 // Initial percent of the map to fill when generating

fn main (argc argv) ->
  import seed
  seed = io/prompt . "What seed? "

  // Free all board memory
  board:each ->
    mem/delete item
  mem/delete board

  // Set the board
  set board to board . generate_barren 64 64

@ [width height] Int8
@ member [[Bool]]
fn generate_barren (width height) -> [[Bool]]
  alias rp random_percent . fill_percent // random piece

  // Re allocate based on width / height
  let board:[[Bool]] be mem/allocate_by . [[Bool]width]height // Initialize the memory
  board = fp/map . rp board // initialize with noise

  for i in 0 .. generations
    board = fp/map . does_survive board

  board = fp/map . on_edge board

  // fill in holes
  alias sz width*height
  let unvisited:<(Int8 Int8)>

  // Run each row concurrently
  let threads <Uint8>
  for x in 0 .. width
    threads = collection/push . threads {
    for y in 0 .. height
      if board[x y] == 0
        unvisited = collection/push . unvisited (x y)
    } ...

  // Join the threads
  each:threads -> ...item

  while not empty . unvisited
    alias x unvisited[0][0]
    alias y unvisited[0][1]

    // Fill algorithm

// Return true some specified percent of the time
@ scope generate_barren:closure
fn random_percent (percent) ->
  import seed
  # = seed = (52667*seed + 20219) % 100 < percent

// Decide based on number of living neighbors whether a cell survives the generation
@ scope generate_barren:closure
fn does_survive (board x y) -> Bool
  for i in -1 .. 2, for j in -1 .. 2
    let count be 0
    if board[x+i y+j] == 1
      count = count + 1

    alias piece board[x y]
    if piece == 0 && (count > 4 || count == 0)
      # = true !
    ei piece == 1 && count < 4
      # = false !
    el
      # = piece ! // survives only if it was alive

// Set the border to all be walls
@ scope generate_barren:closure
fn on_edge (item x y) ->
  import [width height] // get width and height from the nesting scope

  // if a block is on the edge, set it to be a wall
  if x == 0 || x == width-1 || y == 0 || y = height-1
    return 1
  el
    return item
