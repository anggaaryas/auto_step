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
- `loop`: (Optional) Indicates whether the sequence should loop back to the beginning after reaching the last step. Default is `true`.


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
- `loop`: (Optional) Indicates whether the sequence should loop back to the beginning after reaching the last step. Default is `true`.