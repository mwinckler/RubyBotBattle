# View animations

Animation classes must implement the following methods:

## `initialize(frame)`

The constructor should take a single `frame` argument which represents the frame this animation was added.

## `render(frame)`

The `render` method will be called once per frame for as long as the `complete?` method returns `false`. On the initial call, the animation should store the `frame` value as the "initial frame" and keep track of how many frames have passed so that it knows what part of the animation to render. The duration may vary from animation to animation and it is up to each animation to define when it is finished animating.

## `complete?()`

While frames remain to be drawn, the `complete?` method should return false. Once the animation has finished drawing, it should return `true`.