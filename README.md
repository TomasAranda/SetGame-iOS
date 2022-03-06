# Set Game - SwiftUI

This is a Set Game application made with SwiftUI.

It is my solution of a [CS139P](https://cs193p.sites.stanford.edu) course's Programming Assignments [3](https://cs193p.sites.stanford.edu/sites/g/files/sbiybj16636/files/media/file/assignment_3_0.pdf) and [4](https://cs193p.sites.stanford.edu/sites/g/files/sbiybj16636/files/media/file/assignment_4_0.pdf), in which it was sought to make an application from scratch.

Demostration of SetGame running on simulator (both on dark and light mode):

![Screen recording of SetGame running on simulator](https://user-images.githubusercontent.com/55998376/156930558-aee4163b-62f5-40f0-a44b-7f509f9d980d.gif)

For this assignment it was intended to implement concepts like:
* MVVM architecture
* SwiftUI's custom Shapes, GeometryReader and ViewBuilder
* Swift's closures and enums.
* SwiftUI's Animations (with matchedGeometryEffect)

## Game Rules
The goal of the game is to find collections of cards satisfying the following rule.
* **The set rule**: Three cards are called a set if, with respect to each of the four attributes, the cards are either all the same or all different.

Set is played with a special deck of cards. Each set card displays a design with four attributes — __number, shading, color, and shape__ — and each attribute assumes one of three possible values.

The full Set deck has eighty-one cards, one for each possible combination of attributes.

For more detailed rules see: [Set Game Rules](https://web.archive.org/web/20130605073741/http://www.math.rutgers.edu/~maclagan/papers/set.pdf)
