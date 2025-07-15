---
title: DDT is not TDD
date: 2019-11-15
---

I've worked with more than one team where we claimed to practice
[test-driven-development](https://en.wikipedia.org/wiki/Test-driven_development).

We would go on to write code, get it working, and then test what seems
test-worthy.

Or worse we'd ship with no/minimal coverage and then add tests to critical
and/or failing paths as they arose.

This is development-driven-testing, not test-driven-development.

Test-driven development involves building software in three steps (commonly
summarised as red, green, refactor):
 - Write a failing test
 - Implement the bare minimum code to pass the test
 - Refactor

It's easy to assume that TDD is just a way to ensure full test coverage, but it
provides much more additional value as a tool to reason about the problem at
hand.

Evaluate whether you're practicing DDT or TDD, it may be time to swap those
letters around.
