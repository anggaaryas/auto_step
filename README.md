![logo](https://raw.githubusercontent.com/anggaaryas/auto_step/master/logo.png)

# Auto Step for Flutter

Auto Step is a Flutter widget that facilitates the animation of components by automatically stepping through a sequence of values. It is particularly useful for creating animations or transitions within your Flutter applications.

![preview](https://raw.githubusercontent.com/anggaaryas/auto_step/master/screenshoots/ss1.gif)

## AutoStep Widget
### Usage

```dart
AutoStep(
  total: 3,
  duration: Duration(milliseconds: 1000),
  builder: (step) => AnimatedContainer(
              duration: Duration(milliseconds: 500),
              width: 100.0 * step,
              height: 100,
              color: Colors.green,)
)
```

### Parameters
- `total`: The total number of steps in the sequence.
- `duration`: The duration for each step in the sequence.
- `builder`: A function that builds the UI for each step based on the current step index.
- `loopMode`: An instance of `AutoStepLoopMode` specifying the looping behavior. Default is `AutoStepLoop()`.


## AutoStepSwitch Widget
### Usage

```dart
AutoStepSwitch(
  duration: Duration(milliseconds: 3000),
  builder: (step) => AnimatedAlign(
      alignment: step
          ? Alignment.centerLeft
          : Alignment.centerRight,
      duration: Duration(milliseconds: 2000),
      child: Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
              shape: BoxShape.circle, 
              color: Colors.red
          ),
      ),
  )
)
```

### Parameters
- `duration`: The duration for each step in the sequence.
- `builder`: A function that builds the UI for each step based on the current step status (true/false).
- `loop`: (Optional) Indicates whether the sequence should loop back to the beginning after reaching the last step. Default is `AutoStepLoop()`.


## AutoStepValues Widget
### Usage

```dart
AutoStepValues<BoxDecoration>(
  values:  [
    BoxDecoration(
      shape: BoxShape.rectangle,
      color: Colors.red
    ),

    const BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.green
    ),

    const BoxDecoration(
      shape: BoxShape.rectangle,
      color: Colors.blue
    ),

    BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.white,
      border: Border.all(color: Colors.black)
    ),

  ],
  duration: List.generate(4, (index) => const Duration(milliseconds: 1000)),
  builder: (step) => AnimatedContainer(
    duration: const Duration(milliseconds: 500),
    decoration: step,
    width: 100,
    height: 100,
  )
)
```

### Parameters
- `values`: A list of values of type `T` representing the sequence of steps.
- `duration`: A list of Duration objects specifying the duration for each step in the sequence.
- `builder`: A function that takes a value of type `T` as input and returns a Widget to be rendered for that step.
- `loopMode`: An instance of `AutoStepLoopMode` specifying the looping behavior. Default is `AutoStepLoop()`


## AutoStepLoopMode
### Description

AutoStepLoopMode provides different looping modes for the widget.

### Loop Modes
- **AutoStepNoLoop** : Stops the sequence without looping.
- **AutoStepLoop** : Loops the sequence a specified number of times or infinity.
- **AutoStepReverseLoop** : Reverses the sequence after reaching the end and loops a specified number of times or infinity.