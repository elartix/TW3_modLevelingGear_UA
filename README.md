# Leveling Gear Remastered (Next-Gen & Update 5.0)

**Version:** 1.0.10b  
**Target:** The Witcher 3: Wild Hunt — Next-Gen (Patch 4.04+) & Update 5.0 (Remastered)  
**Compatibility:** Fully conflict-free via REDengine 3 script annotations (`@wrapMethod`). Zero base script file modifications.

---

## Overview

**Leveling Gear Remastered** dynamically scales weapons and armor to match Geralt's current level. It supports both upward scaling (keeping beloved low-level relic gear viable throughout the game) and downward scaling (allowing high-level quest rewards or world loot to be equipped immediately without artificial level restrictions).

---

## Architecture & Source Files

All source scripts reside in `content/scripts/local/`:

```
mods/modLevelingGear/
├── content/
│   └── scripts/
│       └── local/
│           ├── modLevelingGearConfig.ws        # In-game menu configuration reader & singleton
│           ├── modLevelingGearHooks.ws         # Next-Gen @wrapMethod annotations
│           ├── modLevelingGearLocalization.ws  # Multi-language string tables & HUD formatting
│           └── modLevelingGearManager.ws       # Core item scaling, math engine & craftsman tempering
└── README.md                                   # This technical guide
```

### In-Game Menu & Config Files
- **XML Menu:** `bin/config/r4game/user_config_matrix/pc/modLevelingGear.xml`
- **Base Config:** `bin/config/base/modLevelingGear.ini`
- In-game settings reside under: `Options -> Gameplay -> Mods -> Leveling Gear`.

---

## Script Annotations & Hook Targets

The mod replaces traditional monolithic script edits with clean, non-invasive Next-Gen annotations:

| Target Class | Method | Hook Type | Purpose |
| :--- | :--- | :--- | :--- |
| `CR4Player` | `OnLevelUp` | `@wrapMethod` | Triggers gear auto-scaling when Geralt levels up. |
| `W3PlayerWitcher` | `OnSpawned` | `@wrapMethod` | Initializes the mod manager on game load / fast travel. |
| `W3GuiRepairInventoryComponent` | `GetRepairItems` | `@wrapMethod` | Injects under-leveled equipment into craftsman Repair tabs for manual tempering. |
| `W3ItemRepairManStateRepair` | `ProcessRepair` | `@wrapMethod` | Handles craftsman tempering transactions, gold deduction, and material consumption. |
| `CInventoryComponent` | `GetItemLevel` | `@wrapMethod` | Dynamic downscaling of equip level requirements for gear and ammunition. |
| `CInventoryComponent` | `GetItemStats` | `@wrapMethod` | Normalizes secondary stat display in inventory and shop tooltips. |
| `CInventoryComponent` | `GetItemPrimaryStat` | `@wrapMethod` | Dynamically recalculates primary weapon damage range (min-max) and armor ratings in inventory and shop tooltips. |
| `W3TooltipComponent` | `GetCrossbowPrimatyStat` | `@wrapMethod` | Scales primary crossbow damage range in inventory tooltips. |
| `W3PlayerWitcher` | `GetTotalWeaponDamage` | `@wrapMethod` | Applies downscaled primary damage multipliers in combat for weapons and crossbows. |
| `CActor` | `GetAttributeValue` | `@wrapMethod` | Dynamically corrects equipped secondary stats and player resistances based on item level ratio. |

---

## Math & Balancing Engine

### 1. Dual-Layer Progression Architecture
Leveling Gear operates on two distinct mathematical layers to maintain authentic combat balance:
- **Base Primary Stats (Weapon Damage & Armor Points):** Dynamically track Geralt's character level across both downscaling and upscaling regimes using REDengine's native base progression curves.
- **Secondary Combat Affixes (Sign Intensity, Critical Hit, Attack Power, Resistances, Bleed):** Regulated by the Dynamic Normalization & Gradual Restoration engine.

### 2. Downscaled Gear & God-Item Prevention ($Player Level < Item Base Level$)
When a player finds or equips an endgame item (e.g., Level 40 Grandmaster Witcher gear or Relic swords) at early levels (e.g., Level 1–20), vanilla mechanics would either prohibit equipping it entirely or, under crude leveling mods, grant unscaled endgame perks (+100% Critical Damage, +20% Critical Chance, +50 Armor Piercing), causing game-breaking god-mode.

Leveling Gear computes a dynamic normalization ratio:
$$\text{Normalization Ratio} = \text{ClampF}\left(\frac{\text{Current Player Level}}{\text{Item Original Base Level}}, 0.01, 1.0\right)$$

All scalable secondary combat modifiers are scaled by this ratio:
$$\text{Effective Stat} = \text{Base Stat} \times \text{Normalization Ratio}$$

- **Safe Floor Guarantee:**
  - Percentage attributes (`percentageValue == true`) are floored at **$+1\%$** ($0.01$).
  - Flat integer attributes are floored at **$1.0$** point.
  - *Result:* Unique enchantments, elemental traits, and bleed chances remain perceptibly active and rewarding, but are balanced for early-game combat.

- **Monotonic Gradual Restoration:**
  - As Geralt gains experience and levels up, the normalization ratio increases monotonically ($1 \to 20 \to 34 \to \text{Base Level}$).
  - Secondary bonuses smoothly expand in real-time until reaching $100\%$ authentic strength at the item's native level.

### 3. Over-Leveled Gear & Immortality Cap ($Player Level \ge Item Base Level$)
When Geralt exceeds an item's original base level:
- Primary weapon damage and armor defense ratings continue to scale smoothly upward to match higher-tier enemies and New Game Plus ($NG+$).
- Secondary percentages remain strictly pinned at **$1.0\times$ ($100\%$ of base value)**.
- *Balance Rationale:* This hard ceiling prevents runaway stat inflation (e.g., $+20\%$ monster resistance scaling to $+140\%$, granting literal invulnerability).

### 4. Crossbow & Bolt Scaling Architecture
- **Crossbows:** In Witcher 3 XML, crossbows have fixed baseline damage ($9\text{--}11$) and achieve higher-level power through `attack_power` multipliers. The mod dynamically hooks `attack_power` in secondary normalization, scaling relic crossbow attack power from $+7\%$ at Level 1 to $+133\%$ at Level 20 and $+215\%$ at Level 34.
- **Ammunition:** High-tier crafted ammunition (Split Bolts, Exploding Bolts) dynamically downscale their level requirements to match the player, granting immediate tactical access at zero crown and material cost.

### 5. Aerondight Exemption
Aerondight features CDPR's permanent charge-leveling mechanic from *Blood and Wine*. The config toggle `bExcludeAerondight` (default: `true`) bypasses Leveling Gear's linear scaling on Aerondight to preserve its native stack-building gameplay.

---

## Testing & Verification

Run automated test suites to verify math and syntax:
```bash
python tests/test_leveling_math.py
python tests/test_mod_syntax.py
```
To verify compilation against your live game installation:
```bash
python tools/verify_game_compilation.py
```
