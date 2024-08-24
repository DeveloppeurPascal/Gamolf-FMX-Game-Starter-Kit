# 20240824 - [DeveloppeurPascal](https://github.com/DeveloppeurPascal)

* fixed the UI buttons focus visibility on macOS&iOS : the gamepad events are in a secondary thread, UI changes have to be executed in main thread
* fixed opacity and visibility of arrows problem on Tron game during the choice of controls for each direction of each player (threads conflicts)
* added the UI elements changes by the available joysticks (left and right sticks on a Xbox controller, axes 0..3)
* updated the default uConsts.pas unit to raise an exception with the good message instead of the "runtime error 217" on startup
* added the song file in deployment wizard for the SampleGame project
* deployed SampleGame game sample for macOS and Windows
* updated Pong constants
* deployed Pong game sample for macOS and Windows
* updated Snake constants
* deployed Snake game sample for macOS and Windows
* updated Tron constants
* deployed Tron game sample for macOS and Windows
