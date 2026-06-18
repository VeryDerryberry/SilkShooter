# Silk Shooter - Project Notes

**A whimsical top-down roguelite shooter about a spider defending its home under the beds of the human world.**

---

## Overview / Pitch
Silk Shooter is a charming yet chaotic top-down roguelite shooter where you play as a clever spider protecting and upgrading your lair beneath different beds. Blast pests and hazards with silk projectiles, navigate cluttered "someone else's room" environments full of physics-based interactables, and survive runs to bring resources back to your central **Spider Home** hub. 

Permanent upgrades and room decorations persist between runs, while temporary power-ups keep each attempt fresh. A standout feature is the dynamic **Cat Paw Hazard** that threatens everyone and a memorable **Centipede Boss** that grows stronger by collecting power-ups. The game blends classic arcade shooter DNA (inspired by Atari Black Widow) with modern meta-progression, expressive Pokémon-style cards, and a unique household perspective.

**Core Fantasy**: "What if you were the spider under the bed — and the world above was full of both danger and opportunity?"

---

## Music Plan
**Total: 7 tracks**

- **5 Battle Tracks** — Each with Calm / Intense / Victory versions (adaptive or layered for gameplay intensity shifts during runs)
- **1 Chill Home Theme** — Relaxed, cozy music for the Spider Home hub, safe areas, and decoration/upgrade screens
- **1 Boss Theme** — Epic, escalating track for the Centipede encounter with phase changes

*Goal: Music should feel playful and slightly mischievous, with strong leitmotifs that evolve with the growing boss and hub customization.*

---

## Level Structure
- **5 visually distinct levels**, all set underneath different beds in "someone else’s room"
- Shared enemy pool across all levels, but each level has unique:
  - Background objects, clutter density, and layout "personality"
  - Lighting/atmosphere (e.g., warm lamp glow vs. cool moonlight vs. RGB gamer lights)
  - Environmental interactables and hazards
- Levels should evoke strong "lived-in room" storytelling — tidy kid's room, messy teen den, grandma's quilt kingdom, etc.
- **Interactables** (physics-enabled where possible): marbles (rolling hazards/collectibles), suckers/lollipops (sticky surfaces or power sources), books (cover, platforms, or destructible walls), toy blocks, dust bunnies, loose change, etc.

**Design Goal**: Every level feels like a miniature diorama of a real (but slightly exaggerated) bedroom from below.

---

## Core Systems

### Damage Types
- **Normal** (standard silk projectiles)
- **Melee** (close-range web lash or body slam)
- **Fire**
- **Acid**
- **Electric**

*Future consideration: Enemy-specific resistances/weaknesses and environmental interactions (e.g., Fire + paper/books = spreading hazard).*

### Progression & Meta Systems
- **Permanent Upgrades** — Unlocked with resources earned from runs. Persist forever. Organized in **rarity tiers: Silver, Gold, Diamond**.
- **Room Decoration** — Cosmetic customization of Spider Home that can optionally provide minor gameplay bonuses (e.g., better visibility, regen spots, or thematic buffs). Persists between runs and grows with your collection.
- **Temporary Run-based Power-ups** — Collected during levels. Lost on death or return to hub. Can affect enemy behavior or even feed the boss.

### HUD & Presentation
- **Card-based HUD** using the **8:13 Fibonacci ratio** (very close to Golden Ratio) for naturally pleasing card proportions and layouts.
- **Pokémon-style Character & Boss Cards** with visible **emotions/expressions**. Cards can reflect current state (empowered, injured, angry, curious) and may influence AI behavior or give players readable feedback at a glance.
- Clean, readable information design even during chaotic fights.

---

## Key Mechanics

### Spider Home (Hub)
- Safe central hub and save point.
- Upgrade selection / permanent progression screen.
- Room decoration and customization area.
- Possibly a "memory wall" or card collection viewer.
- Starting point for every run.

### Hazards
- **Cat Paw Hazard** — A dynamic, high-impact environmental threat. It can damage **both the player and enemies**, creating chaotic moments, strategic luring opportunities, and humorous "cat vs bugs" storytelling. Can be random swats or triggered by loud/noisy actions.
- Other environmental dangers: rolling marbles, collapsing structures, sticky surfaces, etc.

