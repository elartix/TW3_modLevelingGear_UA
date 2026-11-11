/***********************************************************************/
/** 	Leveling Gear (Update 5.0 Remastered & Next-Gen)
/** 	REDkit Script Overrides & Clean Annotations
/***********************************************************************/

@addMethod(CInventoryComponent)
public function isItemScalable(item : SItemUniqueId) : bool
{
	return GetModLevelingGearManager().IsItemEligible(this, item);
}

@wrapMethod(CInventoryComponent)
function GetItemLevel(item : SItemUniqueId) : int
{
	var baseLvl, origBase, scaledLvl, effectiveLvl, playerLvl : int;
	var cfg : CModLevelingGearConfig;
	var curStacks, missingStacks, k : int;

	cfg = GetModLevelingGearConfig();
	baseLvl = wrappedMethod(item);

	if ( cfg.ShouldExcludeAerondight() && ItemHasTag(item, 'Aerondight') )
	{
		return baseLvl;
	}

	if ( baseLvl > 0 && isItemScalable(item) )
	{
		GetModLevelingGearManager().EnsureBaseLevelSnapshot(this, item, baseLvl);
	}

	origBase = GetItemModifierInt(item, 'MLG_BaseLevel');
	if ( origBase <= 0 )
	{
		origBase = baseLvl;
	}

	scaledLvl = GetItemModifierInt(item, 'MLG_ScaledLevel');

	if ( scaledLvl > 0 )
	{
		effectiveLvl = scaledLvl;
	}
	else
	{
		effectiveLvl = baseLvl;
	}

	if ( cfg.ShouldDownscaleHighLevel() && isItemScalable(item) )
	{
		if ( thePlayer )
		{
			playerLvl = thePlayer.GetLevel();
			if ( playerLvl > 0 && origBase > playerLvl )
			{
				if ( cfg.GetDownscaleCostMult() <= 0.001 || GetItemModifierInt(item, 'MLG_DownscalePaidLevel') >= playerLvl || IsItemCrossbow(item) )
				{
					SetItemModifierInt(item, 'MLG_ScaledLevel', playerLvl);
					return playerLvl;
				}
			}
			else if ( origBase > 0 && GetItemModifierInt(item, 'MLG_ScaledLevel') > 0 && GetItemModifierInt(item, 'MLG_ScaledLevel') < origBase )
			{
				SetItemModifierInt(item, 'MLG_ScaledLevel', origBase);
			}
		}
	}

	if ( cfg.IsMasterEnabled() && cfg.ShouldScaleCrossbows() && effectiveLvl > baseLvl && IsItemCrossbow(item) )
	{
		curStacks = GetItemModifierInt(item, 'MLG_CrossbowScaledStacks');
		missingStacks = (effectiveLvl - baseLvl) - curStacks;
		if ( missingStacks > 0 )
		{
			for ( k = 0; k < missingStacks; k += 1 )
			{
				AddItemCraftedAbility(item, 'Rune elemental _Stats', true);
			}
			SetItemModifierInt(item, 'MLG_CrossbowScaledStacks', effectiveLvl - baseLvl);
		}
	}

	return effectiveLvl;
}

@wrapMethod(CInventoryComponent)
function GetItemStats(itemId : SItemUniqueId, out itemStats : array<SAttributeTooltip>, optional respectAttributeOrder : bool)
{
	wrappedMethod(itemId, itemStats, respectAttributeOrder);
	GetModLevelingGearManager().NormalizeTooltipStats(this, itemId, itemStats);
}

@wrapMethod(CInventoryComponent)
function GetItemBaseStats(itemId : SItemUniqueId, out itemStats : array<SAttributeTooltip>)
{
	wrappedMethod(itemId, itemStats);
	GetModLevelingGearManager().NormalizeTooltipStats(this, itemId, itemStats);
}

@wrapMethod(CInventoryComponent)
function GetItemPrimaryStat(itemId : SItemUniqueId, out attributeLabel : string, out attributeVal : float)
{
	var delta : float;
	var mgr : CModLevelingGearManager;

	wrappedMethod(itemId, attributeLabel, attributeVal);

	mgr = GetModLevelingGearManager();
	if ( mgr && isItemScalable(itemId) )
	{
		delta = mgr.GetPrimaryStatDownscaleDelta(this, itemId);
		if ( delta > 0.0 )
		{
			attributeVal = attributeVal - delta;
			if ( attributeVal < 1.0 )
			{
				attributeVal = 1.0;
			}
		}
	}
}

