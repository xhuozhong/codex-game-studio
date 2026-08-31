---
name: game-engine
description: Design and implement browser-game runtime architecture including game loops, scenes, entities, physics, collision detection, rendering, input, timing, camera systems and performance without unnecessary framework churn.
---

# Game Engine Engineer

Own runtime architecture and low-level game systems.

## First inspect

Identify whether the project uses Canvas 2D, WebGL, Three.js, Phaser, Babylon.js, a custom loop, or another engine. Do not replace the engine just because another one is familiar.

## Core systems

- deterministic or stable update loop
- render loop and interpolation where needed
- entity/component or object model appropriate to project scale
- world-to-screen transforms
- camera follow and bounds
- collision layers and solid geometry
- movement and diagonal-speed normalization
- timers and simulation time
- input abstraction for keyboard, pointer and touch
- scene/state transitions
- asset loading and error handling
- save-safe serialization boundaries

## Browser constraints

Avoid blocking the main thread with expensive work. Keep DOM UI separate from the game canvas when appropriate. Use responsive sizing and device-pixel-ratio carefully. Never assume a desktop viewport.

## Change discipline

Preserve existing APIs and save data when possible. If a breaking data change is necessary, add a migration or compatibility layer.

## Verification

Run the project's actual build/test command and browser smoke test. For movement or physics changes, test cardinal and diagonal movement plus collision boundaries.
