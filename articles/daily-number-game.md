---
title: A Daily Game Without a Database
date: 2022-03-12
hn: 41453335
---

In response to the popularity of
[Wordle](https://www.nytimes.com/games/wordle/index.html) I created
[Numble](https://numble.game/) for the more numerically inclined.

My first idea for serving a new daily game was to prepopulate a database, but I
found a more elegant solution which uses a hash of the current date to choose a
target number and set of source numbers.

The first part of the hash determines the target number, and the 6 source
numbers are chosen by continuing along the hash.

![Visualisation of picking game numbers by walking a hash of today's date](./daily-number-game.figure-1.webp 'Building a daily game from a hash of the current date')

There's some extra logic to limit repeats and include at least one big number,
but this is essentially what happens whenever today's game is requested.

By taking recursive hashes unlimited random data can be seeded.

Databases aren't evil, but in some cases they may be an unnecessary complexity.