@wrapMethod(CInventoryComponent)
function GetItemArmorTotal(item : SItemUniqueId) : SAbilityAttributeValue
{
	var v : SAbilityAttributeValue;
	var d, m : float;
	var mgr : CModLevelingGearManager;

	v = wrappedMethod(item);

	mgr = GetModLevelingGearManager();
	if ( mgr && isItemScalable(item) )
	{
		d = mgr.GetPrimaryStatDownscaleDelta(this, item);
		if ( d > 0.0 )
		{
			v.valueAdditive = v.valueAdditive - d;
			m = theGame.params.GetDurabilityMultiplier( GetItemDurabilityRatio(item), false );
			// REDengine SAbilityAttributeValue defaults valueMultiplicative to 0.0 on item attributes,
			// causing CalculateAttributeValue(v) to multiply valueBase by 0 and destroy armor stats.
			// Clamp net additive directly so total armor remains >= 1.0 without destroying valueBase.
			if ( (v.valueBase + v.valueAdditive) < 1.0 )
			{
				v.valueAdditive = 1.0 - v.valueBase;
			}
		}
	}

	return v;
}

@wrapMethod(W3TooltipComponent)
function GetCrossbowPrimatyStat(itemId : SItemUniqueId, itemInvComponent : CInventoryComponent, out primaryStatLabel : string, out primaryStatValue : float)
{
	var ratio : float;
	var mgr : CModLevelingGearManager;

	wrappedMethod(itemId, itemInvComponent, primaryStatLabel, primaryStatValue);

	mgr = GetModLevelingGearManager();
	if ( mgr && itemInvComponent.isItemScalable(itemId) )
	{
		ratio = mgr.GetItemScalingRatio(itemInvComponent, itemId);
		if ( ratio < 0.999 && ratio > 0.0 )
		{
			primaryStatValue = primaryStatValue * ratio;
			if ( primaryStatValue < 1.0 )
			{
				primaryStatValue = 1.0;
			}
		}
	}
}

@wrapMethod(W3PlayerWitcher)
function GetTotalWeaponDamage(weaponId : SItemUniqueId, damageTypeName : name, crossbowId : SItemUniqueId) : float
{
	var damage, delta : float;
	var mult : float;
	var inv : CInventoryComponent;
	var mgr : CModLevelingGearManager;

	damage = wrappedMethod(weaponId, damageTypeName, crossbowId);

	inv = GetInventory();
	mgr = GetModLevelingGearManager();
	if ( inv && mgr && inv.IsIdValid(weaponId) && inv.isItemScalable(weaponId) )
	{
		if ( mgr.IsPrimaryDamageType(inv, weaponId, damageTypeName) && !inv.IsItemCrossbow(weaponId) && !inv.IsItemBolt(weaponId) )
		{
			// Crossbow shots / bolts are scaled exclusively via GetPrimaryDamageMultiplier; never apply melee downscale delta to bolts
			if ( !inv.IsIdValid(crossbowId) )
			{
				delta = mgr.GetPrimaryStatDownscaleDelta(inv, weaponId);
				if ( delta > 0.0 )
				{
					damage = MaxF(10.0, damage - delta);
					return damage;
				}
			}
		}
	}

	if ( mgr )
	{
		mult = mgr.GetPrimaryDamageMultiplier(inv, weaponId, crossbowId);
		if ( mult != 1.0 && mult > 0.0 )
		{
			damage = damage * mult;
		}
	}

	// Fail-safe: Underwater bolt damage against monsters must never be attenuated below baseline
	if ( (this.IsSwimming() || this.IsDiving() || this.GetCurrentStateName() == 'Swimming') && (inv && (inv.IsItemBolt(weaponId) || inv.IsIdValid(crossbowId))) && damage < 100.0 && (damageTypeName == theGame.params.DAMAGE_NAME_SILVER || damageTypeName == theGame.params.DAMAGE_NAME_PIERCING) )
	{
		damage = MaxF(400.0, damage);
	}

	return damage;
}

