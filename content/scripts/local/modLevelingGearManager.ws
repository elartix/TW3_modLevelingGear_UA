/***********************************************************************/
/** 	Leveling Gear (Update 5.0 Remastered & Next-Gen)
/** 	Central Gameplay & Economic Scaling Manager
/***********************************************************************/

function BoolToString(val : bool) : string
{
	if ( val )
	{
		return "true";
	}
	return "false";
}

function MLGGetItemName(inv : CInventoryComponent, item : SItemUniqueId) : string
{
	return GetLocStringByKeyExt(inv.GetItemLocalizedNameByUniqueID(item));
}

function MLGDeductKitHelper(inv : CInventoryComponent, kitName : name, out remaining : int)
{
	var qty : int;
	if ( remaining <= 0 )
	{
		return;
	}
	qty = inv.GetItemQuantityByName(kitName);
	if ( qty <= 0 )
	{
		return;
	}

	if ( qty >= remaining )
	{
		inv.RemoveItemByName(kitName, remaining);
		remaining = 0;
	}
	else
	{
		inv.RemoveItemByName(kitName, qty);
		remaining -= qty;
	}
}

function MLGSortByQuality(inv : CInventoryComponent, out items : array<SItemUniqueId>)
{
	var i, j, maxIdx, count : int;
	var temp : SItemUniqueId;
	var q1, q2 : int;

	count = items.Size();
	for (i = 0; i < count - 1; i += 1)
	{
		maxIdx = i;
		q1 = RoundMath(CalculateAttributeValue(inv.GetItemAttributeValue(items[maxIdx], 'quality')));

		for (j = i + 1; j < count; j += 1)
		{
			q2 = RoundMath(CalculateAttributeValue(inv.GetItemAttributeValue(items[j], 'quality')));
			if ( q2 > q1 )
			{
				maxIdx = j;
				q1 = q2;
			}
		}

		if ( maxIdx != i )
		{
			temp = items[i];
			items[i] = items[maxIdx];
			items[maxIdx] = temp;
		}
	}
}

class CModLevelingGearManager
{
	private var config : CModLevelingGearConfig;
	private var isScalingActive : bool;
	private var isCalculatingCorrection : bool;

	private function GetConfig() : CModLevelingGearConfig
	{
		if ( !config )
		{
			config = GetModLevelingGearConfig();
		}
		return config;
	}

	public function IsScalingInProgress() : bool
	{
		return isScalingActive;
	}

	public function SetScalingInProgress(active : bool)
	{
		isScalingActive = active;
	}

	public function EnsureBaseLevelSnapshot(inv : CInventoryComponent, item : SItemUniqueId, unwrappedLevel : int) : int
	{
		var base, scaled : int;

		if ( !inv || !inv.IsIdValid(item) || unwrappedLevel <= 0 )
		{
			return 0;
		}

		base = inv.GetItemModifierInt(item, 'MLG_BaseLevel');
		scaled = inv.GetItemModifierInt(item, 'MLG_ScaledLevel');

		// 1. Initial snapshot using instance unwrapped level
		if ( base <= 0 )
		{
			inv.SetItemModifierInt(item, 'MLG_BaseLevel', unwrappedLevel);
			return unwrappedLevel;
		}

		// 2. Self-healing: beta corruption caused base == scaled when downscaled on ingest.
		// Legitimate scaling is strictly unequal (scaled < base or scaled > base).
		if ( scaled > 0 && base == scaled && unwrappedLevel > base )
		{
			inv.SetItemModifierInt(item, 'MLG_BaseLevel', unwrappedLevel);
			return unwrappedLevel;
		}

		return base;
	}

	public function IsNormalizableSecondaryAttribute(attributeName : name) : bool
	{
		switch ( attributeName )
		{
			case 'attack_power':
			case 'SilverDamage':
			case 'silver_damage':
			case 'SlashingDamage':
			case 'slashing_damage':
			case 'PiercingDamage':
			case 'piercing_damage':
			case 'BludgeoningDamage':
			case 'bludgeoning_damage':
			case 'RendingDamage':
			case 'rending_damage':
			case 'ElementalDamage':
			case 'elemental_damage':
			case 'FireDamage':
			case 'fire_damage':
			case 'critical_hit_chance':
			case 'critical_hit_damage':
			case 'armor_piercing':
			case 'armor':
			case 'spell_power_igni':
			case 'spell_power_aard':
			case 'spell_power_quen':
			case 'spell_power_yrden':
			case 'spell_power_axii':
			case 'all_skills_intensity':
			case 'focus_gain':
			case 'exp_modifier_perk':
			case 'slashing_resistance_perc':
			case 'piercing_resistance_perc':
			case 'bludgeoning_resistance_perc':
			case 'rending_resistance_perc':
			case 'elemental_resistance_perc':
			case 'poison_resistance_perc':
			case 'bleeding_resistance_perc':
			case 'burning_resistance_perc':
				return true;
			default:
				return false;
		}
	}

	public function GetItemScalingRatio(inv : CInventoryComponent, item : SItemUniqueId) : float
	{
		var baseLevel, scaledLevel : int;
		var ratio : float;

		baseLevel = inv.GetItemModifierInt(item, 'MLG_BaseLevel');
		scaledLevel = inv.GetItemModifierInt(item, 'MLG_ScaledLevel');

		if ( baseLevel <= 0 || scaledLevel <= 0 )
		{
			return 1.0;
		}

		if ( scaledLevel < baseLevel )
		{
			ratio = (float)scaledLevel / (float)baseLevel;
			if ( ratio < 0.01 )
			{
				ratio = 0.01;
			}
			return ratio;
		}

		return 1.0;
	}

	public function GetItemLinearPerLevelSlope(inv : CInventoryComponent, item : SItemUniqueId) : float
	{
		var category : name = inv.GetItemCategory(item);

		if ( inv.ItemHasTag(item, 'PlayerSilverWeapon') || category == 'silversword' )
		{
			return 10.0;
		}
		if ( inv.ItemHasTag(item, 'PlayerSteelWeapon') || category == 'steelsword' 
			|| category == 'axe' || category == 'bludgeon' || category == 'secondary' || inv.IsItemSecondaryWeapon(item) )
		{
			return 8.0;
		}
		if ( category == 'armor' || inv.IsItemChestArmor(item) )
		{
			return 5.0;
		}
		if ( category == 'pants' || inv.IsItemPants(item) )
		{
			return 2.0;
		}
		if ( category == 'gloves' || inv.IsItemGloves(item) )
		{
			return 2.0;
		}
		if ( category == 'boots' || inv.IsItemBoots(item) )
		{
			return 2.0;
		}
		return 0.0;
	}

