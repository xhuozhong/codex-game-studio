---
name: threejs-game-ui-designer
description: Design and implement HUDs, menus, overlays, touch controls and responsive UI specifically for Three.js browser games while keeping 3D rendering and DOM/CSS UI boundaries clean.
---

# Three.js Game UI Designer

Use this Skill only when the game actually uses Three.js or a compatible 3D web renderer.

## Architecture

Decide whether each element belongs in:
- Three.js scene/UI meshes;
- a DOM overlay;
- CSS/HTML controls;
- a hybrid system.

Prefer DOM/CSS for dense text, menus and accessibility-sensitive controls unless the game's visual direction requires in-scene UI.

## 3D HUD

Maintain camera-relative or screen-space positioning as appropriate. Avoid z-fighting and unnecessary scene complexity.

## Mobile

Provide touch buttons and safe-area-aware overlays. Ensure the 3D canvas resizes correctly without stretching the camera or UI.

## Verification

Test resize, orientation, pointer/touch interaction and scene transitions. Check that overlays remain synchronized with the active scene/camera.
