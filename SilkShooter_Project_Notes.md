# SilkShooter — Project Notes

**Project Goal:** A charming, wave-based survival shooter in Godot. Cute chibi spider protagonist with a mischievous, playful personality. Strong emphasis on "adorable first, spider second" with Adventure Time energy. The spider shoots silk from her butt.

## ASCII Spider (Temporary Mascot)

```
      /\_/\  
     ( o.o ) 
      > ^ <  
     /|   |\ 
    (_|   |_) 
      |   |  
     / \ / \ 
    /   V   \ 
   /    |    \ 
```

*She shoots silk from her butt. Yes, really.*

## Core Design Pillars

- **Run-based progression** (start fresh every run)
- **Meaningful choices** over raw power
- **Juice & Feedback** — everything should feel satisfying
- **Cute but chaotic** tone
- **Quantity over Quality** for enemies (lots of weaker bugs, not a few tanks)

## Core Loop (Current Direction)

- Twin-stick movement + independent aiming
- Shoot silk freely (no web meter for now)
- Enemies drop experience orbs when killed
- Orbs fly to player automatically (base behavior)
- Separate simple **Health bar**
- After every 2–3 waves: Choose 1 of 3 random upgrade cards
- Goal: Survive as long as possible (high-score / wave count style)

**Note on Web Meter:** We decided to remove the combined web = ammo + health system for the prototype. It was creating balance problems (player becoming nearly invincible). We will use a simple separate health bar instead. This can be revisited later after playtesting.

## Upgrade System (Run-Based)

After every 2–3 waves, the player is presented with **3 random upgrade cards** and must pick one.

### Key Rules
- Upgrades can appear multiple times (stacking allowed)
- Same base card art is reused for higher levels
- Visual progression on cards uses **foil / border treatment**:
  - Level 1: Normal border
  - Level 2: Silver foil + sparkles
  - Level 3: Gold foil + more sparkles
  - Level 4+: Rainbow / holographic / glowing effects

This keeps art requirements low while still showing progression clearly.

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

## Enemy Design

We are starting with **three core enemy types** that use strong complementary colors to the player's red/black palette for clear visual distinction.

### 1. Bad Beetle (Basic Baddie)
- **Color:** Purple / Violet (complementary to player's red)
- **Behavior:** Simple enemy that slowly walks straight toward the player.
- Basic fodder enemy. Easy to understand and deal with.

### 2. Grasshopper (Unnamed)
- **Color:** Bright / Vibrant Green
- **Behavior:** Actively tries to reach the player but frequently jumps in arcs. 
- While in the air, it is immune to shots. This forces the player to **time their attacks** instead of just holding down fire.

### 3. Centipede (The Tension Creator → Wave Boss)
- **Color:** Yellow / Orange
- **Behavior:** Travels in a **sine-wave pattern** across the screen. Does **not** attack the player at first.
- Actively seeks out and **eats experience orbs / power-ups** on the ground to grow longer.
- Acts as a **moving barrier** that blocks both the player’s shots and enemy movement. It can trap groups of Beetles on the other side, creating dangerous build-ups.
- The longer the player takes to clear the other enemies in a wave, the bigger the Centipede grows (up to roughly **one-third of the screen**).
- Once all other enemies in the wave are defeated, the Centipede goes through a **metamorphosis** and becomes the wave boss that now actively hunts the player.
- This creates natural tension: leave it alone too long and you get a much harder boss fight.

**Future Enemy Ideas** (to be added later):
- Flying enemy
- Tanky slow enemy
- Splitter enemy
- Fast swarm enemy

## Wave Progression (Working Table)

Early game should feel friendly and approachable (good for kids too).

| Wave Range | Total Enemies | Notes / Composition                  | Upgrade After? |
|------------|---------------|--------------------------------------|----------------|
| 1–3      | Very Low      | Mostly Beetles, very slow            | No             |
| 4–6      | Low           | Beetles + first Grasshoppers         | Yes            |
| 7–9      | Medium        | Mix of Beetles + Grasshoppers        | Yes            |
| 10–12    | Medium-High   | Introduce Centipede + more enemies   | Yes            |
| 13+       | High          | Heavy pressure, Centipede grows fast | Yes            |

*This is a starting point. We will tune heavily during playtesting.*

## Visual Clarity & Art Direction

- Strong black outlines on all sprites (critical for readability)
- Player spider: Bright red + black, very chibi/cute
- Enemies: Distinct colors (Green Grasshopper, Purple Beetles, Yellow/Orange Centipede)
- Background should stay relatively simple and low-contrast so enemies remain readable when there are many on screen
- Seasonal / window background idea is nice, but should be kept to the borders/corners, not the main play area
- Player spider should feel more rounded/chibi; enemies can be slightly more angular/cartoon-bug style for visual separation

## Current Priorities

1. Core twin-stick movement + independent aiming (using placeholder arrows)
2. Implement upgrade card screen with foil level system
3. Object pooling for projectiles and enemies
4. Basic enemy behaviors (especially Centipede orb-eating + boss transformation)
5. Simple health bar + orb collection
6. Placeholder sprite work

**Document last updated:** June 2026