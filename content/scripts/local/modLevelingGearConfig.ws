/***********************************************************************/
/** 	Leveling Gear (Update 5.0 Remastered & Next-Gen)
/** 	Configuration reader for in-game Mod Settings menu
/***********************************************************************/

class CModLevelingGearConfig
{
	private var configWrapper : CInGameConfigWrapper;

	private function GetWrapper() : CInGameConfigWrapper
	{
		if ( !configWrapper )
		{
			configWrapper = theGame.GetInGameConfigWrapper();
		}
		return configWrapper;
	}

	public function IsMasterEnabled() : bool
	{
		var wrapper : CInGameConfigWrapper = GetWrapper();
		var val : string;
		if ( wrapper )
		{
			val = wrapper.GetVarValue('modLevelingGear', 'mlgMasterEnabled');
			if ( val == "false" || val == "0" )
			{
				return false;
			}
		}
		return true;
	}

	public function GetGearScope() : int
	{
		var wrapper : CInGameConfigWrapper = GetWrapper();
		var val : string;
		if ( wrapper )
		{
			val = wrapper.GetVarValue('modLevelingGear', 'mlgGearScope');
			if ( StrLen(val) > 0 )
			{
				return StringToInt(val);
			}
		}
		return 0; // 0 = All Gear, 1 = Witcher & Relic, 2 = Witcher School Only
	}

	public function ShouldExcludeAerondight() : bool
	{
		var wrapper : CInGameConfigWrapper = GetWrapper();
		var val : string;
		if ( wrapper )
		{
			val = wrapper.GetVarValue('modLevelingGear', 'mlgExcludeAerondight');
			if ( val == "true" || val == "1" )
			{
				return true;
			}
		}
		return false; // Default: false (Aerondight scales natively unless user explicitly toggles this ON)
	}

	public function ShouldScaleCrossbows() : bool
	{
		var wrapper : CInGameConfigWrapper = GetWrapper();
		var val : string;
		if ( wrapper )
		{
			val = wrapper.GetVarValue('modLevelingGear', 'mlgScaleCrossbows');
			if ( val == "false" || val == "0" )
			{
				return false;
			}
		}
		return true; // Default: true (Crossbows scale alongside melee weapons)
	}

	public function IsTriggerLevelUpEnabled() : bool
	{
		var wrapper : CInGameConfigWrapper = GetWrapper();
		var val : string;
		if ( wrapper )
		{
			val = wrapper.GetVarValue('modLevelingGear', 'mlgTriggerLevelUp');
			if ( val == "false" || val == "0" )
			{
				return false;
			}
		}
		return true;
	}

	public function IsTriggerOnEquipEnabled() : bool
	{
		var wrapper : CInGameConfigWrapper = GetWrapper();
		var val : string;
		if ( wrapper )
		{
			val = wrapper.GetVarValue('modLevelingGear', 'mlgTriggerOnEquip');
			if ( val == "true" || val == "1" )
			{
				return true;
			}
		}
		return false; // Default: false (user requested to decouple auto-scaling on equip into an optional toggle)
	}

	public function IsTriggerCrafterEnabled() : bool
	{
		var wrapper : CInGameConfigWrapper = GetWrapper();
		var val : string;
		if ( wrapper )
		{
			val = wrapper.GetVarValue('modLevelingGear', 'mlgTriggerCrafter');
			if ( val == "false" || val == "0" )
			{
				return false;
			}
		}
		return true;
	}

	public function GetCraftsmanUpgradeMode() : int
	{
		var wrapper : CInGameConfigWrapper = GetWrapper();
		var val : string;
		if ( wrapper )
		{
			val = wrapper.GetVarValue('modLevelingGear', 'mlgCraftsmanMode');
			if ( StrLen(val) > 0 )
			{
				return StringToInt(val);
			}
		}
		return 0; // 0 = Manual (One-by-One in Repair Tab) [Default], 1 = Automatic (All Gear on Dialogue)
	}

	public function GetCraftsmanRepairAction() : int
	{
		var wrapper : CInGameConfigWrapper = GetWrapper();
		var val : string;
		if ( wrapper )
		{
			val = wrapper.GetVarValue('modLevelingGear', 'mlgCraftsmanRepairAction');
			if ( StrLen(val) > 0 )
			{
				return StringToInt(val);
			}
		}
		return 1; // 0 = Vanilla Repair Only, 1 = Repair + Level Tempering [Default], 2 = Temper Only When Pristine
	}

	public function IsTriggerFieldKitEnabled() : bool
	{
		var wrapper : CInGameConfigWrapper = GetWrapper();
		var val : string;
		if ( wrapper )
		{
			val = wrapper.GetVarValue('modLevelingGear', 'mlgTriggerFieldKit');
			if ( val == "false" || val == "0" )
			{
				return false;
			}
		}
		return true;
	}

	public function ShouldAllowFieldKitOnPristine() : bool
	{
		var wrapper : CInGameConfigWrapper = GetWrapper();
		var val : string;
		if ( wrapper )
		{
			val = wrapper.GetVarValue('modLevelingGear', 'mlgAllowFieldKitOnPristine');
			if ( val == "false" || val == "0" )
			{
				return false;
			}
		}
		return true; // Default: true (user requested toggle enabled by default)
	}

	public function ShouldUpgradeInventory() : bool
	{
		var wrapper : CInGameConfigWrapper = GetWrapper();
		var val : string;
		if ( wrapper )
		{
			val = wrapper.GetVarValue('modLevelingGear', 'mlgUpgradeInventory');
			if ( val == "false" || val == "0" )
			{
				return false;
			}
		}
		return true; // Default: true (user requested default on for bagged gear upgrades)
	}

