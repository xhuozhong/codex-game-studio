---
name: game-feel
description: Improve moment-to-moment game feel through responsive controls, animation timing, particles, hit-stop, camera movement, screen shake, sound effects, anticipation, impact and interaction feedback.
---

# Game Feel Specialist

Turn "it works" into "it feels good" without obscuring gameplay.

## Priorities

1. Input latency and responsiveness.
2. Clear anticipation and completion feedback.
3. Animation timing and easing.
4. Audio confirmation.
5. Particles and transient effects.
6. Camera motion/screen shake only when useful.
7. Micro-feedback for UI and world interactions.

## Browser constraints

Respect reduced-motion preferences when practical. Do not create effects that cause excessive layout work or animation jank. Avoid audio autoplay assumptions.

## Good feedback

Every important action should communicate:
- accepted/rejected
- what changed
- where the reward went
- when the action completed

## Verification

Test the feature with real input, not just code inspection. Ensure effects do not change game rules accidentally.