	public function IsPrimaryDamageType(inv : CInventoryComponent, weapon : SItemUniqueId, damageTypeName : name) : bool
	{
		var category : name;
		if ( !inv || !inv.IsIdValid(weapon) )
		{
			return false;
		}
		category = inv.GetItemCategory(weapon);
		if ( inv.ItemHasTag(weapon, 'PlayerSilverWeapon') || category == 'silversword' )
		{
			return damageTypeName == 'SilverDamage' || damageTypeName == 'silver_damage';
		}
		if ( inv.ItemHasTag(weapon, 'PlayerSteelWeapon') || category == 'steelsword' 
			|| category == 'axe' || category == 'bludgeon' || category == 'secondary' || inv.IsItemSecondaryWeapon(weapon) )
		{
			return damageTypeName == 'SlashingDamage' || damageTypeName == 'slashing_damage' || damageTypeName == 'BludgeoningDamage' || damageTypeName == 'bludgeoning_damage' || damageTypeName == 'PiercingDamage' || damageTypeName == 'piercing_damage' || damageTypeName == 'RendingDamage' || damageTypeName == 'rending_damage';
		}
		return false;
	}

	public function GetPrimaryStatDownscaleDelta(inv : CInventoryComponent, item : SItemUniqueId) : float
	{
		var baseLevel, scaledLevel, deltaLevels : int;
		var slope : float;

		if ( !inv || !inv.IsIdValid(item) )
		{
			return 0.0;
		}

		baseLevel = inv.GetItemModifierInt(item, 'MLG_BaseLevel');
		scaledLevel = inv.GetItemModifierInt(item, 'MLG_ScaledLevel');

		if ( baseLevel <= 0 || scaledLevel <= 0 || scaledLevel >= baseLevel )
		{
			return 0.0;
		}

		deltaLevels = baseLevel - scaledLevel;
		slope = GetItemLinearPerLevelSlope(inv, item);

		return (float)deltaLevels * slope;
	}

	public function NormalizeTooltipStats(inv : CInventoryComponent, itemId : SItemUniqueId, out itemStats : array<SAttributeTooltip>)
	{
		var cfg : CModLevelingGearConfig = GetConfig();
		var ratio, delta : float;
		var i : int;
		var origin : name;

		if ( !cfg.IsMasterEnabled() || !cfg.ShouldNormalizeSecondary() )
		{
			return;
		}

		if ( !IsItemEligible(inv, itemId) )
		{
			return;
		}

		ratio = GetItemScalingRatio(inv, itemId);
		if ( ratio >= 0.999 )
		{
			return;
		}

		delta = GetPrimaryStatDownscaleDelta(inv, itemId);

		for ( i = 0; i < itemStats.Size(); i += 1 )
		{
			origin = itemStats[i].originName;
			if ( itemStats[i].primaryStat || origin == 'armor' || origin == theGame.params.ARMOR_VALUE_NAME )
			{
				if ( delta > 0.0 )
				{
					itemStats[i].value = itemStats[i].value - delta;
					if ( itemStats[i].value < 1.0 )
					{
						itemStats[i].value = 1.0;
					}
				}
			}
			else if ( IsNormalizableSecondaryAttribute(origin) )
			{
				itemStats[i].value = itemStats[i].value * ratio;
				if ( itemStats[i].percentageValue )
				{
					if ( itemStats[i].value < 0.01 && itemStats[i].value > 0.0 )
					{
						itemStats[i].value = 0.01;
					}
				}
				else
				{
					if ( itemStats[i].value < 1.0 && itemStats[i].value > 0.0 )
					{
						itemStats[i].value = 1.0;
					}
				}
			}
		}
	}

	public function GetPrimaryDamageMultiplier(inv : CInventoryComponent, weaponId : SItemUniqueId, crossbowId : SItemUniqueId) : float
	{
		var cfg : CModLevelingGearConfig = GetConfig();
		var targetItem : SItemUniqueId;
		var ratio : float;
		var baseLevel, scaledLevel : int;

		if ( !cfg.IsMasterEnabled() )
		{
			return 1.0;
		}

		if ( inv && inv.IsIdValid(crossbowId) && cfg.ShouldScaleCrossbows() )
		{
			targetItem = crossbowId;
			baseLevel = inv.GetItemModifierInt(targetItem, 'MLG_BaseLevel');
			scaledLevel = inv.GetItemModifierInt(targetItem, 'MLG_ScaledLevel');
			if ( baseLevel > 0 && scaledLevel > 0 )
			{
				if ( scaledLevel < baseLevel )
				{
					return MaxF(0.01, (float)scaledLevel / (float)baseLevel);
				}
				else if ( scaledLevel > baseLevel )
				{
					return 1.0 + (float)(scaledLevel - baseLevel) * 0.03;
				}
			}
			return 1.0;
		}

		if ( inv && inv.IsIdValid(weaponId) && IsItemEligible(inv, weaponId) )
		{
			ratio = GetItemScalingRatio(inv, weaponId);
			return ratio;
		}

		return 1.0;
	}

	public function GetSecondaryAttributeCorrection(player : W3PlayerWitcher, attributeName : name) : float
	{
		var cfg : CModLevelingGearConfig = GetConfig();
		var inv : CInventoryComponent;
		var slots : array<EEquipmentSlots>;
		var item : SItemUniqueId;
		var i : int;
		var ratio, totalCorrection, itemVal : float;
		var itemAttr : SAbilityAttributeValue;

		if ( isCalculatingCorrection || !cfg.IsMasterEnabled() || !cfg.ShouldNormalizeSecondary() )
		{
			return 0.0;
		}

		if ( !player )
		{
			return 0.0;
		}

		inv = player.GetInventory();
		if ( !inv )
		{
			return 0.0;
		}

		isCalculatingCorrection = true;

		slots.PushBack(EES_SteelSword);
		slots.PushBack(EES_SilverSword);
		slots.PushBack(EES_Armor);
		slots.PushBack(EES_Boots);
		slots.PushBack(EES_Gloves);
		slots.PushBack(EES_Pants);

		totalCorrection = 0.0;

		for ( i = 0; i < slots.Size(); i += 1 )
		{
			if ( player.GetItemEquippedOnSlot(slots[i], item) && IsItemEligible(inv, item) )
			{
				ratio = GetItemScalingRatio(inv, item);
				if ( ratio < 0.999 )
				{
					if ( attributeName == 'armor' || attributeName == theGame.params.ARMOR_VALUE_NAME )
					{
						totalCorrection -= GetPrimaryStatDownscaleDelta(inv, item);
					}
					else
					{
						itemAttr = inv.GetItemAttributeValue(item, attributeName);
						itemVal = itemAttr.valueAdditive;
						if ( itemVal == 0.0 && itemAttr.valueBase != 0.0 )
						{
							itemVal = itemAttr.valueBase;
						}

						if ( itemVal > 0.0 )
						{
							totalCorrection += itemVal * (ratio - 1.0);
						}
					}
				}
			}
		}

		isCalculatingCorrection = false;
		return totalCorrection;
	}