@wrapMethod(CActor)
function GetAttributeValue(attributeName : name, optional tags : array<name>, optional ignoreDeath : bool) : SAbilityAttributeValue
{
	var val : SAbilityAttributeValue;
	var corr : float;
	var mgr : CModLevelingGearManager;

	val = wrappedMethod(attributeName, tags, ignoreDeath);

	if ( this == thePlayer && val.valueBase != -1 )
	{
		mgr = GetModLevelingGearManager();
		if ( mgr && mgr.IsNormalizableSecondaryAttribute(attributeName) )
		{
			corr = mgr.GetSecondaryAttributeCorrection(GetWitcherPlayer(), attributeName);
			if ( corr != 0.0 )
			{
				val.valueAdditive += corr;
				if ( val.valueAdditive < 0.0 )
				{
					val.valueAdditive = 0.0;
				}
			}
		}
	}

	return val;
}

@wrapMethod(CInventoryComponent)
function OnItemAdded(data : SItemChangedData)
{
	var i, baseLvl, pLvl : int;
	var ent : CEntity;
	var mgr : CModLevelingGearManager;
	var cfg : CModLevelingGearConfig;
	var itemId : SItemUniqueId;

	wrappedMethod(data);

	ent = GetEntity();
	if ( ent != thePlayer && ent != GetWitcherPlayer() )
	{
		return true;
	}

	cfg = GetModLevelingGearConfig();
	if ( !cfg.IsMasterEnabled() )
	{
		return true;
	}

	mgr = GetModLevelingGearManager();
	if ( !mgr || mgr.IsScalingInProgress() )
	{
		return true;
	}

	pLvl = thePlayer.GetLevel();

	for (i = 0; i < data.ids.Size(); i += 1)
	{
		itemId = data.ids[i];
		if ( !IsIdValid(itemId) )
		{
			continue;
		}

		if ( isItemScalable(itemId) )
		{
			// Trigger GetItemLevel to perform native unwrapped template snapshot & auto-downscale
			GetItemLevel(itemId);

			if ( cfg.ShouldScaleLootDrops() && pLvl > 0 )
			{
				baseLvl = GetItemModifierInt(itemId, 'MLG_BaseLevel');
				if ( pLvl > baseLvl )
				{
					mgr.ProcessLootItem(this, itemId);
				}
			}
		}
	}

	return true;
}

@wrapMethod(W3PlayerWitcher)
function OnLevelGained(currentLevel : int, show : bool)
{
	wrappedMethod(currentLevel, show);
	if ( GetModLevelingGearConfig().IsTriggerLevelUpEnabled() )
	{
		GetModLevelingGearManager().ProcessLevelUpUpgrades(this);
	}
}

@wrapMethod(W3PlayerWitcher)
function EquipItem(item : SItemUniqueId, optional slot : EEquipmentSlots, optional toHand : bool) : bool
{
	var res : bool;
	res = wrappedMethod(item, slot, toHand);
	if ( res && GetModLevelingGearConfig().IsTriggerOnEquipEnabled() )
	{
		GetModLevelingGearManager().ProcessItemEquipped(this, item);
	}
	return res;
}

@wrapMethod(W3PlayerWitcher)
function IsItemRepairAble(item : SItemUniqueId) : bool
{
	var cfg : CModLevelingGearConfig;

	cfg = GetModLevelingGearConfig();
	if ( cfg.IsMasterEnabled() && cfg.IsTriggerFieldKitEnabled() && cfg.ShouldAllowFieldKitOnPristine() )
	{
		if ( inv.isItemScalable(item) && this.GetLevel() > inv.GetItemLevel(item) )
		{
			return true;
		}
	}
	return wrappedMethod(item);
}

@wrapMethod(W3PlayerWitcher)
function RepairItem(rapairKitId : SItemUniqueId, usedOnItem : SItemUniqueId)
{
	var cfg : CModLevelingGearConfig;
	var allowPristine : bool;
	var wasPristine : bool;

	cfg = GetModLevelingGearConfig();
	allowPristine = ( cfg.IsMasterEnabled() && cfg.IsTriggerFieldKitEnabled() && cfg.ShouldAllowFieldKitOnPristine() );
	if ( allowPristine && (!inv.HasItemDurability(usedOnItem) || inv.GetItemDurability(usedOnItem) >= inv.GetItemMaxDurability(usedOnItem)) )
	{
		wasPristine = true;
	}

	wrappedMethod(rapairKitId, usedOnItem);

	if ( wasPristine )
	{
		inv.RemoveItem(rapairKitId, 1);
	}

	if ( cfg.IsTriggerFieldKitEnabled() )
	{
		GetModLevelingGearManager().ProcessFieldKitUsage(this, usedOnItem);
	}
}