### Enemies
- **Same core enemy pool** reused across levels with visual and minor behavioral reskins to fit each room's theme.
- **Critical Implementation Note**: All enemies must have robust pathfinding logic so they **never get permanently stuck** in the cluttered under-bed environments. This is essential for fair gameplay and avoiding softlocks.
- *Recommended*: Define 5–8 enemy archetypes with roles (swarmer, tank, flyer, ambusher, etc.), health pools, preferred damage types, and behaviors.

### Boss: The Centipede
- Iconic growing centipede that **increases in size, segments, and power** by collecting power-ups (or perhaps by consuming lesser enemies/player resources?).
- Classic **sine-wave / undulating movement** with the ability to **crawl over its own body** (creating loops or blocking paths).
- Multi-phase fight that escalates dramatically as it grows.
- Strong candidate for the emotional card system — its "mood" could visibly shift as it powers up.

### Player Character (Spider)
- Primary gameplay loop revolves around **silk shooting** as the core offensive tool (projectiles, perhaps charged shots, spread patterns, or status-inflicting webs).
- Secondary mechanics could include web-based movement (pulling, swinging, temporary platforms) or melee web lashes.
- Resource management: limited silk "ammo" or cooldowns that encourage positioning and timing.
- Goal: Feel nimble, clever, and a little bit cheeky.

---

## Art Direction
- **Tone**: Whimsical, slightly mischievous, cartoonish with heart. Not pure horror — more "bugs with personality living in a big human world."
- **Style ideas**: Bold 2D pixel art or clean vector-like sprites with expressive faces/animations. Strong silhouette readability for small enemies.
- **Perspective**: Primarily top-down with enough height to read clutter and the cat paw threat clearly.
- **Color Palette**: Warm, cozy bedroom tones (wood, fabric, soft lamplight) contrasted with vibrant silk effects and enemy colors for gameplay clarity.
- **Assets**: Mix of hand-authored base sprites + AI-assisted generation/refinement (consistent with previous Grok Imagine workflows for characters and animations). Expressive emotion states on cards and in-game models are a priority.

## Technical Considerations
- **Engine**: Godot 4.x (2D) — excellent fit for rapid prototyping, physics, UI, and save systems.
- **Physics**: Heavy use of Godot's 2D physics for marbles, interactables, centipede body segments, and web effects.
- **Pathfinding**: Custom or enhanced A* with dynamic obstacle avoidance and "unstuck" recovery behaviors.
- **Persistence**: Robust save system for upgrades, decorations, run history, and collected cards.
- **Performance**: Ensure many small interactables + enemies + particles don't tank frame rate (object pooling, culling).

## Core Gameplay Loop (Proposed)
1. Wake up / return to **Spider Home** → heal, spend resources on upgrades, decorate your lair, save progress.
2. Choose (or be assigned) a level from the available beds.
3. Enter the run: Navigate the cluttered arena, shoot silk strategically, dodge the cat paw and physics hazards, collect temporary power-ups and resources.
4. Survive escalating enemy waves or complete level-specific objectives.
5. Face the growing Centipede (or other events) if conditions are met.
6. Extract successfully → return to hub with earnings → repeat.
7. Over many runs: Grow stronger, make your Spider Home more beautiful and functional, unlock new cards and visual flair.

## Inspirations
- **Atari Black Widow** (1982) — Core fantasy of being a silk-shooting spider in an arena of bugs.
- **Centipede** (arcade) — Boss movement and growth concepts.
- **Pokémon** — Card-based UI/identity system with emotional expression.
- Modern roguelites with strong meta-progression and hub building (Hades, etc.).
- Environmental storytelling games where the world feels "lived in" from an unusual perspective (e.g., Toy Story bug-scale vibes but with real household danger).

## Open Questions & Development Priorities
- Exact enemy roster and their damage type affinities/weaknesses.
- Precise rules for how the Centipede grows (player power-ups it picks up? Independent spawn system?).
- Balance between the Cat Paw being "fun chaos" vs. frustrating randomness.
- Silk shooting depth: Should there be multiple silk types or upgradeable patterns?
- Scope for first playable: 1 level + basic hub + core combat + 1 boss prototype is a strong MVP target.
- Audio implementation plan for adaptive music and juicy silk/hit SFX.
- Stretch goals: Co-op (spider siblings?), more bosses, procedural clutter, full emotional AI for enemies.

---

## Next Steps
This document is structured and expanded enough to serve as the main README for the repository. It keeps all your original ideas intact while adding clarity, flow, and GitHub-friendly formatting.

This project has a ton of personality and charm already — excited to see it come together! 🕷️✨

---

*Last updated: 2026-06-16*