	public function IsItemEligible(inv : CInventoryComponent, item : SItemUniqueId) : bool
	{
		var cfg : CModLevelingGearConfig = GetConfig();
		var category : name;
		var quality : int;
		var scope : int;
		var isSword, isSecondary, isArmor, isCrossbow, isBolt : bool;

		if ( !cfg.IsMasterEnabled() )
		{
			return false;
		}

		if ( cfg.ShouldExcludeAerondight() && inv.ItemHasTag(item, 'Aerondight') )
		{
			return false;
		}

		category = inv.GetItemCategory(item);

		isSword = (category == 'silversword' || category == 'steelsword' 
			|| inv.ItemHasTag(item, 'PlayerSteelWeapon') || inv.ItemHasTag(item, 'PlayerSilverWeapon'));

		isSecondary = (category == 'axe' || category == 'bludgeon' || category == 'secondary'
			|| inv.IsItemSecondaryWeapon(item) || inv.ItemHasTag(item, 'SecondaryWeapon'));

		isArmor = (category == 'armor' || category == 'boots' || category == 'gloves' || category == 'pants'
			|| inv.IsItemChestArmor(item) || inv.IsItemBoots(item) || inv.IsItemGloves(item) || inv.IsItemPants(item));

		isCrossbow = (category == 'crossbow' || inv.IsItemCrossbow(item) || inv.ItemHasTag(item, 'crossbow'));

		isBolt = (category == 'bolt' || inv.IsItemBolt(item) || inv.ItemHasTag(item, 'bolt'));

		if ( (isCrossbow || isBolt) && !cfg.ShouldScaleCrossbows() )
		{
			return false;
		}

		if ( !isSword && !isSecondary && !isArmor && !isCrossbow && !isBolt )
		{
			return false;
		}

		if ( isBolt && (inv.ItemHasTag(item, theGame.params.TAG_INFINITE_AMMO) || inv.ItemHasTag(item, 'InfiniteAmmo')) )
		{
			return false;
		}

		if ( isBolt )
		{
			return true;
		}

		scope = cfg.GetGearScope();
		quality = RoundMath(CalculateAttributeValue(inv.GetItemAttributeValue(item, 'quality')));

		// 0: All Gear (Vanilla and Modded)
		if ( scope == 0 )
		{
			return true;
		}
		// 1: Witcher & Relic Gear Only
		else if ( scope == 1 )
		{
			return (quality >= 4 || inv.ItemHasTag(item, 'EP1') || inv.ItemHasTag(item, 'WitcherGear') || inv.ItemHasTag(item, 'DLC'));
		}
		// 2: Witcher School Gear Only
		else if ( scope == 2 )
		{
			return (quality == 5 || inv.ItemHasTag(item, 'WitcherGear'));
		}

		return true;
	}

	public function GetQualityMultiplier(quality : int) : float
	{
		var cfg : CModLevelingGearConfig = GetConfig();
		if ( quality >= 5 )
		{
			return cfg.GetMultWitcher();
		}
		else if ( quality == 4 )
		{
			return cfg.GetMultRelic();
		}
		return cfg.GetMultCommon();
	}

	public function GetMaterialName() : name
	{
		var cfg : CModLevelingGearConfig = GetConfig();
		var idx : int = cfg.GetRequiredMaterialIndex();
		switch ( idx )
		{
			case 0: return 'Oil';
			case 1: return 'Weapon repair kit 2';
			case 2: return 'Dwimeryte ingot';
			case 3: return 'Meteorite ore';
			default: return 'Meteorite ore';
		}
	}

	public function GetCrownsDisplayName() : string
	{
		var loc : string;
		loc = GetLocStringByKeyExt("Crowns");
		if ( loc != "" && !StrBeginsWith(loc, "##") )
		{
			return loc;
		}
		return "Crowns";
	}

	public function GetMaterialDisplayName() : string
	{
		var cfg : CModLevelingGearConfig;
		var idx : int;
		var loc : string;

		cfg = GetConfig();
		idx = cfg.GetRequiredMaterialIndex();
		switch ( idx )
		{
			case 0:
				loc = GetLocStringByKeyExt("Oil");
				if ( loc != "" && !StrBeginsWith(loc, "##") ) return loc;
				return "Oil";
			case 1:
				loc = GetLocStringByKeyExt("Repair Kit");
				if ( loc != "" && !StrBeginsWith(loc, "##") ) return loc;
				return "Repair Kit";
			case 2:
				loc = GetLocStringByKeyExt("Dimeritium Ingot");
				if ( loc != "" && !StrBeginsWith(loc, "##") ) return loc;
				return "Dimeritium Ingot";
			case 3:
				loc = GetLocStringByKeyExt("Meteorite Ore");
				if ( loc != "" && !StrBeginsWith(loc, "##") ) return loc;
				return "Meteorite Ore";
			default:
				loc = GetLocStringByKeyExt("Material");
				if ( loc != "" && !StrBeginsWith(loc, "##") ) return loc;
				return "Material";
		}
	}

	public function GetMaterialCount(inv : CInventoryComponent) : int
	{
		var cfg : CModLevelingGearConfig = GetConfig();
		var idx : int = cfg.GetRequiredMaterialIndex();
		var count : int;

		switch ( idx )
		{
			case 0:
				count = inv.GetItemQuantityByName('Oil');
				if ( count <= 0 )
				{
					count = inv.GetItemQuantityByName('Alchemical alcohol');
				}
				return count;
			case 1:
				count = inv.GetItemQuantityByName('weapon_repair_kit_1')
					+ inv.GetItemQuantityByName('weapon_repair_kit_2')
					+ inv.GetItemQuantityByName('weapon_repair_kit_3')
					+ inv.GetItemQuantityByName('armor_repair_kit_1')
					+ inv.GetItemQuantityByName('armor_repair_kit_2')
					+ inv.GetItemQuantityByName('armor_repair_kit_3')
					+ inv.GetItemQuantityByName('Weapon repair kit 1')
					+ inv.GetItemQuantityByName('Weapon repair kit 2')
					+ inv.GetItemQuantityByName('Weapon repair kit 3')
					+ inv.GetItemQuantityByName('Armor repair kit 1')
					+ inv.GetItemQuantityByName('Armor repair kit 2')
					+ inv.GetItemQuantityByName('Armor repair kit 3');
				return count;
			case 2:
				return inv.GetItemQuantityByName('Dwimeryte ingot');
			case 3:
				return inv.GetItemQuantityByName('Meteorite ore');
			default:
				return inv.GetItemQuantityByName('Meteorite ore');
		}
	}