@wrapMethod(W3GuiRepairInventoryComponent)
function CanRepairItem( item : SItemUniqueId ) : bool
{
	// Crossbows have no durability: never inject them into the durability repair list (avoids Repair-All price desync).
	return wrappedMethod(item);
}

@wrapMethod(W3GuiRepairInventoryComponent)
function ShouldShowItem(item : SItemUniqueId) : bool
{
	var cfg : CModLevelingGearConfig;
	var isCraftsmanMatch : bool;
	var res : bool;

	res = wrappedMethod(item);
	if ( res )
	{
		return true;
	}

	cfg = GetModLevelingGearConfig();
	if ( cfg.IsMasterEnabled() && cfg.IsTriggerCrafterEnabled() && cfg.GetCraftsmanUpgradeMode() == 0 )
	{
		isCraftsmanMatch = ( (repairArmors && _inv.IsItemAnyArmor(item))
			|| (repairSwords && (_inv.IsItemSteelSwordUsableByPlayer(item) || _inv.IsItemSilverSwordUsableByPlayer(item) || _inv.IsItemSecondaryWeapon(item) || (_inv.IsItemCrossbow(item) && cfg.ShouldScaleCrossbows()))) );

		if ( isCraftsmanMatch && _inv.isItemScalable(item) )
		{
			if ( thePlayer.GetLevel() > _inv.GetItemLevel(item) )
			{
				if ( cfg.ShouldUpgradeInventory() || GetWitcherPlayer().IsItemEquipped(item) )
				{
					return !_inv.ItemHasTag(item, theGame.params.TAG_DONT_SHOW);
				}
			}
		}
	}

	return false;
}

@wrapMethod(CR4BlacksmithMenu)
function OnConfigUI()
{
	wrappedMethod();
	if ( GetModLevelingGearConfig().IsTriggerCrafterEnabled() && GetModLevelingGearConfig().GetCraftsmanUpgradeMode() == 1 )
	{
		GetModLevelingGearManager().ProcessCraftsmanService(GetWitcherPlayer(), true, true);
	}
}

@wrapMethod(CR4BlacksmithMenu)
function OnRepairItem(item : SItemUniqueId, price : int)
{
	var cfg : CModLevelingGearConfig;
	var mgr : CModLevelingGearManager;
	var player : W3PlayerWitcher;
	var inv : CInventoryComponent;
	var pLvl, iLvl, quality, delta, crowns, mats, action : int;
	var wasPristine : bool;

	player = GetWitcherPlayer();
	inv = player.GetInventory();
	wasPristine = ( !inv.HasItemDurability(item) || inv.GetItemDurability(item) >= inv.GetItemMaxDurability(item) );

	// 1. GUARANTEED VANILLA REPAIR: Always executes durability repair first
	wrappedMethod(item, price);

	// 2. LEVEL TEMPERING: Strictly an optional secondary evaluation
	cfg = GetModLevelingGearConfig();
	if ( !cfg.IsMasterEnabled() || !cfg.IsTriggerCrafterEnabled() || cfg.GetCraftsmanUpgradeMode() != 0 )
	{
		return true;
	}

	action = cfg.GetCraftsmanRepairAction(); // 0 = Repair Only, 1 = Repair + Temper [Default], 2 = Temper Only When Pristine
	if ( action == 0 )
	{
		return true;
	}
	if ( action == 2 && !wasPristine )
	{
		return true;
	}

	pLvl = player.GetLevel();
	iLvl = inv.GetItemLevel(item);
	if ( pLvl > iLvl && inv.isItemScalable(item) )
	{
		mgr = GetModLevelingGearManager();
		delta = pLvl - iLvl;
		quality = RoundMath(CalculateAttributeValue(inv.GetItemAttributeValue(item, 'quality')));
		mgr.CalculateUpgradeCost(pLvl, iLvl, quality, crowns, mats);

		if ( !mgr.CanAffordUpgrade(player, crowns, mats) )
		{
			player.DisplayHudMessage("Craftsman: Durability repaired (Tempering skipped: insufficient funds)");
			return true;
		}

		mgr.DeductUpgradeCost(player, crowns, mats);
		mgr.SetScalingInProgress(true);
		mgr.TemperEquippedItem(inv, item, delta);
		inv.SetItemModifierInt(item, 'MLG_ScaledLevel', pLvl);
		mgr.SetScalingInProgress(false);

		if ( crowns > 0 && mats > 0 )
			player.DisplayHudMessage("Craftsman: Tempered " + MLGGetItemName(inv, item) + " to Level " + IntToString(pLvl) + " (-" + IntToString(crowns) + " " + mgr.GetCrownsDisplayName() + ", -" + IntToString(mats) + " " + mgr.GetMaterialDisplayName() + ")");
		else if ( crowns > 0 )
			player.DisplayHudMessage("Craftsman: Tempered " + MLGGetItemName(inv, item) + " to Level " + IntToString(pLvl) + " (-" + IntToString(crowns) + " " + mgr.GetCrownsDisplayName() + ")");
		else if ( mats > 0 )
			player.DisplayHudMessage("Craftsman: Tempered " + MLGGetItemName(inv, item) + " to Level " + IntToString(pLvl) + " (-" + IntToString(mats) + " " + mgr.GetMaterialDisplayName() + ")");
		else
			player.DisplayHudMessage("Craftsman: Tempered " + MLGGetItemName(inv, item) + " to Level " + IntToString(pLvl));
	}

	return true;
}

