# Godot Black Widow Project — Organized Project Notes

**Project Goal:** A charming, wave-based survival game in Godot featuring a cute spider girl protagonist. Reimagines classic Black Widow arcade gameplay with modern mechanics centered on a shared web meter (ammo + health). Strong emphasis on "adorable first, spider second" with Adventure Time energy.

## 1. Character Style Guide

**Vibe:** Cute, playful, and a little mischievous with *Adventure Time* energy. Adorable first, spider second.

### Appearance
- **Abdomen:** Large, round, glossy black with a prominent bright red heart on the back
- **Head:** Smaller round head with a large red bow on top *(To-do: Relocate bow to abdomen)*
- **Eyes:** Big, expressive, shiny red eyes
- **Fangs:** Small, rounded, cute fangs
- **Legs:** Eight legs with red bands near the tips

### Core Expressions
| Expression   | Visual Description                  | Trigger Condition                     |
|--------------|-------------------------------------|---------------------------------------|
| Cheeky/Smug  | Playful smirk                       | Default / idle state                  |
| Focused      | Tongue sticking out slightly        | When aiming or shooting web forward   |
| Happy        | Big shiny eyes + warm smile         | Collecting / eating wrapped enemies   |
| Nervous      | Small beady eyes, slightly scared   | Overwhelmed by many enemies           |
| Surprised    | Wide eyes + small "o" mouth         | When hit by an enemy                  |
| Tired        | Droopy eyes + sagging bow           | Low health / web meter                |

## 2. Player Animation & Control System

The player uses a **single sprite animation system** (not layered).

- Body faces movement direction
- Abdomen pose changes based on mouse aim relative to movement
- All animations created on the right side and mirrored in code

### Animation States (Right Side Only)

**Walking + Abdomen Angles:**
- `walk_right_aim_front` (abdomen curled over head, shooting forward)
- `walk_right_aim_front_diag` (aiming ~45° forward)
- `walk_right_aim_side` (abdomen pointing straight right)
- `walk_right_aim_back_diag` (aiming slightly behind)
- `walk_right_aim_back` (abdomen pointing straight back)

Walking uses simple 2-frame animation (right foot / left foot).

## 3. Core Game Mechanics

**The Web Meter (Central Design Pillar)**
- One shared resource bar that functions as **both ammunition and health**.
- Every web shot consumes web.
- Every hit from an enemy reduces web.
- **Restoration method:** Physically move to a web-wrapped enemy and trigger the eat animation to regain web.

## 4. Enemies (Updated Design)

### Purple Beetle
- Basic enemy. Direct, predictable threat that moves toward the player.

### Lime Green Grasshopper
- Jumper / evasive enemy. Can jump over the centipede.

### Orange Centipede (Major Design Change)
- Starts small and moves in a sine wave pattern.
- **Does NOT chase the player.** Instead, it chases **wrapped enemies and power-ups**.
- If it reaches a wrapped enemy or power-up, it eats it and **grows longer**.
- Acts as a moving wall that blocks web shots.
- Holds back the purple beetles, creating natural waves.
- Once all other enemies in the wave are defeated, the centipede transforms into a final boss that must be defeated.
- Each wave has only **one** centipede.
- Larger waves = more opportunities for the centipede to grow = harder boss phase.

## 5. Technical Systems

**Object Pooling (High Priority)**
- Web projectiles should be pooled.
- Enemies should be pooled for performance during intense waves.

## 6. Game Structure & Progression

- Endless wave-based survival (20 unique waves that loop).
- After wave 20 the game loops with higher difficulty and more intense visuals.
- Secret easter egg at wave 105 (Kill Screen).

## Current To-Do

### Phase 1: Core Controls
- [x] 8-direction movement
- [x] Independent spinneret aiming + shooting
- [ ] Refine basic shooting animation + web projectile behavior

### Phase 2: Enemies
- [ ] Implement robust object pooling system
- [ ] Basic enemy AI
- [ ] Enemy damage, health, and death systems
- [ ] Integrate Purple Beetle, Grasshopper, and Centipede

### Art Priorities
- [ ] Complete Spider Girl sprite sheet + full animation set
- [ ] Move large red bow from head to abdomen
- [ ] Design cute, readable spinneret for top-down view
- [ ] Build simple 3D reference model in Blender

**Document last updated:** June 2026