	public function DeductMaterial(inv : CInventoryComponent, count : int)
	{
		var cfg : CModLevelingGearConfig = GetConfig();
		var idx : int = cfg.GetRequiredMaterialIndex();
		var remaining : int = count;
		var qty : int;

		if ( count <= 0 )
		{
			return;
		}

		switch ( idx )
		{
			case 0:
				qty = inv.GetItemQuantityByName('Oil');
				if ( qty >= remaining )
				{
					inv.RemoveItemByName('Oil', remaining);
					return;
				}
				if ( qty > 0 )
				{
					inv.RemoveItemByName('Oil', qty);
					remaining -= qty;
				}
				if ( remaining > 0 )
				{
					inv.RemoveItemByName('Alchemical alcohol', remaining);
				}
				break;
			case 1:
				MLGDeductKitHelper(inv, 'weapon_repair_kit_1', remaining);
				MLGDeductKitHelper(inv, 'weapon_repair_kit_2', remaining);
				MLGDeductKitHelper(inv, 'weapon_repair_kit_3', remaining);
				MLGDeductKitHelper(inv, 'armor_repair_kit_1', remaining);
				MLGDeductKitHelper(inv, 'armor_repair_kit_2', remaining);
				MLGDeductKitHelper(inv, 'armor_repair_kit_3', remaining);
				MLGDeductKitHelper(inv, 'Weapon repair kit 1', remaining);
				MLGDeductKitHelper(inv, 'Weapon repair kit 2', remaining);
				MLGDeductKitHelper(inv, 'Weapon repair kit 3', remaining);
				MLGDeductKitHelper(inv, 'Armor repair kit 1', remaining);
				MLGDeductKitHelper(inv, 'Armor repair kit 2', remaining);
				MLGDeductKitHelper(inv, 'Armor repair kit 3', remaining);
				break;
			case 2:
				inv.RemoveItemByName('Dwimeryte ingot', count);
				break;
			case 3:
				inv.RemoveItemByName('Meteorite ore', count);
				break;
			default:
				inv.RemoveItemByName('Meteorite ore', count);
				break;
		}
	}

	public function CalculateUpgradeCost(playerLevel : int, itemLevel : int, quality : int, out crowns : int, out items : int)
	{
		var cfg : CModLevelingGearConfig = GetConfig();
		var payType : int = cfg.GetPaymentType();
		var delta : int = playerLevel - itemLevel;
		var mult : float = GetQualityMultiplier(quality);
		var rawItems : float;

		if ( delta <= 0 || payType == 0 )
		{
			crowns = 0;
			items = 0;
			return;
		}

		// 1: Crowns only
		if ( payType == 1 )
		{
			crowns = RoundMath((float)delta * (float)cfg.GetBaseCrownCost() * mult);
			items = 0;
		}
		// 2: Materials only
		else if ( payType == 2 )
		{
			crowns = 0;
			rawItems = (float)delta * 0.25 * mult;
			items = RoundMath(rawItems);
			if ( items < 1 ) items = 1;
		}
		// 3: Both
		else if ( payType == 3 )
		{
			crowns = RoundMath((float)delta * (float)cfg.GetBaseCrownCost() * 0.75 * mult);
			rawItems = (float)delta * 0.20 * mult;
			items = RoundMath(rawItems);
			if ( items < 1 ) items = 1;
		}
	}

	public function CalculateDownscaleCost(playerLevel : int, itemLevel : int, quality : int, out crowns : int, out items : int)
	{
		var cfg : CModLevelingGearConfig = GetConfig();
		var mult : float = cfg.GetDownscaleCostMult();
		var baseCrowns, baseItems : int;

		if ( mult <= 0.001 || itemLevel <= playerLevel )
		{
			crowns = 0;
			items = 0;
			return;
		}

		CalculateUpgradeCost(itemLevel, playerLevel, quality, baseCrowns, baseItems);
		crowns = RoundMath((float)baseCrowns * mult);
		items = RoundMath((float)baseItems * mult);
	}

	public function CanAffordUpgrade(player : W3PlayerWitcher, crowns : int, items : int) : bool
	{
		if ( crowns > 0 && player.GetMoney() < crowns )
		{
			return false;
		}
		if ( items > 0 && GetMaterialCount(player.GetInventory()) < items )
		{
			return false;
		}
		return true;
	}

	public function DeductUpgradeCost(player : W3PlayerWitcher, crowns : int, items : int)
	{
		if ( crowns > 0 )
		{
			player.RemoveMoney(crowns);
		}
		if ( items > 0 )
		{
			DeductMaterial(player.GetInventory(), items);
		}
	}

	public function TemperEquippedItem(inv : CInventoryComponent, item : SItemUniqueId, levelsToScale : int) : bool
	{
		var i, curLvl : int;
		var category : name;

		if ( levelsToScale <= 0 )
		{
			return false;
		}

		curLvl = inv.GetItemLevel(item);
		EnsureBaseLevelSnapshot(inv, item, curLvl);

		category = inv.GetItemCategory(item);

		for (i = 0; i < levelsToScale; i += 1)
		{
			if ( inv.ItemHasTag(item, 'PlayerSteelWeapon') || category == 'steelsword' 
				|| category == 'axe' || category == 'bludgeon' || category == 'secondary' || inv.IsItemSecondaryWeapon(item) )
			{
				inv.AddItemCraftedAbility(item, 'autogen_fixed_steel_dmg', true);
			}
			else if ( inv.ItemHasTag(item, 'PlayerSilverWeapon') || category == 'silversword' )
			{
				inv.AddItemCraftedAbility(item, 'autogen_fixed_silver_dmg', true);
			}
			else if ( category == 'armor' || inv.IsItemChestArmor(item) )
			{
				inv.AddItemCraftedAbility(item, 'autogen_fixed_armor_armor', true);
			}
			else if ( category == 'gloves' || inv.IsItemGloves(item) )
			{
				inv.AddItemCraftedAbility(item, 'autogen_fixed_gloves_armor', true);
			}
			else if ( category == 'boots' || category == 'pants' || inv.IsItemBoots(item) || inv.IsItemPants(item) )
			{
				inv.AddItemCraftedAbility(item, 'autogen_fixed_pants_armor', true);
			}
			else if ( category == 'crossbow' || inv.IsItemCrossbow(item) )
			{
				inv.AddItemCraftedAbility(item, 'Rune elemental _Stats', true);
			}
		}

		if ( category == 'crossbow' || inv.IsItemCrossbow(item) )
		{
			inv.SetItemModifierInt(item, 'MLG_CrossbowScaledStacks', inv.GetItemModifierInt(item, 'MLG_CrossbowScaledStacks') + levelsToScale);
		}

		return true;
	}