@wrapMethod(W3Container)
function ProcessLoot()
{
	wrappedMethod();
	if ( GetModLevelingGearConfig().ShouldScaleLootDrops() )
	{
		GetModLevelingGearManager().ProcessLootContainer(this);
	}
}

@wrapMethod(CR4LootPopup)
function BuildCache(rootContainer : W3Container, range : float, containerClass : name)
{
	if ( GetModLevelingGearConfig().ShouldScaleLootDrops() )
	{
		GetModLevelingGearManager().ProcessLootContainer(rootContainer);
	}
	wrappedMethod(rootContainer, range, containerClass);
}

@wrapMethod(W3Stash)
function OnInteraction( actionName : string, activator : CEntity )
{
	var mgr : CModLevelingGearManager;
	var cfg : CModLevelingGearConfig;

	wrappedMethod(actionName, activator);

	if ( activator == thePlayer )
	{
		cfg = GetModLevelingGearConfig();
		if ( cfg && cfg.IsMasterEnabled() && cfg.ShouldUpgradeStash() && cfg.IsTriggerStashOpenEnabled() )
		{
			mgr = GetModLevelingGearManager();
			if ( mgr )
			{
				mgr.ProcessStashUpgrades(GetWitcherPlayer());
			}
		}
	}
}

function ModLevelingGear_GiveTestGear()
{
	var witcher : W3PlayerWitcher;
	var inv : CInventoryComponent;

	witcher = GetWitcherPlayer();
	if ( !witcher )
	{
		thePlayer.DisplayHudMessage("Leveling Gear: Player not ready!");
		return;
	}

	inv = witcher.GetInventory();
	if ( !inv )
	{
		return;
	}

	// 1. Common (Tier 1 - White)
	inv.AddAnItem('No Mans Land sword 1', 1);
	inv.AddAnItem('Silver sword 1', 1);
	inv.AddAnItem('Medium armor 01', 1);

	// 2. Masterwork (Tier 2 - Blue)
	inv.AddAnItem('No Mans Land sword 2', 1);
	inv.AddAnItem('Silver sword 2', 1);
	inv.AddAnItem('Medium armor 02', 1);

	// 3. Magic (Tier 3 - Yellow)
	inv.AddAnItem('No Mans Land sword 3', 1);
	inv.AddAnItem('Silver sword 3', 1);
	inv.AddAnItem('Medium armor 03', 1);

	// 4. Relic (Tier 4 - Orange)
	inv.AddAnItem('No Mans Land sword 4', 1);
	inv.AddAnItem('Silver sword 4', 1);
	inv.AddAnItem('Medium armor 04', 1);
	inv.AddAnItem('Beannshie_crafted', 1);

	// 5. Witcher School (Tier 5 - Green Grandmaster Set)
	inv.AddAnItem('Lynx School steel sword 4', 1);
	inv.AddAnItem('Lynx School silver sword 4', 1);
	inv.AddAnItem('Lynx Armor 4', 1);
	inv.AddAnItem('Lynx Pants 5', 1);
	inv.AddAnItem('Lynx Boots 5', 1);
	inv.AddAnItem('Lynx Gloves 5', 1);

	// 6. Crossbow & Ammunition
	inv.AddAnItem('Crossbow 7', 1);
	inv.AddAnItem('Split Bolt', 30);
	inv.AddAnItem('Explosive Bolt', 30);

	// 7. Secondary Weapons & Repair Kits
	inv.AddAnItem('W_Axe01', 1);
	inv.AddAnItem('W_Axe05', 1);
	inv.AddAnItem('W_Axe06', 1);
	inv.AddAnItem('Weapon repair kit 3', 5);
	inv.AddAnItem('Armor repair kit 3', 5);
	inv.AddAnItem('Dwimeryte ingot', 10);
	witcher.AddMoney(2000);

	theGame.GetGuiManager().ShowNotification("Leveling Gear: Test gear added across all 5 rarity tiers!", 0, false);
}

