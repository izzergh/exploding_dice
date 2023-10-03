# Exploding Dice

Play with dice that explode!

## Motivation

I finished watching [D20: Mentopolis](https://www.dropout.tv/dimension-20-mentopolis).
I enjoyed it quite a bit and encourage you to check it out if you want.
The series is a playthrough of an RPG that includes a mechanic that was new to me: exploding dice.
Apparently this mechanic has been used in games dating back to Tunnels and Trolls, which was published in the seventies.
It's probably been used before even then.

There are a few parts where dice explode, leading to drama and tension and the like.
There are also a couple bits where the criteria that cause a die to explode are played with.

I got to thinking about expected values and how to balance exploding dice in other games, and got to work on simulating these dice to help with that process.

## Introduction
When you roll an exploding die and hit the biggest face, it "explodes", meaning it gets rolled again and each roll is added to the total.

For example, say you have a six-sided die that explodes on 6.
Then you can roll a 1, 2, 3, 4, or 5 and nothing happens.
But if you roll a 6, you keep that 6 and roll again, adding whatever you roll to that 6.
And if you explode again, you do it again!

This repo has a couple classes you can play with to simulate rolling exploding dice.

In short, it defines and tests 2 objects:

## ExplodingDie
This is the kind of die described in the intro above.
It's a die with as many faces as you want that explodes when it hits its highest face.

## BroadlyExplodingDie
This is a die that will explode when any number of faces explode.
For example, you can make a D6 explode on even numbers, odd numbers, or every number _but_ 6.

## Left for the Reader
As I alluded to above, I used these dice to run some trials and guide my conjectures.
The proofs are satisfyingly straightforward!
Here are my 2 favorite findings.

1. The expected value of a standard exploding die with N faces (explodes on the highest face) is `1 + (N/2) + 1/(N-1)`, or "Half the highest face plus 1 and 1 over the second-highest face"
This is the one I started this for - how much better will exploding dice do than regular dice?
The answer is "a little", of course.
1. If a die explodes on all faces _but_ 1, the expected value is the sum of the faces
This one's just pretty. It's also relevant to the show, but I won't spoil further than that.