	public function CollectCandidates(player : W3PlayerWitcher, includeInventory : bool, optional filterBlacksmith : bool, optional filterArmorer : bool) : array<SItemUniqueId>
	{
		var inv : CInventoryComponent = player.GetInventory();
		var candidates : array<SItemUniqueId>;
		var equippedCandidates : array<SItemUniqueId>;
		var inventoryCandidates : array<SItemUniqueId>;
		var allItems : array<SItemUniqueId>;
		var slots : array<EEquipmentSlots>;
		var item : SItemUniqueId;
		var i : int;
		var isSword, isSecondary, isArmor, isCrossbow, isBolt : bool;
		var category : name;

		slots.PushBack(EES_SilverSword);
		slots.PushBack(EES_SteelSword);
		slots.PushBack(EES_Armor);
		slots.PushBack(EES_Boots);
		slots.PushBack(EES_Gloves);
		slots.PushBack(EES_Pants);
		slots.PushBack(EES_RangedWeapon);
		slots.PushBack(EES_Bolt);

		for (i = 0; i < slots.Size(); i += 1)
		{
			if ( player.GetItemEquippedOnSlot(slots[i], item) )
			{
				if ( IsItemEligible(inv, item) )
				{
					if ( filterBlacksmith || filterArmorer )
					{
						category = inv.GetItemCategory(item);
						isSword = (category == 'silversword' || category == 'steelsword' 
							|| inv.ItemHasTag(item, 'PlayerSteelWeapon') || inv.ItemHasTag(item, 'PlayerSilverWeapon'));
						isSecondary = (category == 'axe' || category == 'bludgeon' || category == 'secondary'
							|| inv.IsItemSecondaryWeapon(item) || inv.ItemHasTag(item, 'SecondaryWeapon'));
						isArmor = (category == 'armor' || category == 'boots' || category == 'gloves' || category == 'pants'
							|| inv.IsItemChestArmor(item) || inv.IsItemBoots(item) || inv.IsItemGloves(item) || inv.IsItemPants(item));
						isCrossbow = (category == 'crossbow' || inv.IsItemCrossbow(item) || inv.ItemHasTag(item, 'crossbow'));
						isBolt = (category == 'bolt' || inv.IsItemBolt(item) || inv.ItemHasTag(item, 'bolt'));

						if ( filterBlacksmith && (isSword || isSecondary || isCrossbow || isBolt) ) equippedCandidates.PushBack(item);
						else if ( filterArmorer && isArmor ) equippedCandidates.PushBack(item);
					}
					else
					{
						equippedCandidates.PushBack(item);
					}
				}
			}
		}

		if ( includeInventory )
		{
			inv.GetAllItems(allItems);
			for (i = 0; i < allItems.Size(); i += 1)
			{
				item = allItems[i];
				if ( !equippedCandidates.Contains(item) && !player.IsItemEquipped(item) && IsItemEligible(inv, item) )
				{
					if ( filterBlacksmith || filterArmorer )
					{
						category = inv.GetItemCategory(item);
						isSword = (category == 'silversword' || category == 'steelsword' 
							|| inv.ItemHasTag(item, 'PlayerSteelWeapon') || inv.ItemHasTag(item, 'PlayerSilverWeapon'));
						isSecondary = (category == 'axe' || category == 'bludgeon' || category == 'secondary'
							|| inv.IsItemSecondaryWeapon(item) || inv.ItemHasTag(item, 'SecondaryWeapon'));
						isArmor = (category == 'armor' || category == 'boots' || category == 'gloves' || category == 'pants'
							|| inv.IsItemChestArmor(item) || inv.IsItemBoots(item) || inv.IsItemGloves(item) || inv.IsItemPants(item));
						isCrossbow = (category == 'crossbow' || inv.IsItemCrossbow(item) || inv.ItemHasTag(item, 'crossbow'));
						isBolt = (category == 'bolt' || inv.IsItemBolt(item) || inv.ItemHasTag(item, 'bolt'));

						if ( filterBlacksmith && (isSword || isSecondary || isCrossbow || isBolt) ) inventoryCandidates.PushBack(item);
						else if ( filterArmorer && isArmor ) inventoryCandidates.PushBack(item);
					}
					else
					{
						inventoryCandidates.PushBack(item);
					}
				}
			}
		}

		// Sort both groups by quality descending (Witcher/Relic -> Rare -> Magic -> Common)
		MLGSortByQuality(inv, equippedCandidates);
		MLGSortByQuality(inv, inventoryCandidates);

		// Append: Worn items first, then bagged inventory items
		for (i = 0; i < equippedCandidates.Size(); i += 1)
		{
			candidates.PushBack(equippedCandidates[i]);
		}
		for (i = 0; i < inventoryCandidates.Size(); i += 1)
		{
			candidates.PushBack(inventoryCandidates[i]);
		}

		return candidates;
	}

	public function ProcessLevelUpUpgrades(player : W3PlayerWitcher)
	{
		var cfg : CModLevelingGearConfig = GetConfig();
		var inv : CInventoryComponent = player.GetInventory();
		var candidates : array<SItemUniqueId>;
		var item : SItemUniqueId;
		var i, playerLevel, itemLevel, origBase, quality, delta : int;
		var itemCrowns, itemMats, totalCrowns, totalMats : int;
		var scaledCount, unaffordableCount : int;
		var shortageCrowns, shortageMats : int;
		var firstUnaffordableName : string;
		var upgradeMsg, shortageMsg : string;

		if ( !cfg.IsMasterEnabled() || !cfg.IsTriggerLevelUpEnabled() )
		{
			return;
		}

		playerLevel = player.GetLevel();
		candidates = CollectCandidates(player, cfg.ShouldUpgradeInventory());

		totalCrowns = 0;
		totalMats = 0;
		scaledCount = 0;
		unaffordableCount = 0;
		shortageCrowns = 0;
		shortageMats = 0;

		for (i = 0; i < candidates.Size(); i += 1)
		{
			item = candidates[i];
			itemLevel = inv.GetItemLevel(item);
			if ( playerLevel > itemLevel )
			{
				delta = playerLevel - itemLevel;
				quality = RoundMath(CalculateAttributeValue(inv.GetItemAttributeValue(item, 'quality')));
				if ( inv.IsItemBolt(item) )
				{
					itemCrowns = 0;
					itemMats = 0;
				}
				else
				{
					CalculateUpgradeCost(playerLevel, itemLevel, quality, itemCrowns, itemMats);
				}

				if ( CanAffordUpgrade(player, itemCrowns, itemMats) )
				{
					DeductUpgradeCost(player, itemCrowns, itemMats);
					SetScalingInProgress(true);
					TemperEquippedItem(inv, item, delta);
					inv.SetItemModifierInt(item, 'MLG_ScaledLevel', playerLevel);
					SetScalingInProgress(false);

					totalCrowns += itemCrowns;
					totalMats += itemMats;
					scaledCount += 1;
				}
				else
				{
					unaffordableCount += 1;
					shortageCrowns += itemCrowns;
					shortageMats += itemMats;
					if ( firstUnaffordableName == "" )
					{
						firstUnaffordableName = MLGGetItemName(inv, item);
					}
				}
			}
		}

		// Single Aggregated Output
		if ( cfg.ShouldNotify() )
		{
			if ( scaledCount > 0 )
			{
				upgradeMsg = "Leveling Gear: Upgraded " + IntToString(scaledCount) + " items to Level " + IntToString(playerLevel);
				if ( totalCrowns > 0 && totalMats > 0 )
				{
					upgradeMsg += " (-" + IntToString(totalCrowns) + " " + GetCrownsDisplayName() + ", -" + IntToString(totalMats) + " " + GetMaterialDisplayName() + ")";
				}
				else if ( totalCrowns > 0 )
				{
					upgradeMsg += " (-" + IntToString(totalCrowns) + " " + GetCrownsDisplayName() + ")";
				}
				else if ( totalMats > 0 )
				{
					upgradeMsg += " (-" + IntToString(totalMats) + " " + GetMaterialDisplayName() + ")";
				}

				player.DisplayHudMessage(upgradeMsg);

				if ( cfg.ShouldPlaySound() )
				{
					theSound.SoundEvent("gui_inventory_repair");
				}
			}

			if ( unaffordableCount > 0 )
			{
				if ( unaffordableCount == 1 )
				{
					shortageMsg = "Leveling Gear: Cannot afford " + firstUnaffordableName;
				}
				else
				{
					shortageMsg = "Leveling Gear: " + IntToString(unaffordableCount) + " items not upgraded";
				}

				if ( shortageCrowns > 0 && shortageMats > 0 )
				{
					shortageMsg += " (Needs " + IntToString(shortageCrowns) + " Crowns, " + IntToString(shortageMats) + " " + GetMaterialDisplayName() + ")";
				}
				else if ( shortageCrowns > 0 )
				{
					shortageMsg += " (Needs " + IntToString(shortageCrowns) + " Crowns)";
				}
				else if ( shortageMats > 0 )
				{
					shortageMsg += " (Needs " + IntToString(shortageMats) + " " + GetMaterialDisplayName() + ")";
				}

				player.DisplayHudMessage(shortageMsg);
			}
		}
	}