function ModLevelingGear_GiveTestAxes()
{
	var witcher : W3PlayerWitcher;
	var inv : CInventoryComponent;

	witcher = GetWitcherPlayer();
	if ( !witcher )
	{
		thePlayer.DisplayHudMessage("Leveling Gear: Player not ready!");
		return;
	}

	inv = witcher.GetInventory();
	if ( !inv )
	{
		return;
	}

	// Secondary Weapons (Axes, Clubs, Maces)
	inv.AddAnItem('W_Axe01', 1);
	inv.AddAnItem('W_Axe02', 1);
	inv.AddAnItem('W_Axe03', 1);
	inv.AddAnItem('W_Axe04', 1);
	inv.AddAnItem('W_Axe05', 1);
	inv.AddAnItem('W_Axe06', 1);
	inv.AddAnItem('W_Club', 1);
	inv.AddAnItem('W_Mace01', 1);

	// Repair Kits (for field tempering tests)
	inv.AddAnItem('Weapon repair kit 3', 5);
	inv.AddAnItem('Armor repair kit 3', 5);

	// Crafting materials & Crowns (for blacksmith tempering tests)
	inv.AddAnItem('Dwimeryte ingot', 10);
	inv.AddAnItem('Meteorite ore', 10);
	witcher.AddMoney(5000);

	theGame.GetGuiManager().ShowNotification("Leveling Gear: All test axes, repair kits & crafting funds added!", 0, false);
}

exec function mlg_testaxes()
{
	ModLevelingGear_GiveTestAxes();
}

exec function mlgaxes()
{
	ModLevelingGear_GiveTestAxes();
}

function ModLevelingGear_GrantOverleveledItem(witcher : W3PlayerWitcher, template : name, targetLevel : int) : bool
{
	var inv : CInventoryComponent;
	var items : array<SItemUniqueId>;
	var item : SItemUniqueId;
	var curLvl, delta : int;
	var mgr : CModLevelingGearManager;

	if ( !witcher ) return false;
	inv = witcher.GetInventory();
	if ( !inv ) return false;
	mgr = GetModLevelingGearManager();

	inv.AddAnItem(template, 1);
	items = inv.GetItemsByName(template);
	if ( items.Size() == 0 ) return false;
	item = items[items.Size() - 1];

	curLvl = inv.GetItemLevel(item);
	if ( curLvl <= 0 ) curLvl = 1;

	delta = targetLevel - curLvl;
	if ( delta > 80 ) delta = 80;
	if ( delta > 0 )
	{
		mgr.SetScalingInProgress(true);
		mgr.TemperEquippedItem(inv, item, delta);
		mgr.SetScalingInProgress(false);
	}

	inv.SetItemModifierInt(item, 'MLG_BaseLevel', targetLevel);
	inv.SetItemModifierInt(item, 'MLG_ScaledLevel', targetLevel);
	inv.SetItemModifierInt(item, 'MLG_DownscalePaidLevel', 0);

	witcher.DisplayHudMessage("Spawned " + MLGGetItemName(inv, item)
		+ " as Level " + IntToString(targetLevel)
		+ ". Downscaled to your level (" + IntToString(witcher.GetLevel()) + ").");
	return true;
}

exec function mlg_testaxe68()
{
	ModLevelingGear_GrantOverleveledItem(GetWitcherPlayer(), 'W_Axe06', 68);
}

