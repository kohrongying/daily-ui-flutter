# daily_ui

A new Flutter application.

## How to Run
Dev: `flutter run -d chrome`
Test: `flutter test test/<testName>`


## Daily UI Challenge
There are available as pens on [CodePen](https://codepen.io/collection/nGYxNN) as well.
### Day 001 - Sign Up
![Signup](images/001.png)

- Learnt how to use Form fields and TextEditingController
- Used Stack to stack the colors on the left hand side


### Day 002 - Credit Card Checkout
![creditcard](images/002.png)

- New classes: Tooltip, InputFormatter, RaisedButton

### Day 003 - Landing Page
![landingpage](images/003.png)
- Used Stack
- New classes: AnimatedContainer, Timer, Random, ThemeData
- [Image Credit](https://unsplash.com/photos/KkqvVpfIzrU)
- [Inspiration](https://www.pinterest.com/pin/838584393107045652/)


### Day 004 - Calculator
![calculator](images/004.png)
- Calculator logic with TDD first
    * Simplify first (don't compute long expressions, just one operator per operation)
    * Do happy path first then edge cases
    * Show error for division error
- Edge Cases to consider
    * 5 + -4 => 5 - 4
    * 5 / -4 => 5 / -4
    * 1 + 2 * 6 = 13
    * 5..2 => 5.2
    * 5.20.1 => 5.2
    * 5 / 0 => how to handle divide by zero error
- Handling overflow with ellipsis
- New Classes: GridView

### Day 006
![profile](images/006.png)

- New Classes: CustomScrollView, SliverAppBar, FlexibleSpacer, SliverGrid, SliverList, Hero, DecoratedBox

### Day 007
![settings](images/007.png)

- New Classes: ListView, ListTile, Toggling Dark and Light Mode

### Day 008
![404](images/008.png)

- New Classes: FadeTransition

### Day 010
![socialshare](images/010.png)

- New Classes: AnimatedPosition, AnimatedSwitcher

AnimatedPosition was pretty much hardcoded though.


### Day 011
![flashmessage](images/011.png)

- New Classes: Dialog, Transform, SizedBox.expand