	public function ProcessItemEquipped(player : W3PlayerWitcher, item : SItemUniqueId)
	{
		var cfg : CModLevelingGearConfig = GetConfig();
		var inv : CInventoryComponent = player.GetInventory();
		var playerLevel, itemLevel, origBase, quality, delta : int;
		var crowns, mats : int;

		if ( !cfg.IsMasterEnabled() || !cfg.IsTriggerOnEquipEnabled() )
		{
			return;
		}

		if ( !IsItemEligible(inv, item) )
		{
			return;
		}

		playerLevel = player.GetLevel();
		itemLevel = inv.GetItemLevel(item);

		if ( playerLevel > itemLevel )
		{
			delta = playerLevel - itemLevel;
			quality = RoundMath(CalculateAttributeValue(inv.GetItemAttributeValue(item, 'quality')));
			CalculateUpgradeCost(playerLevel, itemLevel, quality, crowns, mats);

			if ( CanAffordUpgrade(player, crowns, mats) )
			{
				DeductUpgradeCost(player, crowns, mats);
				SetScalingInProgress(true);
				TemperEquippedItem(inv, item, delta);
				inv.SetItemModifierInt(item, 'MLG_ScaledLevel', playerLevel);
				SetScalingInProgress(false);

				if ( cfg.ShouldNotify() )
				{
					player.DisplayHudMessage("Leveling Gear: Scaled " + MLGGetItemName(inv, item) + " to Level " + IntToString(playerLevel));
				}
				if ( cfg.ShouldPlaySound() )
				{
					theSound.SoundEvent("gui_inventory_repair");
				}
			}
			else
			{
				if ( cfg.ShouldNotify() )
				{
					player.DisplayHudMessage("Leveling Gear: Cannot afford to scale " + MLGGetItemName(inv, item));
				}
			}
		}
	}

	public function ProcessCraftsmanService(player : W3PlayerWitcher, isBlacksmith : bool, isArmorer : bool)
	{
		var cfg : CModLevelingGearConfig = GetConfig();
		var inv : CInventoryComponent = player.GetInventory();
		var candidates : array<SItemUniqueId>;
		var item : SItemUniqueId;
		var i, playerLevel, itemLevel, origBase, effectiveLevel, quality, delta : int;
		var itemCrowns, itemMats, totalCrowns, totalMats : int;
		var scaledCount, downscaledCount, unaffordableCount : int;
		var shortageCrowns, shortageMats : int;
		var firstUnaffordableName : string;
		var costStr, shortageMsg : string;

		if ( !cfg.IsMasterEnabled() || !cfg.IsTriggerCrafterEnabled() )
		{
			return;
		}

		playerLevel = player.GetLevel();
		candidates = CollectCandidates(player, cfg.ShouldUpgradeInventory(), isBlacksmith, isArmorer);

		totalCrowns = 0;
		totalMats = 0;
		scaledCount = 0;
		downscaledCount = 0;
		unaffordableCount = 0;
		shortageCrowns = 0;
		shortageMats = 0;

		for (i = 0; i < candidates.Size(); i += 1)
		{
			item = candidates[i];
			itemLevel = inv.GetItemLevel(item);
			if ( playerLevel > itemLevel )
			{
				delta = playerLevel - itemLevel;
				quality = RoundMath(CalculateAttributeValue(inv.GetItemAttributeValue(item, 'quality')));
				if ( inv.IsItemBolt(item) )
				{
					itemCrowns = 0;
					itemMats = 0;
				}
				else
				{
					CalculateUpgradeCost(playerLevel, itemLevel, quality, itemCrowns, itemMats);
				}

				if ( CanAffordUpgrade(player, itemCrowns, itemMats) )
				{
					DeductUpgradeCost(player, itemCrowns, itemMats);
					SetScalingInProgress(true);
					TemperEquippedItem(inv, item, delta);
					inv.SetItemModifierInt(item, 'MLG_ScaledLevel', playerLevel);
					SetScalingInProgress(false);

					totalCrowns += itemCrowns;
					totalMats += itemMats;
					scaledCount += 1;
				}
				else
				{
					unaffordableCount += 1;
					shortageCrowns += itemCrowns;
					shortageMats += itemMats;
					if ( firstUnaffordableName == "" )
					{
						firstUnaffordableName = MLGGetItemName(inv, item);
					}
				}
			}
			else if ( cfg.ShouldDownscaleHighLevel() && cfg.GetDownscaleCostMult() > 0.001 )
			{
				effectiveLevel = inv.GetItemModifierInt(item, 'MLG_ScaledLevel');
				if ( effectiveLevel <= 0 ) effectiveLevel = origBase;
				if ( effectiveLevel <= 0 ) effectiveLevel = itemLevel;

				if ( effectiveLevel > playerLevel && inv.GetItemModifierInt(item, 'MLG_DownscalePaidLevel') < playerLevel )
				{
					quality = RoundMath(CalculateAttributeValue(inv.GetItemAttributeValue(item, 'quality')));
					CalculateDownscaleCost(playerLevel, effectiveLevel, quality, itemCrowns, itemMats);

					if ( CanAffordUpgrade(player, itemCrowns, itemMats) )
					{
						DeductUpgradeCost(player, itemCrowns, itemMats);
						inv.SetItemModifierInt(item, 'MLG_DownscalePaidLevel', playerLevel);
						totalCrowns += itemCrowns;
						totalMats += itemMats;
						downscaledCount += 1;
					}
					else
					{
						unaffordableCount += 1;
						shortageCrowns += itemCrowns;
						shortageMats += itemMats;
						if ( firstUnaffordableName == "" )
						{
							firstUnaffordableName = MLGGetItemName(inv, item);
						}
					}
				}
			}
		}

		if ( scaledCount == 0 && downscaledCount == 0 && unaffordableCount == 0 )
		{
			return;
		}

		costStr = "";
		if ( totalCrowns > 0 && totalMats > 0 )
		{
			costStr = " (-" + IntToString(totalCrowns) + " " + GetCrownsDisplayName() + ", -" + IntToString(totalMats) + " " + GetMaterialDisplayName() + ")";
		}
		else if ( totalCrowns > 0 )
		{
			costStr = " (-" + IntToString(totalCrowns) + " " + GetCrownsDisplayName() + ")";
		}
		else if ( totalMats > 0 )
		{
			costStr = " (-" + IntToString(totalMats) + " " + GetMaterialDisplayName() + ")";
		}

		if ( scaledCount > 0 && downscaledCount > 0 )
		{
			player.DisplayHudMessage("Craftsman: Tempered " + IntToString(scaledCount) + " items, Re-forged " + IntToString(downscaledCount) + " items to Level " + IntToString(playerLevel) + costStr);
		}
		else if ( scaledCount > 0 )
		{
			player.DisplayHudMessage("Craftsman: Tempered " + IntToString(scaledCount) + " items to Level " + IntToString(playerLevel) + costStr);
		}
		else if ( downscaledCount > 0 )
		{
			player.DisplayHudMessage("Craftsman: Re-forged " + IntToString(downscaledCount) + " items to Level " + IntToString(playerLevel) + costStr);
		}

		if ( (scaledCount > 0 || downscaledCount > 0) && cfg.ShouldPlaySound() )
		{
			theSound.SoundEvent("gui_inventory_repair");
		}

		if ( unaffordableCount > 0 )
		{
			if ( unaffordableCount == 1 )
			{
				shortageMsg = "Craftsman: Cannot afford " + firstUnaffordableName;
			}
			else
			{
				shortageMsg = "Craftsman: " + IntToString(unaffordableCount) + " items not upgraded";
			}

			if ( shortageCrowns > 0 && shortageMats > 0 )
			{
				shortageMsg += " (Needs " + IntToString(shortageCrowns) + " Crowns, " + IntToString(shortageMats) + " " + GetMaterialDisplayName() + ")";
			}
			else if ( shortageCrowns > 0 )
			{
				shortageMsg += " (Needs " + IntToString(shortageCrowns) + " Crowns)";
			}
			else if ( shortageMats > 0 )
			{
				shortageMsg += " (Needs " + IntToString(shortageMats) + " " + GetMaterialDisplayName() + ")";
			}

			player.DisplayHudMessage(shortageMsg);
		}
	}