	public function ShouldDownscaleHighLevel() : bool
	{
		var wrapper : CInGameConfigWrapper = GetWrapper();
		var val : string;
		if ( wrapper )
		{
			val = wrapper.GetVarValue('modLevelingGear', 'mlgDownscaleHighLevel');
			if ( val == "true" || val == "1" )
			{
				return true;
			}
			if ( val == "false" || val == "0" )
			{
				return false;
			}
		}
		return false; // Default: false (enables high-level gear to be downscaled to player level when toggled on)
	}

	public function GetDownscaleCostMult() : float
	{
		var wrapper : CInGameConfigWrapper = GetWrapper();
		var val : string;
		if ( wrapper )
		{
			val = wrapper.GetVarValue('modLevelingGear', 'mlgDownscaleCostMult');
			if ( StrLen(val) > 0 )
			{
				return StringToFloat(val);
			}
		}
		return 0.0; // Default: 0.0 (Free downscaling)
	}

	public function ShouldScaleLootDrops() : bool
	{
		var wrapper : CInGameConfigWrapper = GetWrapper();
		var val : string;
		if ( wrapper )
		{
			val = wrapper.GetVarValue('modLevelingGear', 'mlgScaleLootDrops');
			if ( val == "false" || val == "0" )
			{
				return false;
			}
		}
		return true; // Default: true (auto-scales container/corpse loot)
	}

	public function GetPaymentType() : int
	{
		var wrapper : CInGameConfigWrapper = GetWrapper();
		var val : string;
		if ( wrapper )
		{
			val = wrapper.GetVarValue('modLevelingGear', 'mlgPaymentType');
			if ( StrLen(val) > 0 )
			{
				return StringToInt(val);
			}
		}
		return 1; // 0 = Free, 1 = Crowns, 2 = Materials, 3 = Both
	}

	public function GetBaseCrownCost() : int
	{
		var wrapper : CInGameConfigWrapper = GetWrapper();
		var val : string;
		if ( wrapper )
		{
			val = wrapper.GetVarValue('modLevelingGear', 'mlgBaseCrownCost');
			if ( StrLen(val) > 0 )
			{
				return StringToInt(val);
			}
		}
		return 50;
	}

	public function GetRequiredMaterialIndex() : int
	{
		var wrapper : CInGameConfigWrapper = GetWrapper();
		var val : string;
		if ( wrapper )
		{
			val = wrapper.GetVarValue('modLevelingGear', 'mlgRequiredMaterial');
			if ( StrLen(val) > 0 )
			{
				return StringToInt(val);
			}
		}
		return 2; // 0 = Oil, 1 = Repair Kit, 2 = Dimeritium, 3 = Meteorite
	}

	public function GetMultCommon() : float
	{
		var wrapper : CInGameConfigWrapper = GetWrapper();
		var val : string;
		if ( wrapper )
		{
			val = wrapper.GetVarValue('modLevelingGear', 'mlgMultCommon');
			if ( StrLen(val) > 0 )
			{
				return StringToFloat(val);
			}
		}
		return 1.0;
	}

	public function GetMultRelic() : float
	{
		var wrapper : CInGameConfigWrapper = GetWrapper();
		var val : string;
		if ( wrapper )
		{
			val = wrapper.GetVarValue('modLevelingGear', 'mlgMultRelic');
			if ( StrLen(val) > 0 )
			{
				return StringToFloat(val);
			}
		}
		return 2.0;
	}

	public function GetMultWitcher() : float
	{
		var wrapper : CInGameConfigWrapper = GetWrapper();
		var val : string;
		if ( wrapper )
		{
			val = wrapper.GetVarValue('modLevelingGear', 'mlgMultWitcher');
			if ( StrLen(val) > 0 )
			{
				return StringToFloat(val);
			}
		}
		return 3.5;
	}

	public function ShouldNotify() : bool
	{
		var wrapper : CInGameConfigWrapper = GetWrapper();
		var val : string;
		if ( wrapper )
		{
			val = wrapper.GetVarValue('modLevelingGear', 'mlgNotifyOnUpgrade');
			if ( val == "false" || val == "0" )
			{
				return false;
			}
		}
		return true;
	}

	public function ShouldPlaySound() : bool
	{
		var wrapper : CInGameConfigWrapper = GetWrapper();
		var val : string;
		if ( wrapper )
		{
			val = wrapper.GetVarValue('modLevelingGear', 'mlgPlaySoundOnUpgrade');
			if ( val == "false" || val == "0" )
			{
				return false;
			}
		}
		return true;
	}

	public function ShouldNormalizeSecondary() : bool
	{
		var wrapper : CInGameConfigWrapper = GetWrapper();
		var val : string;
		if ( wrapper )
		{
			val = wrapper.GetVarValue('modLevelingGear', 'mlgNormalizeSecondary');
			if ( val == "false" || val == "0" )
			{
				return false;
			}
		}
		return true; // Default: true (Secondary stats downscale on early gear and restore to 100% on level up)
	}
}

@addField(CR4Game)
public var modLevelingGearConfig : CModLevelingGearConfig;

@addMethod(CR4Game)
public function GetOrCreateModLevelingGearConfig() : CModLevelingGearConfig
{
	if ( !modLevelingGearConfig )
	{
		modLevelingGearConfig = new CModLevelingGearConfig in this;
	}
	return modLevelingGearConfig;
}

function GetModLevelingGearConfig() : CModLevelingGearConfig
{
	return theGame.GetOrCreateModLevelingGearConfig();
}