exec function mlg_testaxe( targetLevel : int )
{
	ModLevelingGear_GrantOverleveledItem(GetWitcherPlayer(), 'W_Axe06', targetLevel);
}

exec function mlg_temperaxes()
{
	var player : W3PlayerWitcher = GetWitcherPlayer();
	var inv : CInventoryComponent;
	var mgr : CModLevelingGearManager;
	var items : array<SItemUniqueId>;
	var item : SItemUniqueId;
	var category : name;
	var i, pLvl, iLvl, delta, n : int;

	if ( !player ) return;
	inv = player.GetInventory();
	mgr = GetModLevelingGearManager();
	if ( !inv || !mgr ) return;

	pLvl = player.GetLevel();
	inv.GetAllItems(items);
	n = 0;
	for ( i = 0; i < items.Size(); i += 1 )
	{
		item = items[i];
		if ( !inv.isItemScalable(item) ) continue;
		category = inv.GetItemCategory(item);
		if ( !(inv.IsItemSecondaryWeapon(item) || category == 'steelsword' || category == 'axe' || category == 'bludgeon' || category == 'secondary' || inv.ItemHasTag(item,'PlayerSteelWeapon') || inv.ItemHasTag(item, 'SecondaryWeapon')) ) continue;
		iLvl = inv.GetItemLevel(item);
		if ( pLvl > iLvl )
		{
			delta = pLvl - iLvl;
			mgr.SetScalingInProgress(true);
			mgr.TemperEquippedItem(inv, item, delta);
			inv.SetItemModifierInt(item, 'MLG_ScaledLevel', pLvl);
			mgr.SetScalingInProgress(false);
			n += 1;
		}
	}
	player.DisplayHudMessage("Leveling Gear: Tempered " + IntToString(n) + " secondary/steel items to Level " + IntToString(pLvl) + ".");
}

exec function mlg_axediag()
{
	var p : W3PlayerWitcher = GetWitcherPlayer();
	var inv : CInventoryComponent;
	var mgr : CModLevelingGearManager;
	var items : array<SItemUniqueId>;
	var item : SItemUniqueId;
	var i : int;

	if ( !p ) return;
	inv = p.GetInventory();
	mgr = GetModLevelingGearManager();
	if ( !inv || !mgr ) return;

	inv.GetAllItems(items);
	for ( i = 0; i < items.Size(); i += 1 )
	{
		item = items[i];
		if ( inv.IsItemSecondaryWeapon(item) || inv.GetItemCategory(item) == 'steelsword' || inv.GetItemCategory(item) == 'axe' || inv.ItemHasTag(item, 'SecondaryWeapon') )
		{
			p.DisplayHudMessage(MLGGetItemName(inv, item)
				+ " | eligible=" + BoolToString(mgr.IsItemEligible(inv, item))
				+ " | base=" + IntToString(inv.GetItemModifierInt(item,'MLG_BaseLevel'))
				+ " | scaled=" + IntToString(inv.GetItemModifierInt(item,'MLG_ScaledLevel'))
				+ " | lvl=" + IntToString(inv.GetItemLevel(item)));
		}
	}
}

exec function mlg_testgear()
{
	ModLevelingGear_GiveTestGear();
}

exec function mlgtest()
{
	ModLevelingGear_GiveTestGear();
}

exec function testlevelinggear()
{
	ModLevelingGear_GiveTestGear();
}

exec function mlgfixbase()
{
	var player : W3PlayerWitcher = GetWitcherPlayer();
	var inv : CInventoryComponent;
	var items : array<SItemUniqueId>;
	var i, t, healedCount : int;

	if ( !player ) return;
	inv = player.GetInventory();
	if ( !inv ) return;

	inv.GetAllItems(items);
	healedCount = 0;
	for ( i = 0; i < items.Size(); i += 1 )
	{
		if ( inv.isItemScalable(items[i]) )
		{
			t = theGame.GetDefinitionsManager().GetItemLevelFromName(inv.GetItemName(items[i]));
			if ( t > 0 && inv.GetItemModifierInt(items[i], 'MLG_BaseLevel') < t )
			{
				inv.SetItemModifierInt(items[i], 'MLG_BaseLevel', t);
				healedCount += 1;
			}
		}
	}
	theGame.GetGuiManager().ShowNotification("Leveling Gear: Base levels re-synced (" + healedCount + " items healed).", 0, false);
}