	public function ProcessFieldKitUsage(player : W3PlayerWitcher, targetItem : SItemUniqueId) : bool
	{
		var cfg : CModLevelingGearConfig = GetConfig();
		var inv : CInventoryComponent = player.GetInventory();
		var playerLevel, itemLevel, origBase, delta : int;

		if ( !cfg.IsMasterEnabled() || !cfg.IsTriggerFieldKitEnabled() )
		{
			return false;
		}

		if ( !IsItemEligible(inv, targetItem) )
		{
			return false;
		}

		playerLevel = player.GetLevel();
		itemLevel = inv.GetItemLevel(targetItem);

		if ( playerLevel <= itemLevel )
		{
			return false;
		}

		delta = playerLevel - itemLevel;
		SetScalingInProgress(true);
		TemperEquippedItem(inv, targetItem, delta);
		inv.SetItemModifierInt(targetItem, 'MLG_ScaledLevel', playerLevel);
		SetScalingInProgress(false);

		if ( cfg.ShouldPlaySound() )
		{
			theSound.SoundEvent("gui_inventory_repair");
		}

		player.DisplayHudMessage("Field Kit: Tempered " + MLGGetItemName(inv, targetItem) + " to Level " + IntToString(playerLevel));
		return true;
	}

	public function ProcessLootItem(inv : CInventoryComponent, item : SItemUniqueId)
	{
		var cfg : CModLevelingGearConfig = GetConfig();
		var playerLevel, itemLevel, delta : int;

		if ( !cfg.IsMasterEnabled() || !cfg.ShouldScaleLootDrops() || !inv || !inv.IsIdValid(item) || IsScalingInProgress() )
		{
			return;
		}

		if ( thePlayer )
		{
			playerLevel = thePlayer.GetLevel();
		}
		if ( playerLevel <= 0 )
		{
			return;
		}

		if ( IsItemEligible(inv, item) )
		{
			itemLevel = inv.GetItemLevel(item);
			if ( playerLevel > itemLevel )
			{
				delta = playerLevel - itemLevel;
				SetScalingInProgress(true);
				TemperEquippedItem(inv, item, delta);
				inv.SetItemModifierInt(item, 'MLG_ScaledLevel', playerLevel);
				SetScalingInProgress(false);
			}
			else if ( itemLevel > playerLevel && cfg.ShouldDownscaleHighLevel() )
			{
				EnsureBaseLevelSnapshot(inv, item, itemLevel);
				inv.SetItemModifierInt(item, 'MLG_ScaledLevel', playerLevel);
				inv.SetItemModifierInt(item, 'MLG_DownscalePaidLevel', playerLevel);
			}
		}
	}

	public function ProcessLootContainer(container : W3Container)
	{
		var cfg : CModLevelingGearConfig = GetConfig();
		var inv : CInventoryComponent;
		var items : array<SItemUniqueId>;
		var i : int;

		if ( !cfg.IsMasterEnabled() || !cfg.ShouldScaleLootDrops() || !container )
		{
			return;
		}

		inv = container.GetInventory();
		if ( !inv )
		{
			return;
		}

		inv.GetAllItems(items);

		for (i = 0; i < items.Size(); i += 1)
		{
			ProcessLootItem(inv, items[i]);
		}
	}
}

@addField(CR4Game)
public var modLevelingGearManager : CModLevelingGearManager;

@addMethod(CR4Game)
public function GetOrCreateModLevelingGearManager() : CModLevelingGearManager
{
	if ( !modLevelingGearManager )
	{
		modLevelingGearManager = new CModLevelingGearManager in this;
	}
	return modLevelingGearManager;
}

function GetModLevelingGearManager() : CModLevelingGearManager
{
	return theGame.GetOrCreateModLevelingGearManager();
}

