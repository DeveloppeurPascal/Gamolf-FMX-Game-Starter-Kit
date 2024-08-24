# 20240824 - [DeveloppeurPascal](https://github.com/DeveloppeurPascal)

* fixed the UI buttons focus visibility on macOS&iOS : the gamepad events are in a secondary thread, UI changes have to be executed in main thread
* fixed opacity and visibility of arrows problem on Tron game during the choice of controls for each direction of each player (threads conflicts)
* added the UI elements changes by the available joysticks (left and right sticks on a Xbox controller, axes 0..3)