function MLG_StripCraftedAbility(inv : CInventoryComponent, item : SItemUniqueId, ab : name)
{
	var abilities : array<name>;
	var guard : int;
	guard = 0;
	while ( guard < 128 )
	{
		abilities.Clear();
		inv.GetItemAbilities(item, abilities);
		if ( !abilities.Contains(ab) ) break;
		inv.RemoveItemCraftedAbility(item, ab);
		guard += 1;
	}
}

function MLG_RevertAllGear()
{
	var player : W3PlayerWitcher = GetWitcherPlayer();
	var inv : CInventoryComponent;
	var items : array<SItemUniqueId>;
	var item : SItemUniqueId;
	var i, n : int;

	var horseMgr : W3HorseManager;
	var stashInv : CInventoryComponent;

	if ( !player ) return;
	inv = player.GetInventory();
	if ( !inv ) return;

	inv.GetAllItems(items);
	n = 0;
	for ( i = 0; i < items.Size(); i += 1 )
	{
		item = items[i];
		if ( inv.GetItemModifierInt(item, 'MLG_BaseLevel') <= 0 && inv.GetItemModifierInt(item, 'MLG_ScaledLevel') <= 0 && inv.GetItemModifierInt(item, 'MLG_CrossbowScaledStacks') <= 0 ) continue;

		MLG_StripCraftedAbility(inv, item, 'autogen_fixed_steel_dmg');
		MLG_StripCraftedAbility(inv, item, 'autogen_fixed_silver_dmg');
		MLG_StripCraftedAbility(inv, item, 'autogen_fixed_armor_armor');
		MLG_StripCraftedAbility(inv, item, 'autogen_fixed_gloves_armor');
		MLG_StripCraftedAbility(inv, item, 'autogen_fixed_pants_armor');
		MLG_StripCraftedAbility(inv, item, 'autogen_fixed_boots_armor');
		MLG_StripCraftedAbility(inv, item, 'Rune elemental _Stats');

		inv.SetItemModifierInt(item, 'MLG_BaseLevel', 0);
		inv.SetItemModifierInt(item, 'MLG_ScaledLevel', 0);
		inv.SetItemModifierInt(item, 'MLG_DownscalePaidLevel', 0);
		inv.SetItemModifierInt(item, 'MLG_CrossbowScaledStacks', 0);
		n += 1;
	}

	horseMgr = player.GetHorseManager();
	if ( horseMgr )
	{
		stashInv = horseMgr.GetInventoryComponent();
		if ( stashInv )
		{
			items.Clear();
			stashInv.GetAllItems(items);
			for ( i = 0; i < items.Size(); i += 1 )
			{
				item = items[i];
				if ( stashInv.GetItemModifierInt(item, 'MLG_BaseLevel') <= 0 && stashInv.GetItemModifierInt(item, 'MLG_ScaledLevel') <= 0 && stashInv.GetItemModifierInt(item, 'MLG_CrossbowScaledStacks') <= 0 ) continue;

				MLG_StripCraftedAbility(stashInv, item, 'autogen_fixed_steel_dmg');
				MLG_StripCraftedAbility(stashInv, item, 'autogen_fixed_silver_dmg');
				MLG_StripCraftedAbility(stashInv, item, 'autogen_fixed_armor_armor');
				MLG_StripCraftedAbility(stashInv, item, 'autogen_fixed_gloves_armor');
				MLG_StripCraftedAbility(stashInv, item, 'autogen_fixed_pants_armor');
				MLG_StripCraftedAbility(stashInv, item, 'autogen_fixed_boots_armor');
				MLG_StripCraftedAbility(stashInv, item, 'Rune elemental _Stats');

				stashInv.SetItemModifierInt(item, 'MLG_BaseLevel', 0);
				stashInv.SetItemModifierInt(item, 'MLG_ScaledLevel', 0);
				stashInv.SetItemModifierInt(item, 'MLG_DownscalePaidLevel', 0);
				stashInv.SetItemModifierInt(item, 'MLG_CrossbowScaledStacks', 0);
				n += 1;
			}
		}
	}

	theGame.GetGuiManager().ShowNotification("Leveling Gear: Reverted " + IntToString(n) + " items to vanilla stats.", 0, false);
}

exec function mlg_revert_all()
{
	MLG_RevertAllGear();
}

exec function mlg_reset_gear()
{
	MLG_RevertAllGear();
}