// ====================================================================
// Console Exec Commands
// ====================================================================
exec function levelgear()
{
	var player : W3PlayerWitcher = GetWitcherPlayer();
	var inv : CInventoryComponent = player.GetInventory();
	var cfg : CModLevelingGearConfig = GetModLevelingGearConfig();
	var candidates : array<SItemUniqueId>;
	var item : SItemUniqueId;
	var i, pLvl, iLvl, origBase, delta, count : int;
	var itemName : string;

	pLvl = player.GetLevel();
	candidates = GetModLevelingGearManager().CollectCandidates(player, cfg.ShouldUpgradeInventory());

	count = 0;
	for (i = 0; i < candidates.Size(); i += 1)
	{
		item = candidates[i];
		itemName = MLGGetItemName(inv, item);
		iLvl = inv.GetItemLevel(item);
		if ( pLvl > iLvl )
		{
			delta = pLvl - iLvl;
			GetModLevelingGearManager().TemperEquippedItem(inv, item, delta);
			inv.SetItemModifierInt(item, 'MLG_ScaledLevel', pLvl);
			count += 1;
			player.DisplayHudMessage("Scaled " + itemName + " (Lvl " + IntToString(iLvl) + " -> " + IntToString(pLvl) + ")");
		}
		else if ( iLvl > pLvl && cfg.ShouldDownscaleHighLevel() )
		{
			inv.SetItemModifierInt(item, 'MLG_ScaledLevel', pLvl);
			inv.SetItemModifierInt(item, 'MLG_DownscalePaidLevel', pLvl);
			count += 1;
			player.DisplayHudMessage("Downscaled " + itemName + " (Lvl " + IntToString(iLvl) + " -> " + IntToString(pLvl) + ")");
		}
		else
		{
			player.DisplayHudMessage(itemName + " is already Lvl " + IntToString(iLvl) + " (Player Lvl " + IntToString(pLvl) + ")");
		}
	}

	if ( count == 0 )
	{
		player.DisplayHudMessage("levelgear: All eligible gear is at or above player level.");
	}
}

exec function levelitem()
{
	var player : W3PlayerWitcher = GetWitcherPlayer();
	var inv : CInventoryComponent = player.GetInventory();
	var item : SItemUniqueId;
	var pLvl, iLvl, delta : int;
	var found : bool;

	pLvl = player.GetLevel();
	found = player.GetItemEquippedOnSlot(EES_SteelSword, item);
	if ( !found )
		found = player.GetItemEquippedOnSlot(EES_SilverSword, item);
	if ( !found )
		found = player.GetItemEquippedOnSlot(EES_Armor, item);

	if ( found )
	{
		iLvl = inv.GetItemLevel(item);
		if ( pLvl > iLvl )
		{
			delta = pLvl - iLvl;
			GetModLevelingGearManager().TemperEquippedItem(inv, item, delta);
			inv.SetItemModifierInt(item, 'MLG_ScaledLevel', pLvl);
			player.DisplayHudMessage("levelitem: Upgraded " + MLGGetItemName(inv, item) + " to Level " + IntToString(pLvl));
		}
		else
		{
			player.DisplayHudMessage("levelitem: " + MLGGetItemName(inv, item) + " is already Level " + IntToString(iLvl));
		}
	}
	else
	{
		player.DisplayHudMessage("levelitem: No weapon or armor equipped.");
	}
}

exec function mlgdebug()
{
	var player : W3PlayerWitcher = GetWitcherPlayer();
	var inv : CInventoryComponent = player.GetInventory();
	var cfg : CModLevelingGearConfig = GetModLevelingGearConfig();
	var mgr : CModLevelingGearManager = GetModLevelingGearManager();
	var item : SItemUniqueId;
	var slots : array<EEquipmentSlots>;
	var i : int;

	player.DisplayHudMessage("=== Leveling Gear Debug ===");
	player.DisplayHudMessage("Enabled: " + BoolToString(cfg.IsMasterEnabled()) + " | TriggerLevelUp: " + BoolToString(cfg.IsTriggerLevelUpEnabled()));
	player.DisplayHudMessage("TriggerOnEquip: " + BoolToString(cfg.IsTriggerOnEquipEnabled()) + " | UpgradeInv: " + BoolToString(cfg.ShouldUpgradeInventory()));
	player.DisplayHudMessage("Downscale: " + BoolToString(cfg.ShouldDownscaleHighLevel()) + " (Mult: " + FloatToStringPrec(cfg.GetDownscaleCostMult(), 2) + ") | ScaleLoot: " + BoolToString(cfg.ShouldScaleLootDrops()));
	player.DisplayHudMessage("Money: " + IntToString(player.GetMoney()) + " Crowns | " + mgr.GetMaterialDisplayName() + ": " + IntToString(mgr.GetMaterialCount(inv)));

	slots.PushBack(EES_SteelSword);
	slots.PushBack(EES_SilverSword);
	slots.PushBack(EES_Armor);

	for (i = 0; i < slots.Size(); i += 1)
	{
		if ( player.GetItemEquippedOnSlot(slots[i], item) )
		{
			player.DisplayHudMessage("Equipped: " + MLGGetItemName(inv, item) + " [Lvl " + IntToString(inv.GetItemLevel(item)) + ", Eligible: " + BoolToString(mgr.IsItemEligible(inv, item)) + "]");
		}
	}
}

exec function TemperEquippedGear()
{
	GetModLevelingGearManager().ProcessCraftsmanService(GetWitcherPlayer(), true, true);
}

exec function TemperSwords()
{
	GetModLevelingGearManager().ProcessCraftsmanService(GetWitcherPlayer(), true, false);
}

exec function TemperArmor()
{
	GetModLevelingGearManager().ProcessCraftsmanService(GetWitcherPlayer(), false, true);
}

exec function UseFieldTemperingKit()
{
	var item : SItemUniqueId;
	var player : W3PlayerWitcher = GetWitcherPlayer();
	if ( player.GetItemEquippedOnSlot(EES_SilverSword, item) )
		GetModLevelingGearManager().ProcessFieldKitUsage(player, item);
	if ( player.GetItemEquippedOnSlot(EES_SteelSword, item) )
		GetModLevelingGearManager().ProcessFieldKitUsage(player, item);
	if ( player.GetItemEquippedOnSlot(EES_Armor, item) )
		GetModLevelingGearManager().ProcessFieldKitUsage(player, item);
	if ( player.GetItemEquippedOnSlot(EES_Boots, item) )
		GetModLevelingGearManager().ProcessFieldKitUsage(player, item);
	if ( player.GetItemEquippedOnSlot(EES_Gloves, item) )
		GetModLevelingGearManager().ProcessFieldKitUsage(player, item);
	if ( player.GetItemEquippedOnSlot(EES_Pants, item) )
		GetModLevelingGearManager().ProcessFieldKitUsage(player, item);
}
