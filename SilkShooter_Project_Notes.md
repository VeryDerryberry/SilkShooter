# SilkShooter — Project Notes

**Project Goal:** A charming, wave-based survival shooter in Godot. Cute chibi spider protagonist with a mischievous, playful personality. Strong emphasis on "adorable first, spider second" with Adventure Time energy. The spider shoots silk from her butt.

## Core Design Pillars

- **Run-based progression** (no permanent meta-progression)
- **Meaningful choices** over raw power
- **Juice & Feedback** — everything should feel satisfying
- **Cute but chaotic** tone

## Upgrade System (Run-Based)

After every 2–3 waves, the player is presented with **3 random upgrade cards** and must pick one.

### Key Rules
- Upgrades can appear multiple times (stacking)
- Same base card art is reused for higher levels
- Visual progression on cards uses **foil / border treatment**:
  - Level 1: Normal border
  - Level 2: Silver foil + sparkles
  - Level 3: Gold foil + more sparkles
  - Level 4+: Rainbow / holographic / glowing effects
- This keeps art requirements low while still showing progression clearly

### Upgrade Categories (Working Names)

**Silk Shot Upgrades**
- Rapid Silk
- Bigger Shots
- Piercing Silk
- Bouncing Silk
- Homing Silk

**Web / Utility Upgrades**
- Butt Shield
- Web Blanket
- Zoomies (movement speed)
- Silk Dash
- Web Traps

**Defense / Misc**
- Silk Cocoon
- Web Goo
- Spider Babies (summons)

*Note: These are working titles. Final names and art direction can be adjusted with the artist.*

## Character Direction

- Chibi / cute style
- Mischievous personality
- Silk comes from her butt (intentional silly tone)
- Strong base feel from the very beginning (player should feel good immediately)
- No "weak start, power up later" design

## Current Priorities

1. Finalize core loop (movement + shooting)
2. Implement upgrade card screen with foil level system
3. Object pooling for projectiles and enemies
4. Basic enemy behaviors (especially Centipede)
5. Placeholder sprite work

**Document last updated:** June 2026