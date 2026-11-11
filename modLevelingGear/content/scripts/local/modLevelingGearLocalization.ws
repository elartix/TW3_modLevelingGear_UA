/***********************************************************************/
/** 	Leveling Gear (Update 5.0 Remastered & Next-Gen)
/** 	Universal 17-Language Native Script Localization Engine
/***********************************************************************/

function ModLevelingGear_NormalizeKey(key : string) : string
{
	var k : string = key;

	if ( StrBeginsWith(k, "preset_value_mlgInstalledVersion") || StrBeginsWith(k, "option_mlgInstalledVersion") || k == "mlgInstalledVersion_0" || k == "v1.0.23" || k == "v1.0.22" || k == "v1.0.21" || k == "v1.0.20" || k == "v1.0.19" || k == "v1.0.18" || k == "v1.0.17" || k == "v1.0.16" || k == "v1.0.15" || k == "v1.0.14" || k == "v1.0.13" || k == "v1.0.13b" || k == "v1.0.12" || k == "v1.0.11" || k == "v1.0.10b" || k == "v1.0.7b" || k == "v1.0.7" || k == "v1.0.6" || k == "v1.0.5" || k == "v1.0.4" )
	{
		return "v1.0.23";
	}

	while ( StrBeginsWith(k, "#") )
	{
		k = StrMid(k, 1);
	}

	while ( StrBeginsWith(k, "option_") || StrBeginsWith(k, "preset_value_") || StrBeginsWith(k, "panel_") )
	{
		if ( StrBeginsWith(k, "option_") ) k = StrMid(k, 7);
		else if ( StrBeginsWith(k, "preset_value_") ) k = StrMid(k, 13);
		else if ( StrBeginsWith(k, "panel_") ) k = StrMid(k, 6);
	}

	// VarId aliases
	if ( k == "mlgInstalledVersion" ) return "Installed Version";
	if ( k == "preset_value_mlgInstalledVersion" || k == "mlgInstalledVersion_0" ) return "v1.0.23";
	if ( k == "mlgMasterEnabled" ) return "Enable Leveling Gear";
	if ( k == "mlgGearScope" ) return "Gear Whitelist Scope";
	if ( k == "mlgExcludeAerondight" ) return "Exclude Aerondight (Native Stacking)";
	if ( k == "mlgScaleCrossbows" ) return "Enable Crossbow Scaling";
	if ( k == "mlgScaleLootDrops" ) return "Auto-Scale Loot Drops";
	if ( k == "mlgTriggerCrafter" ) return "Upgrade Trigger: At Craftsmen";
	if ( k == "mlgCraftsmanMode" ) return "Craftsman Upgrade Mode";
	if ( k == "mlgCraftsmanRepairAction" || k == "Craftsman Durability Repair Action" ) return "Craftsman Durability Repair Action";
	if ( k == "mlgCraftsmanRepairAction_0" || k == "Durability Repair Only (No Leveling)" ) return "Durability Repair Only (No Leveling)";
	if ( k == "mlgCraftsmanRepairAction_1" || k == "Repair + Level Tempering (Combined)" ) return "Repair + Level Tempering (Combined)";
	if ( k == "mlgCraftsmanRepairAction_2" || k == "Temper Only When Pristine (100% Durability)" ) return "Temper Only When Pristine (100% Durability)";
	if ( k == "mlgUpgradeInventory" ) return "Upgrade Bagged Inventory Gear";
	if ( k == "mlgUpgradeStash" ) return "Upgrade Stash Gear (Player Chest)";
	if ( k == "mlgTriggerStashOpen" ) return "Upgrade Trigger: On Opening Stash Chest";
	if ( k == "mlgGearScope_3" ) return "Relic and Modded Gear Only (Exclude Witcher)";
	if ( k == "mlgTriggerFieldKit" ) return "Upgrade Trigger: Via Field Maintenance Kit";
	if ( k == "mlgAllowFieldKitOnPristine" ) return "Allow Field Kit on Pristine (100%) Gear";
	if ( k == "mlgTriggerLevelUp" ) return "Upgrade Trigger: On Level-Up (Auto)";
	if ( k == "mlgTriggerOnEquip" ) return "Upgrade Trigger: On Item Equip";
	if ( k == "mlgDownscaleHighLevel" ) return "Downscale High-Level Gear to Player Level";
	if ( k == "mlgNormalizeSecondary" ) return "Normalize Secondary Stats (Restore on Level-Up)";
	if ( k == "mlgDownscaleCostMult" ) return "Downscale Cost Multiplier (0.0 = Free)";
	if ( k == "mlgPaymentType" ) return "Payment Currency";
	if ( k == "mlgRequiredMaterial" ) return "Required Material for Upgrades";
	if ( k == "mlgBaseCrownCost" ) return "Base Crown Cost per Level Difference";
	if ( k == "mlgMultCommon" ) return "Cost Multiplier: Common / Magic";
	if ( k == "mlgMultRelic" ) return "Cost Multiplier: Relic / Rare";
	if ( k == "mlgMultWitcher" ) return "Cost Multiplier: Witcher School";
	if ( k == "mlgNotifyOnUpgrade" ) return "Show On-Screen HUD Notification";
	if ( k == "mlgPlaySoundOnUpgrade" ) return "Play Craftsman Anvil Sound Effect";

	// Presets
	if ( k == "Presets" || k == "preset_modLevelingGear" || k == "preset_Mods_LevelingGear" || k == "preset_Mods.LevelingGear" || k == "Preset" ) return "Preset";
	if ( k == "mlgPresetKhser" || k == "preset_value_mlgPresetKhser" || k == "Khser's Choice" ) return "Khser's Choice";
	if ( k == "mlgPresetStory" || k == "preset_value_mlgPresetStory" || k == "Story (Free)" || k == "Story & Action (Free)" ) return "Story (Free)";
	if ( k == "mlgPresetHardcore" || k == "preset_value_mlgPresetHardcore" || k == "Hardcore" || k == "Hardcore Economy" ) return "Hardcore";
	if ( k == "mlgPresetPurist" || k == "preset_value_mlgPresetPurist" || k == "Purist" || k == "Witcher School Purist" ) return "Purist";

	// Menu Titles & Tabs
	if ( k == "Mods.LevelingGear" || k == "mod_leveling_gear" || k == "LevelingGear" || k == "modLevelingGear" || k == "Mods.modLevelingGear" ) return "Leveling Gear";
	if ( k == "mods" || k == "Mods" ) return "Mods";

	return k;
}

function ModLevelingGear_GetLoc_EN(k : string) : string
{
	if ( k == "Preset" ) return "Preset";
	if ( k == "Khser's Choice" ) return "Khser's Choice";
	if ( k == "Story (Free)" ) return "Story (Free)";
	if ( k == "Hardcore" ) return "Hardcore";
	if ( k == "Purist" ) return "Purist";
	if ( k == "Mods" ) return "Mods";
	if ( k == "mods" ) return "Mods";
	if ( k == "Mods.LevelingGear" ) return "Leveling Gear";
	if ( k == "LevelingGear" ) return "Leveling Gear";
	if ( k == "mod_leveling_gear" ) return "Leveling Gear";

	if ( k == "Leveling Gear" ) return "Leveling Gear";
	if ( k == "Installed Version" ) return "Installed Version";
	if ( k == "v1.0.24" || k == "v1.0.23" || k == "v1.0.22" || k == "v1.0.21" || k == "v1.0.20" || k == "v1.0.19" ) return "v1.0.24";
	if ( k == "v1.0.18" ) return "v1.0.18";
	if ( k == "v1.0.17" ) return "v1.0.17";
	if ( k == "v1.0.16" ) return "v1.0.16";
	if ( k == "v1.0.15" ) return "v1.0.15";
	if ( k == "v1.0.14" ) return "v1.0.14";
	if ( k == "v1.0.13" ) return "v1.0.13";
	if ( k == "v1.0.13b" ) return "v1.0.13b";
	if ( k == "v1.0.12" ) return "v1.0.12";
	if ( k == "v1.0.11" ) return "v1.0.11";
	if ( k == "v1.0.5" ) return "v1.0.5";
	if ( k == "v1.0.4" ) return "v1.0.4";
	if ( k == "Enable Leveling Gear" ) return "Enable Leveling Gear";
	if ( k == "Gear Whitelist Scope" ) return "Gear Whitelist Scope";
	if ( k == "Exclude Aerondight (Native Stacking)" ) return "Exclude Aerondight (Native Stacking)";
	if ( k == "Enable Crossbow Scaling" ) return "Enable Crossbow Scaling";
	if ( k == "Auto-Scale Loot Drops" ) return "Auto-Scale Loot Drops";
	if ( k == "Upgrade Trigger: At Craftsmen" ) return "Upgrade Trigger: At Craftsmen";
	if ( k == "Upgrade Trigger: At Craftsmen (Dialogue)" ) return "Upgrade Trigger: At Craftsmen (Dialogue)";
	if ( k == "Craftsman Upgrade Mode" ) return "Craftsman Upgrade Mode";
	if ( k == "Craftsman Durability Repair Action" ) return "Craftsman Durability Repair Action";
	if ( k == "Durability Repair Only (No Leveling)" ) return "Durability Repair Only (No Leveling)";
	if ( k == "Repair + Level Tempering (Combined)" ) return "Repair + Level Tempering (Combined)";
	if ( k == "Temper Only When Pristine (100% Durability)" ) return "Temper Only When Pristine (100% Durability)";
	if ( k == "Upgrade Bagged Inventory Gear" ) return "Upgrade Bagged Inventory Gear";
	if ( k == "Upgrade Trigger: Via Field Maintenance Kit" ) return "Upgrade Trigger: Via Field Maintenance Kit";
	if ( k == "Allow Field Kit on Pristine (100%) Gear" ) return "Allow Field Kit on Pristine (100%) Gear";
	if ( k == "Upgrade Trigger: On Level-Up (Auto)" ) return "Upgrade Trigger: On Level-Up (Auto)";
	if ( k == "Upgrade Trigger: On Item Equip" ) return "Upgrade Trigger: On Item Equip";
	if ( k == "Downscale High-Level Gear to Player Level" ) return "Downscale High-Level Gear to Player Level";
	if ( k == "Downscale Cost Multiplier (0.0 = Free)" ) return "Downscale Cost Multiplier (0.0 = Free)";
	if ( k == "Payment Currency" ) return "Payment Currency";
	if ( k == "Required Material for Upgrades" ) return "Required Material for Upgrades";
	if ( k == "Base Crown Cost per Level Difference" ) return "Base Crown Cost per Level Difference";
	if ( k == "Cost Multiplier: Common / Magic" ) return "Cost Multiplier: Common / Magic";
	if ( k == "Cost Multiplier: Relic / Rare" ) return "Cost Multiplier: Relic / Rare";
	if ( k == "Cost Multiplier: Witcher School" ) return "Cost Multiplier: Witcher School";
	if ( k == "Show On-Screen HUD Notification" ) return "Show On-Screen HUD Notification";
	if ( k == "Play Craftsman Anvil Sound Effect" ) return "Play Craftsman Anvil Sound Effect";
	if ( k == "All Gear (Vanilla and Modded)" ) return "All Gear (Vanilla and Modded)";
	if ( k == "Witcher and Relic Gear Only" ) return "Witcher and Relic Gear Only";
	if ( k == "Witcher School Gear Only" ) return "Witcher School Gear Only";
	if ( k == "Manual (One-by-One in Repair Tab)" ) return "Manual (One-by-One in Repair Tab)";
	if ( k == "Automatic (All Gear on Dialogue)" ) return "Automatic (All Gear on Dialogue)";
	if ( k == "Free (Zero Cost)" ) return "Free (Zero Cost)";
	if ( k == "Crowns Only" ) return "Crowns Only";
	if ( k == "Materials Only" ) return "Materials Only";
	if ( k == "Crowns and Materials" ) return "Crowns and Materials";
	if ( k == "Tempering Oil / Alchemical" ) return "Tempering Oil / Alchemical";
	if ( k == "Weapon / Armor Repair Kit" ) return "Weapon / Armor Repair Kit";
	if ( k == "Dimeritium Ingot" ) return "Dimeritium Ingot";
	if ( k == "Meteorite Ore" ) return "Meteorite Ore";
	if ( k == "Crowns" ) return "Crowns";
	if ( k == "Oil" ) return "Oil";
	if ( k == "Repair Kit" ) return "Repair Kit";
	if ( k == "Material" ) return "Material";
	if ( k == "Leveling Gear" ) return "Leveling Gear";
	if ( k == "Normalize Secondary Stats (Restore on Level-Up)" ) return "Normalize Secondary Stats (Restore on Level-Up)";
	if ( k == "Upgrade Stash Gear (Player Chest)" ) return "Upgrade Stash Gear (Player Chest)";
	if ( k == "Relic and Modded Gear Only (Exclude Witcher)" ) return "Relic and Modded Gear Only (Exclude Witcher)";
	if ( k == "Upgrade Trigger: On Opening Stash Chest" ) return "Upgrade Trigger: On Opening Stash Chest";
	return "";
}

function ModLevelingGear_GetLoc_TR(k : string) : string
{
	if ( k == "Preset" ) return "Hazır Ayar";
	if ( k == "Khser's Choice" ) return "Khser's Choice";
	if ( k == "Story (Free)" ) return "Hikaye (Ucretsiz)";
	if ( k == "Hardcore" ) return "Zorlu";
	if ( k == "Purist" ) return "Sade";
	if ( k == "Installed Version" ) return "Yüklü Sürüm";
	if ( k == "v1.0.12" ) return "v1.0.12";
	if ( k == "v1.0.11" ) return "v1.0.11";
	if ( k == "v1.0.5" ) return "v1.0.5";
	if ( k == "v1.0.4" ) return "v1.0.4";
	if ( k == "Mods" ) return "MODLAR";
	if ( k == "mods" ) return "MODLAR";
	if ( k == "Mods.LevelingGear" ) return "Leveling Gear";
	if ( k == "LevelingGear" ) return "Leveling Gear";
	if ( k == "mod_leveling_gear" ) return "Leveling Gear";
	if ( k == "Enable Leveling Gear" ) return "Leveling Gear Modunu Etkinlestir";
	if ( k == "Gear Whitelist Scope" ) return "Yukseltme Kapsami";
	if ( k == "Exclude Aerondight (Native Stacking)" ) return "Aerondight'i Haric Tut (Dahili Seviye Sistemi)";
	if ( k == "Enable Crossbow Scaling" ) return "Arbalet Olceklendirmesini Etkinlestir";
	if ( k == "Auto-Scale Loot Drops" ) return "Ganimet Ekipmanlarini Otomatik Olceklendir";
	if ( k == "Upgrade Trigger: At Craftsmen" ) return "Guncelleme: Demircilerde";
	if ( k == "Upgrade Trigger: At Craftsmen (Dialogue)" ) return "Guncelleme: Demircilerde (Diyalog)";
	if ( k == "Craftsman Upgrade Mode" ) return "Demirci Guncelleme Modu";
	if ( k == "Craftsman Durability Repair Action" ) return "Demirci Dayaniklik Onarim Eylemi";
	if ( k == "Durability Repair Only (No Leveling)" ) return "Yalnizca Dayaniklik Onarimi (Seviye Artisi Yok)";
	if ( k == "Repair + Level Tempering (Combined)" ) return "Onarim + Seviye Gelistirme (Birlikte)";
	if ( k == "Temper Only When Pristine (100% Durability)" ) return "Yalnizca Kusursuzken (%100 Dayaniklik) Gelistir";
	if ( k == "Upgrade Bagged Inventory Gear" ) return "Envanterdeki Ekipmanlari da Guncelle";
	if ( k == "Upgrade Trigger: Via Field Maintenance Kit" ) return "Guncelleme: Saha Bakim Kiti ile";
	if ( k == "Allow Field Kit on Pristine (100%) Gear" ) return "Kusursuz (%100) Ekipmanda Saha Kiti Kullanimi";
	if ( k == "Upgrade Trigger: On Level-Up (Auto)" ) return "Guncelleme: Seviye Atlayinca (Otomatik)";
	if ( k == "Upgrade Trigger: On Item Equip" ) return "Guncelleme: Ekipman Kusaninca";
	if ( k == "Downscale High-Level Gear to Player Level" ) return "Yuksek Seviyeli Ekipmanlari Seviyeme Dusur";
	if ( k == "Downscale Cost Multiplier (0.0 = Free)" ) return "Seviye Dusurme Maliyet Carpani (0.0 = Ucretsiz)";
	if ( k == "Payment Currency" ) return "Odeme Turu";
	if ( k == "Required Material for Upgrades" ) return "Yukseltme Icin Gerekli Malzeme";
	if ( k == "Base Crown Cost per Level Difference" ) return "Seviye Farki Basina Temel Kron";
	if ( k == "Cost Multiplier: Common / Magic" ) return "Maliyet Carpani: Siradan / Buyulu";
	if ( k == "Cost Multiplier: Relic / Rare" ) return "Maliyet Carpani: Yadigar / Nadir";
	if ( k == "Cost Multiplier: Witcher School" ) return "Maliyet Carpani: Witcher Okulu";
	if ( k == "Show On-Screen HUD Notification" ) return "Ekranda HUD Bildirimi Goster";
	if ( k == "Play Craftsman Anvil Sound Effect" ) return "Demirci Ors Sesi Efektini Cal";
	if ( k == "All Gear (Vanilla and Modded)" ) return "Tum Ekipmanlar (Orijinal ve Modlu)";
	if ( k == "Witcher and Relic Gear Only" ) return "Sadece Witcher ve Yadigar Ekipmanlar";
	if ( k == "Witcher School Gear Only" ) return "Sadece Witcher Okulu Ekipmanlari";
	if ( k == "Manual (One-by-One in Repair Tab)" ) return "Manuel (Onarim Menusunde Teker Teker)";
	if ( k == "Automatic (All Gear on Dialogue)" ) return "Otomatik (Diyalogda Tum Ekipman)";
	if ( k == "Free (Zero Cost)" ) return "Ucretsiz (Sifir Maliyet)";
	if ( k == "Crowns Only" ) return "Sadece Kron";
	if ( k == "Materials Only" ) return "Sadece Malzeme";
	if ( k == "Crowns and Materials" ) return "Kron ve Malzeme";
	if ( k == "Tempering Oil / Alchemical" ) return "Temper Yagi / Simya";
	if ( k == "Weapon / Armor Repair Kit" ) return "Silah / Zirh Tamir Kiti";
	if ( k == "Dimeritium Ingot" ) return "Dimerityum Kulcesi";
	if ( k == "Meteorite Ore" ) return "Goktasi Cevheri";
	if ( k == "Crowns" ) return "Kron";
	if ( k == "Oil" ) return "Yag";
	if ( k == "Repair Kit" ) return "Tamir Kiti";
	if ( k == "Material" ) return "Malzeme";
	if ( k == "Normalize Secondary Stats (Restore on Level-Up)" ) return "Ikincil Nitelikleri Dengele (Seviye Atlayinca Geri Yukle)";
	if ( k == "Upgrade Stash Gear (Player Chest)" ) return "Sandık Ekipmanlarını Yükselt (Oyuncu Sandığı)";
	if ( k == "Relic and Modded Gear Only (Exclude Witcher)" ) return "Yalnızca Relik ve Mod Eşyaları (Efsunlu Hariç)";
	if ( k == "Upgrade Trigger: On Opening Stash Chest" ) return "Yükseltme Tetikleyici: Sandık Açıldığında";
	return "";
}

function ModLevelingGear_GetLoc_RU(k : string) : string
{
	if ( k == "Preset" ) return "Предустановка";
	if ( k == "Khser's Choice" ) return "Выбор Khser";
	if ( k == "Story (Free)" ) return "Сюжет (бесплатно)";
	if ( k == "Hardcore" ) return "Хардкор";
	if ( k == "Purist" ) return "Пурист";

	if ( k == "mlgPresetKhser" ) return "Выбор Khser";

	if ( k == "mlgPresetStory" ) return "Сюжет (бесплатно)";

	if ( k == "mlgPresetHardcore" ) return "Хардкор";

	if ( k == "mlgPresetPurist" ) return "Пурист";
	if ( k == "Installed Version" ) return "Установленная версия";
	if ( k == "v1.0.23" ) return "v1.0.23";
	if ( k == "v1.0.22" ) return "v1.0.22";
	if ( k == "v1.0.21" ) return "v1.0.21";
	if ( k == "v1.0.20" ) return "v1.0.20";
	if ( k == "v1.0.12" ) return "v1.0.12";
	if ( k == "v1.0.11" ) return "v1.0.11";
	if ( k == "v1.0.4" ) return "v1.0.4";
	if ( k == "Mods" ) return "Моды";
	if ( k == "mods" ) return "Моды";
	if ( k == "Mods.LevelingGear" ) return "Leveling Gear";
	if ( k == "LevelingGear" ) return "Leveling Gear";
	if ( k == "mod_leveling_gear" ) return "Leveling Gear";
	if ( k == "Enable Leveling Gear" ) return "Включить Leveling Gear";
	if ( k == "Gear Whitelist Scope" ) return "Область улучшения снаряжения";
	if ( k == "Exclude Aerondight (Native Stacking)" ) return "Исключить Арондит (родная прокачка)";
	if ( k == "Enable Crossbow Scaling" ) return "Включить масштабирование арбалетов";
	if ( k == "Auto-Scale Loot Drops" ) return "Авто-масштабирование добычи";
	if ( k == "Upgrade Trigger: At Craftsmen" ) return "Улучшение: у ремесленников";
	if ( k == "Upgrade Trigger: At Craftsmen (Dialogue)" ) return "Улучшение: у ремесленников (диалог)";
	if ( k == "Craftsman Upgrade Mode" ) return "Режим улучшения у ремесленников";
	if ( k == "Craftsman Durability Repair Action" ) return "Действие ремонта у ремесленника";
	if ( k == "Durability Repair Only (No Leveling)" ) return "Только ремонт прочности (без повышения уровня)";
	if ( k == "Repair + Level Tempering (Combined)" ) return "Ремонт + закалка уровня (совместно)";
	if ( k == "Temper Only When Pristine (100% Durability)" ) return "Закалка только при 100% прочности";
	if ( k == "Upgrade Bagged Inventory Gear" ) return "Улучшать снаряжение в инвентаре";
	if ( k == "Upgrade Trigger: Via Field Maintenance Kit" ) return "Улучшение: походными наборами";
	if ( k == "Allow Field Kit on Pristine (100%) Gear" ) return "Наборы для целого (100%) снаряжения";
	if ( k == "Upgrade Trigger: On Level-Up (Auto)" ) return "Улучшение: при повышении уровня";
	if ( k == "Upgrade Trigger: On Item Equip" ) return "Улучшение: при экипировке";
	if ( k == "Downscale High-Level Gear to Player Level" ) return "Понижать высокоуровневые предметы";
	if ( k == "Downscale Cost Multiplier (0.0 = Free)" ) return "Множитель цены понижения (0.0 = бесплатно)";
	if ( k == "Payment Currency" ) return "Валюта оплаты";
	if ( k == "Required Material for Upgrades" ) return "Материал для улучшения";
	if ( k == "Base Crown Cost per Level Difference" ) return "Базовая цена за уровень (в кронах)";
	if ( k == "Cost Multiplier: Common / Magic" ) return "Множитель цены: обычное / магическое";
	if ( k == "Cost Multiplier: Relic / Rare" ) return "Множитель цены: реликтовое / редкое";
	if ( k == "Cost Multiplier: Witcher School" ) return "Множитель цены: ведьмачье снаряжение";
	if ( k == "Show On-Screen HUD Notification" ) return "Показывать уведомления на экране";
	if ( k == "Play Craftsman Anvil Sound Effect" ) return "Звуковой эффект наковальни";
	if ( k == "All Gear (Vanilla and Modded)" ) return "Все снаряжение (оригинал и моды)";
	if ( k == "Witcher and Relic Gear Only" ) return "Только ведьмачье и реликтовое";
	if ( k == "Witcher School Gear Only" ) return "Только ведьмачьих школ";
	if ( k == "Manual (One-by-One in Repair Tab)" ) return "Вручную (поштучно во вкладке починки)";
	if ( k == "Automatic (All Gear on Dialogue)" ) return "Автоматически (все при диалоге)";
	if ( k == "Free (Zero Cost)" ) return "Бесплатно (без затрат)";
	if ( k == "Crowns Only" ) return "Только кроны";
	if ( k == "Materials Only" ) return "Только материалы";
	if ( k == "Crowns and Materials" ) return "Кроны и материалы";
	if ( k == "Tempering Oil / Alchemical" ) return "Масло / алхимический спирт";
	if ( k == "Weapon / Armor Repair Kit" ) return "Оружейный / броневой набор";
	if ( k == "Dimeritium Ingot" ) return "Двимеритовый слиток";
	if ( k == "Meteorite Ore" ) return "Метеоритная руда";
	if ( k == "Crowns" ) return "Кроны";
	if ( k == "Oil" ) return "Масло";
	if ( k == "Repair Kit" ) return "Ремонтный набор";
	if ( k == "Material" ) return "Материал";
	if ( k == "Normalize Secondary Stats (Restore on Level-Up)" ) return "Нормализация вторичных характеристик (восстановление при уровне)";
	if ( k == "Upgrade Stash Gear (Player Chest)" ) return "Улучшать снаряжение в сундуке (Тайник)";
	if ( k == "Relic and Modded Gear Only (Exclude Witcher)" ) return "Только реликтовое и моды (без ведьмачьего)";
	if ( k == "Upgrade Trigger: On Opening Stash Chest" ) return "Улучшение: при открытии сундука";
	return "";
}

function ModLevelingGear_GetLoc_PL(k : string) : string
{
	if ( k == "Preset" ) return "Ustawienie";
	if ( k == "Khser's Choice" ) return "Wybór Khsera";
	if ( k == "Story (Free)" ) return "Fabuła (darmowa)";
	if ( k == "Hardcore" ) return "Hardkor";
	if ( k == "Purist" ) return "Puryzm";
	if ( k == "Zainstalowana wersja" ) return "Zainstalowana wersja";
	if ( k == "Installed Version" ) return "Zainstalowana wersja";
	if ( k == "v1.0.12" ) return "v1.0.12";
	if ( k == "v1.0.11" ) return "v1.0.11";
	if ( k == "v1.0.4" ) return "v1.0.4";
	if ( k == "Mods" ) return "MODY";
	if ( k == "mods" ) return "MODY";
	if ( k == "Mods.LevelingGear" ) return "Leveling Gear";
	if ( k == "LevelingGear" ) return "Leveling Gear";
	if ( k == "mod_leveling_gear" ) return "Leveling Gear";
	if ( k == "Enable Leveling Gear" ) return "Włącz Leveling Gear";
	if ( k == "Gear Whitelist Scope" ) return "Zakres ulepszanego ekwipunku";
	if ( k == "Exclude Aerondight (Native Stacking)" ) return "Wyklucz Aerondight (własne skalowanie)";
	if ( k == "Enable Crossbow Scaling" ) return "Włącz skalowanie kusz";
	if ( k == "Auto-Scale Loot Drops" ) return "Automatyczne skalowanie łupów";
	if ( k == "Upgrade Trigger: At Craftsmen" ) return "Ulepszanie: u rzemieślników";
	if ( k == "Upgrade Trigger: At Craftsmen (Dialogue)" ) return "Ulepszanie: u rzemieślników (dialog)";
	if ( k == "Craftsman Upgrade Mode" ) return "Tryb ulepszania u rzemieślnika";
	if ( k == "Craftsman Durability Repair Action" ) return "Działanie naprawy u rzemieślnika";
	if ( k == "Durability Repair Only (No Leveling)" ) return "Tylko naprawa trwałości (bez poziomowania)";
	if ( k == "Repair + Level Tempering (Combined)" ) return "Naprawa + hartowanie poziomu (połączone)";
	if ( k == "Temper Only When Pristine (100% Durability)" ) return "Hartowanie tylko przy 100% trwałości";
	if ( k == "Upgrade Bagged Inventory Gear" ) return "Ulepszaj także przedmioty w ekwipunku";
	if ( k == "Upgrade Trigger: Via Field Maintenance Kit" ) return "Ulepszanie: zestawami naprawczymi";
	if ( k == "Allow Field Kit on Pristine (100%) Gear" ) return "Zezwalaj na zestawy przy 100% stanie";
	if ( k == "Upgrade Trigger: On Level-Up (Auto)" ) return "Ulepszanie: po awansie na poziom";
	if ( k == "Upgrade Trigger: On Item Equip" ) return "Ulepszanie: przy założeniu przedmiotu";
	if ( k == "Downscale High-Level Gear to Player Level" ) return "Obniżaj poziom zbyt wysokiego sprzętu";
	if ( k == "Downscale Cost Multiplier (0.0 = Free)" ) return "Mnożnik kosztu obniżenia (0.0 = darmowe)";
	if ( k == "Payment Currency" ) return "Waluta zapłaty";
	if ( k == "Required Material for Upgrades" ) return "Wymagany materiał do ulepszenia";
	if ( k == "Base Crown Cost per Level Difference" ) return "Bazowy koszt w koronach za poziom";
	if ( k == "Cost Multiplier: Common / Magic" ) return "Mnożnik kosztu: Pospolite / Magiczne";
	if ( k == "Cost Multiplier: Relic / Rare" ) return "Mnożnik kosztu: Reliktowe / Rzadkie";
	if ( k == "Cost Multiplier: Witcher School" ) return "Mnożnik kosztu: Wiedźmiński cech";
	if ( k == "Show On-Screen HUD Notification" ) return "Pokazuj powiadomienia na ekranie";
	if ( k == "Play Craftsman Anvil Sound Effect" ) return "Dźwięk kowadła podczas ulepszania";
	if ( k == "All Gear (Vanilla and Modded)" ) return "Cały sprzęt (oryginalny i z modów)";
	if ( k == "Witcher and Relic Gear Only" ) return "Tylko wiedźmiński i reliktowy";
	if ( k == "Witcher School Gear Only" ) return "Tylko sprzęt cechowy";
	if ( k == "Manual (One-by-One in Repair Tab)" ) return "Ręcznie (pojedynczo w naprawie)";
	if ( k == "Automatic (All Gear on Dialogue)" ) return "Automatycznie (wszystko w dialogu)";
	if ( k == "Free (Zero Cost)" ) return "Darmowe (bez kosztów)";
	if ( k == "Crowns Only" ) return "Tylko korony";
	if ( k == "Materials Only" ) return "Tylko materiały";
	if ( k == "Crowns and Materials" ) return "Korony i materiały";
	if ( k == "Tempering Oil / Alchemical" ) return "Olej hartowniczy / alkohol alchemiczny";
	if ( k == "Weapon / Armor Repair Kit" ) return "Zestaw naprawczy broni / pancerza";
	if ( k == "Dimeritium Ingot" ) return "Sztaba dwimerytu";
	if ( k == "Meteorite Ore" ) return "Ruda meteorytu";
	if ( k == "Crowns" ) return "Korony";
	if ( k == "Oil" ) return "Olej";
	if ( k == "Repair Kit" ) return "Zestaw naprawczy";
	if ( k == "Material" ) return "Materiał";
	if ( k == "Normalize Secondary Stats (Restore on Level-Up)" ) return "Normalizacja statystyk dodatkowych (przywracanie z poziomem)";
	if ( k == "Upgrade Stash Gear (Player Chest)" ) return "Ulepszaj przedmioty w skrytce (Skrzynia gracza)";
	if ( k == "Relic and Modded Gear Only (Exclude Witcher)" ) return "Tylko przedmioty reliktowe i z modów (bez wiedźmińskich)";
	if ( k == "Upgrade Trigger: On Opening Stash Chest" ) return "Ulepszanie: przy otwarciu skrytki";
	return "";
}

function ModLevelingGear_GetLoc_DE(k : string) : string
{
	if ( k == "Preset" ) return "Voreinstellung";
	if ( k == "Khser's Choice" ) return "Khsers Wahl";
	if ( k == "Story (Free)" ) return "Story (gratis)";
	if ( k == "Hardcore" ) return "Hardcore";
	if ( k == "Purist" ) return "Purist";
	if ( k == "Installierte Version" ) return "Installierte Version";
	if ( k == "Installed Version" ) return "Installierte Version";
	if ( k == "v1.0.12" ) return "v1.0.12";
	if ( k == "v1.0.11" ) return "v1.0.11";
	if ( k == "v1.0.4" ) return "v1.0.4";
	if ( k == "Mods" ) return "MODS";
	if ( k == "mods" ) return "MODS";
	if ( k == "Mods.LevelingGear" ) return "Leveling Gear";
	if ( k == "LevelingGear" ) return "Leveling Gear";
	if ( k == "mod_leveling_gear" ) return "Leveling Gear";
	if ( k == "Enable Leveling Gear" ) return "Leveling Gear aktivieren";
	if ( k == "Gear Whitelist Scope" ) return "Ausrüstungs-Filter";
	if ( k == "Exclude Aerondight (Native Stacking)" ) return "Aerondight ausschließen (eigenes Leveln)";
	if ( k == "Enable Crossbow Scaling" ) return "Armbrust-Skalierung aktivieren";
	if ( k == "Auto-Scale Loot Drops" ) return "Beute-Skalierung aktivieren";
	if ( k == "Upgrade Trigger: At Craftsmen" ) return "Upgrade: Bei Handwerkern";
	if ( k == "Upgrade Trigger: At Craftsmen (Dialogue)" ) return "Upgrade: Bei Handwerkern (Dialog)";
	if ( k == "Craftsman Upgrade Mode" ) return "Handwerker-Upgrademodus";
	if ( k == "Craftsman Durability Repair Action" ) return "Handwerker-Reparaturaktion";
	if ( k == "Durability Repair Only (No Leveling)" ) return "Nur Haltbarkeit reparieren (keine Skalierung)";
	if ( k == "Repair + Level Tempering (Combined)" ) return "Reparatur + Stufenhärtung (kombiniert)";
	if ( k == "Temper Only When Pristine (100% Durability)" ) return "Nur bei 100% Haltbarkeit härten";
	if ( k == "Upgrade Bagged Inventory Gear" ) return "Auch Inventar-Ausrüstung aufwerten";
	if ( k == "Upgrade Trigger: Via Field Maintenance Kit" ) return "Upgrade: Mit Reparatursets";
	if ( k == "Allow Field Kit on Pristine (100%) Gear" ) return "Reparatursets bei 100% Haltbarkeit erlauben";
	if ( k == "Upgrade Trigger: On Level-Up (Auto)" ) return "Upgrade: Bei Stufenaufstieg (Auto)";
	if ( k == "Upgrade Trigger: On Item Equip" ) return "Upgrade: Beim Ausrüsten";
	if ( k == "Downscale High-Level Gear to Player Level" ) return "Zu hohe Ausrüstung herabstufen";
	if ( k == "Downscale Cost Multiplier (0.0 = Free)" ) return "Kostenmultiplikator für Herabstufung (0.0 = Gratis)";
	if ( k == "Payment Currency" ) return "Zahlungsart";
	if ( k == "Required Material for Upgrades" ) return "Benötigtes Material";
	if ( k == "Base Crown Cost per Level Difference" ) return "Basis-Kronen pro Stufenunterschied";
	if ( k == "Cost Multiplier: Common / Magic" ) return "Kostenmultiplikator: Gewöhnlich / Magisch";
	if ( k == "Cost Multiplier: Relic / Rare" ) return "Kostenmultiplikator: Relikt / Selten";
	if ( k == "Cost Multiplier: Witcher School" ) return "Kostenmultiplikator: Hexerausrüstung";
	if ( k == "Show On-Screen HUD Notification" ) return "HUD-Benachrichtigung anzeigen";
	if ( k == "Play Craftsman Anvil Sound Effect" ) return "Amboss-Soundeffekt abspielen";
	if ( k == "All Gear (Vanilla and Modded)" ) return "Alle Ausrüstung (Original & Mods)";
	if ( k == "Witcher and Relic Gear Only" ) return "Nur Hexer- & Reliktausrüstung";
	if ( k == "Witcher School Gear Only" ) return "Nur Hexerschulen-Ausrüstung";
	if ( k == "Manual (One-by-One in Repair Tab)" ) return "Manuell (Einzeln im Reparatur-Menü)";
	if ( k == "Automatic (All Gear on Dialogue)" ) return "Automatisch (Alles im Dialog)";
	if ( k == "Free (Zero Cost)" ) return "Kostenlos (0 Kronen)";
	if ( k == "Crowns Only" ) return "Nur Kronen";
	if ( k == "Materials Only" ) return "Nur Materialien";
	if ( k == "Crowns and Materials" ) return "Kronen und Materialien";
	if ( k == "Tempering Oil / Alchemical" ) return "Härteöl / Alchemie";
	if ( k == "Weapon / Armor Repair Kit" ) return "Waffen- / Rüstungsreparaturset";
	if ( k == "Dimeritium Ingot" ) return "Dimeritiumbarren";
	if ( k == "Meteorite Ore" ) return "Meteoriterz";
	if ( k == "Crowns" ) return "Kronen";
	if ( k == "Oil" ) return "Öl";
	if ( k == "Repair Kit" ) return "Reparaturset";
	if ( k == "Material" ) return "Material";
	if ( k == "Normalize Secondary Stats (Restore on Level-Up)" ) return "Sekundärwerte normalisieren (bei Stufenaufstieg wiederherstellen)";
	if ( k == "Upgrade Stash Gear (Player Chest)" ) return "Ausrüstung in der Spielertruhe verbessern";
	if ( k == "Relic and Modded Gear Only (Exclude Witcher)" ) return "Nur Relikt- und Mod-Ausrüstung (ohne Hexer)";
	if ( k == "Upgrade Trigger: On Opening Stash Chest" ) return "Verbesserung: Beim Öffnen der Spielertruhe";
	return "";
}

function ModLevelingGear_GetLoc_FR(k : string) : string
{
	if ( k == "Installed Version" ) return "Version installée";
	if ( k == "v1.0.4" ) return "v1.0.4";
	if ( k == "Mods" ) return "MODS";
	if ( k == "mods" ) return "MODS";
	if ( k == "Mods.LevelingGear" ) return "Leveling Gear";
	if ( k == "LevelingGear" ) return "Leveling Gear";
	if ( k == "mod_leveling_gear" ) return "Leveling Gear";
	if ( k == "Enable Leveling Gear" ) return "Activer Leveling Gear";
	if ( k == "Gear Whitelist Scope" ) return "Étendue de l'équipement";
	if ( k == "Exclude Aerondight (Native Stacking)" ) return "Exclure Aerondight (progression native)";
	if ( k == "Enable Crossbow Scaling" ) return "Activer la mise à niveau des arbalètes";
	if ( k == "Auto-Scale Loot Drops" ) return "Ajuster automatiquement le butin";
	if ( k == "Upgrade Trigger: At Craftsmen" ) return "Amélioration : Chez les artisans";
	if ( k == "Upgrade Trigger: At Craftsmen (Dialogue)" ) return "Amélioration : Chez les artisans (dialogue)";
	if ( k == "Craftsman Upgrade Mode" ) return "Mode d'amélioration artisanale";
	if ( k == "Upgrade Bagged Inventory Gear" ) return "Améliorer aussi l'inventaire";
	if ( k == "Upgrade Trigger: Via Field Maintenance Kit" ) return "Amélioration : Kits d'entretien";
	if ( k == "Allow Field Kit on Pristine (100%) Gear" ) return "Autoriser les kits sur équipement intact (100%)";
	if ( k == "Upgrade Trigger: On Level-Up (Auto)" ) return "Amélioration : Montée de niveau (auto)";
	if ( k == "Upgrade Trigger: On Item Equip" ) return "Amélioration : Lors de l'équipement";
	if ( k == "Downscale High-Level Gear to Player Level" ) return "Réduire l'équipement de haut niveau";
	if ( k == "Downscale Cost Multiplier (0.0 = Free)" ) return "Multiplicateur de réduction (0.0 = gratuit)";
	if ( k == "Payment Currency" ) return "Devise de paiement";
	if ( k == "Required Material for Upgrades" ) return "Matériau requis";
	if ( k == "Base Crown Cost per Level Difference" ) return "Coût de base en orins par niveau";
	if ( k == "Cost Multiplier: Common / Magic" ) return "Multiplicateur : Commun / Magique";
	if ( k == "Cost Multiplier: Relic / Rare" ) return "Multiplicateur : Relique / Rare";
	if ( k == "Cost Multiplier: Witcher School" ) return "Multiplicateur : École de sorceleur";
	if ( k == "Show On-Screen HUD Notification" ) return "Afficher les notifications sur le HUD";
	if ( k == "Play Craftsman Anvil Sound Effect" ) return "Jouer le son de l'enclume";
	if ( k == "All Gear (Vanilla and Modded)" ) return "Tout l'équipement (jeu & mods)";
	if ( k == "Witcher and Relic Gear Only" ) return "Équipement de sorceleur et reliques";
	if ( k == "Witcher School Gear Only" ) return "Équipement des écoles de sorceleur";
	if ( k == "Manual (One-by-One in Repair Tab)" ) return "Manuel (Un par un dans l'onglet réparation)";
	if ( k == "Automatic (All Gear on Dialogue)" ) return "Automatique (Tout lors du dialogue)";
	if ( k == "Free (Zero Cost)" ) return "Gratuit (aucun coût)";
	if ( k == "Crowns Only" ) return "Orins uniquement";
	if ( k == "Materials Only" ) return "Matériaux uniquement";
	if ( k == "Crowns and Materials" ) return "Orins et matériaux";
	if ( k == "Tempering Oil / Alchemical" ) return "Huile de trempe / Alchimie";
	if ( k == "Weapon / Armor Repair Kit" ) return "Nécessaire d'armurier / de forgeron";
	if ( k == "Dimeritium Ingot" ) return "Lingot de diméritium";
	if ( k == "Meteorite Ore" ) return "Minerai de météorite";
	if ( k == "Crowns" ) return "Orins";
	if ( k == "Oil" ) return "Huile";
	if ( k == "Repair Kit" ) return "Nécessaire de réparation";
	if ( k == "Material" ) return "Matériau";
	if ( k == "Normalize Secondary Stats (Restore on Level-Up)" ) return "Normaliser les stats secondaires (restaurer lors de la montée de niveau)";
	if ( k == "Upgrade Stash Gear (Player Chest)" ) return "Améliorer l'équipement du coffre (Réserve)";
	if ( k == "Relic and Modded Gear Only (Exclude Witcher)" ) return "Uniquement reliques et mods (hors sorceleur)";
	if ( k == "Upgrade Trigger: On Opening Stash Chest" ) return "Amélioration : à l'ouverture du coffre";
	return "";
}

function ModLevelingGear_GetLoc_ES(k : string) : string
{
	if ( k == "Installed Version" ) return "Versión instalada";
	if ( k == "v1.0.4" ) return "v1.0.4";
	if ( k == "Mods" ) return "MODS";
	if ( k == "mods" ) return "MODS";
	if ( k == "Mods.LevelingGear" ) return "Leveling Gear";
	if ( k == "LevelingGear" ) return "Leveling Gear";
	if ( k == "mod_leveling_gear" ) return "Leveling Gear";
	if ( k == "Enable Leveling Gear" ) return "Activar Leveling Gear";
	if ( k == "Gear Whitelist Scope" ) return "Alcance de equipo";
	if ( k == "Exclude Aerondight (Native Stacking)" ) return "Excluir Aerondight (progresión nativa)";
	if ( k == "Enable Crossbow Scaling" ) return "Habilitar escalado de ballestas";
	if ( k == "Auto-Scale Loot Drops" ) return "Ajustar botín automáticamente";
	if ( k == "Upgrade Trigger: At Craftsmen" ) return "Mejora: En artesanos";
	if ( k == "Upgrade Trigger: At Craftsmen (Dialogue)" ) return "Mejora: En artesanos (diálogo)";
	if ( k == "Craftsman Upgrade Mode" ) return "Modo de mejora con artesanos";
	if ( k == "Upgrade Bagged Inventory Gear" ) return "Mejorar equipo del inventario";
	if ( k == "Upgrade Trigger: Via Field Maintenance Kit" ) return "Mejora: Con kits de mantenimiento";
	if ( k == "Allow Field Kit on Pristine (100%) Gear" ) return "Permitir kits en equipo al 100%";
	if ( k == "Upgrade Trigger: On Level-Up (Auto)" ) return "Mejora: Al subir de nivel (auto)";
	if ( k == "Upgrade Trigger: On Item Equip" ) return "Mejora: Al equipar objeto";
	if ( k == "Downscale High-Level Gear to Player Level" ) return "Reducir nivel de equipo superior";
	if ( k == "Downscale Cost Multiplier (0.0 = Free)" ) return "Multiplicador de coste de reducción (0.0 = gratis)";
	if ( k == "Payment Currency" ) return "Moneda de pago";
	if ( k == "Required Material for Upgrades" ) return "Material requerido";
	if ( k == "Base Crown Cost per Level Difference" ) return "Coste base en coronas por nivel";
	if ( k == "Cost Multiplier: Common / Magic" ) return "Multiplicador: Común / Mágico";
	if ( k == "Cost Multiplier: Relic / Rare" ) return "Multiplicador: Reliquia / Raro";
	if ( k == "Cost Multiplier: Witcher School" ) return "Multiplicador: Escuela de brujo";
	if ( k == "Show On-Screen HUD Notification" ) return "Mostrar notificación en pantalla (HUD)";
	if ( k == "Play Craftsman Anvil Sound Effect" ) return "Efecto de sonido de yunque";
	if ( k == "All Gear (Vanilla and Modded)" ) return "Todo el equipo (original y mods)";
	if ( k == "Witcher and Relic Gear Only" ) return "Solo equipo de brujo y reliquias";
	if ( k == "Witcher School Gear Only" ) return "Solo equipo de escuelas de brujo";
	if ( k == "Manual (One-by-One in Repair Tab)" ) return "Manual (Uno a uno en pestaña de reparación)";
	if ( k == "Automatic (All Gear on Dialogue)" ) return "Automático (Todo al hablar)";
	if ( k == "Free (Zero Cost)" ) return "Gratis (sin coste)";
	if ( k == "Crowns Only" ) return "Solo coronas";
	if ( k == "Materials Only" ) return "Solo materiales";
	if ( k == "Crowns and Materials" ) return "Coronas y materiales";
	if ( k == "Tempering Oil / Alchemical" ) return "Aceite de templado / Alquimia";
	if ( k == "Weapon / Armor Repair Kit" ) return "Kit de reparación de armas / armaduras";
	if ( k == "Dimeritium Ingot" ) return "Lingote de dimerita";
	if ( k == "Meteorite Ore" ) return "Mineral de meteorito";
	if ( k == "Crowns" ) return "Coronas";
	if ( k == "Oil" ) return "Aceite";
	if ( k == "Repair Kit" ) return "Kit de reparación";
	if ( k == "Material" ) return "Material";
	if ( k == "Normalize Secondary Stats (Restore on Level-Up)" ) return "Normalizar atributos secundarios (restaurar al subir de nivel)";
	if ( k == "Upgrade Stash Gear (Player Chest)" ) return "Mejorar equipo del alijo (Cofre del jugador)";
	if ( k == "Relic and Modded Gear Only (Exclude Witcher)" ) return "Solo reliquias y mods (sin equipo de brujo)";
	if ( k == "Upgrade Trigger: On Opening Stash Chest" ) return "Mejora: al abrir el alijo";
	return "";
}

function ModLevelingGear_GetLoc_ESMX(k : string) : string
{
	if ( k == "Installed Version" ) return "Versión instalada";
	if ( k == "v1.0.4" ) return "v1.0.4";
	if ( k == "Mods" ) return "MODS";
	if ( k == "mods" ) return "MODS";
	if ( k == "Mods.LevelingGear" ) return "Leveling Gear";
	if ( k == "LevelingGear" ) return "Leveling Gear";
	if ( k == "mod_leveling_gear" ) return "Leveling Gear";
	if ( k == "Enable Leveling Gear" ) return "Activar Leveling Gear";
	if ( k == "Gear Whitelist Scope" ) return "Alcance de equipo";
	if ( k == "Exclude Aerondight (Native Stacking)" ) return "Excluir Aerondight (progresión nativa)";
	if ( k == "Enable Crossbow Scaling" ) return "Habilitar escalado de ballestas";
	if ( k == "Auto-Scale Loot Drops" ) return "Ajustar botín automáticamente";
	if ( k == "Upgrade Trigger: At Craftsmen" ) return "Mejora: En artesanos";
	if ( k == "Upgrade Trigger: At Craftsmen (Dialogue)" ) return "Mejora: En artesanos (diálogo)";
	if ( k == "Craftsman Upgrade Mode" ) return "Modo de mejora con artesanos";
	if ( k == "Upgrade Bagged Inventory Gear" ) return "Mejorar equipo del inventario";
	if ( k == "Upgrade Trigger: Via Field Maintenance Kit" ) return "Mejora: Con kits de mantenimiento";
	if ( k == "Allow Field Kit on Pristine (100%) Gear" ) return "Permitir kits en equipo al 100%";
	if ( k == "Upgrade Trigger: On Level-Up (Auto)" ) return "Mejora: Al subir de nivel (auto)";
	if ( k == "Upgrade Trigger: On Item Equip" ) return "Mejora: Al equipar objeto";
	if ( k == "Downscale High-Level Gear to Player Level" ) return "Reducir nivel de equipo superior";
	if ( k == "Downscale Cost Multiplier (0.0 = Free)" ) return "Multiplicador de costo de reducción (0.0 = gratis)";
	if ( k == "Payment Currency" ) return "Moneda de pago";
	if ( k == "Required Material for Upgrades" ) return "Material requerido";
	if ( k == "Base Crown Cost per Level Difference" ) return "Costo base en coronas por nivel";
	if ( k == "Cost Multiplier: Common / Magic" ) return "Multiplicador: Común / Mágico";
	if ( k == "Cost Multiplier: Relic / Rare" ) return "Multiplicador: Reliquia / Raro";
	if ( k == "Cost Multiplier: Witcher School" ) return "Multiplicador: Escuela de brujo";
	if ( k == "Show On-Screen HUD Notification" ) return "Mostrar notificación en pantalla (HUD)";
	if ( k == "Play Craftsman Anvil Sound Effect" ) return "Efecto de sonido de yunque";
	if ( k == "All Gear (Vanilla and Modded)" ) return "Todo el equipo (original y mods)";
	if ( k == "Witcher and Relic Gear Only" ) return "Solo equipo de brujo y reliquias";
	if ( k == "Witcher School Gear Only" ) return "Solo equipo de escuelas de brujo";
	if ( k == "Manual (One-by-One in Repair Tab)" ) return "Manual (Uno a uno en pestaña de reparación)";
	if ( k == "Automatic (All Gear on Dialogue)" ) return "Automático (Todo al hablar)";
	if ( k == "Free (Zero Cost)" ) return "Gratis (sin costo)";
	if ( k == "Crowns Only" ) return "Solo coronas";
	if ( k == "Materials Only" ) return "Solo materiales";
	if ( k == "Crowns and Materials" ) return "Coronas y materiales";
	if ( k == "Tempering Oil / Alchemical" ) return "Aceite de templado / Alquimia";
	if ( k == "Weapon / Armor Repair Kit" ) return "Kit de reparación de armas / armaduras";
	if ( k == "Dimeritium Ingot" ) return "Lingote de dimerita";
	if ( k == "Meteorite Ore" ) return "Mineral de meteorito";
	if ( k == "Crowns" ) return "Coronas";
	if ( k == "Oil" ) return "Aceite";
	if ( k == "Repair Kit" ) return "Kit de reparación";
	if ( k == "Material" ) return "Material";
	if ( k == "Normalize Secondary Stats (Restore on Level-Up)" ) return "Normalizar estadísticas secundarias (restaurar al subir de nivel)";
	if ( k == "Upgrade Stash Gear (Player Chest)" ) return "Mejorar equipo del alijo (Cofre del jugador)";
	if ( k == "Relic and Modded Gear Only (Exclude Witcher)" ) return "Solo reliquias y mods (sin equipo de brujo)";
	if ( k == "Upgrade Trigger: On Opening Stash Chest" ) return "Mejora: al abrir el alijo";
	return "";
}

function ModLevelingGear_GetLoc_IT(k : string) : string
{
	if ( k == "Installed Version" ) return "Versione installata";
	if ( k == "v1.0.4" ) return "v1.0.4";
	if ( k == "Mods" ) return "MOD";
	if ( k == "mods" ) return "MOD";
	if ( k == "Mods.LevelingGear" ) return "Leveling Gear";
	if ( k == "LevelingGear" ) return "Leveling Gear";
	if ( k == "mod_leveling_gear" ) return "Leveling Gear";
	if ( k == "Enable Leveling Gear" ) return "Attiva Leveling Gear";
	if ( k == "Gear Whitelist Scope" ) return "Ambito equipaggiamento";
	if ( k == "Exclude Aerondight (Native Stacking)" ) return "Escludi Aerondight (livellamento nativo)";
	if ( k == "Enable Crossbow Scaling" ) return "Abilita scalabilità balestre";
	if ( k == "Auto-Scale Loot Drops" ) return "Scala automaticamente il bottino";
	if ( k == "Upgrade Trigger: At Craftsmen" ) return "Potenziamento: Dagli artigiani";
	if ( k == "Upgrade Trigger: At Craftsmen (Dialogue)" ) return "Potenziamento: Dagli artigiani (dialogo)";
	if ( k == "Craftsman Upgrade Mode" ) return "Modalità potenziamento artigiano";
	if ( k == "Upgrade Bagged Inventory Gear" ) return "Potenzia anche l'inventario";
	if ( k == "Upgrade Trigger: Via Field Maintenance Kit" ) return "Potenziamento: Con kit da campo";
	if ( k == "Allow Field Kit on Pristine (100%) Gear" ) return "Consenti kit su equipaggiamento integro (100%)";
	if ( k == "Upgrade Trigger: On Level-Up (Auto)" ) return "Potenziamento: Al passaggio di livello (auto)";
	if ( k == "Upgrade Trigger: On Item Equip" ) return "Potenziamento: All'equipaggiamento";
	if ( k == "Downscale High-Level Gear to Player Level" ) return "Riduci livello equipaggiamento superiore";
	if ( k == "Downscale Cost Multiplier (0.0 = Free)" ) return "Moltiplicatore costo riduzione (0.0 = gratuito)";
	if ( k == "Payment Currency" ) return "Valuta di pagamento";
	if ( k == "Required Material for Upgrades" ) return "Materiale richiesto";
	if ( k == "Base Crown Cost per Level Difference" ) return "Costo base in corone per livello";
	if ( k == "Cost Multiplier: Common / Magic" ) return "Moltiplicatore: Comune / Magico";
	if ( k == "Cost Multiplier: Relic / Rare" ) return "Moltiplicatore: Reliquia / Raro";
	if ( k == "Cost Multiplier: Witcher School" ) return "Moltiplicatore: Scuola di witcher";
	if ( k == "Show On-Screen HUD Notification" ) return "Mostra notifica HUD sullo schermo";
	if ( k == "Play Craftsman Anvil Sound Effect" ) return "Riproduci suono dell'incudine";
	if ( k == "All Gear (Vanilla and Modded)" ) return "Tutto l'equipaggiamento (gioco e mod)";
	if ( k == "Witcher and Relic Gear Only" ) return "Solo equipaggiamento witcher e reliquie";
	if ( k == "Witcher School Gear Only" ) return "Solo equipaggiamento delle scuole di witcher";
	if ( k == "Manual (One-by-One in Repair Tab)" ) return "Manuale (Uno a uno nella scheda riparazione)";
	if ( k == "Automatic (All Gear on Dialogue)" ) return "Automatico (Tutto al dialogo)";
	if ( k == "Free (Zero Cost)" ) return "Gratuito (costo zero)";
	if ( k == "Crowns Only" ) return "Solo corone";
	if ( k == "Materials Only" ) return "Solo materiali";
	if ( k == "Crowns and Materials" ) return "Corone e materiali";
	if ( k == "Tempering Oil / Alchemical" ) return "Olio di tempra / Alchemico";
	if ( k == "Weapon / Armor Repair Kit" ) return "Kit riparazione armi / armature";
	if ( k == "Dimeritium Ingot" ) return "Lingotto di dimeritium";
	if ( k == "Meteorite Ore" ) return "Minerale di meteorite";
	if ( k == "Crowns" ) return "Corone";
	if ( k == "Oil" ) return "Olio";
	if ( k == "Repair Kit" ) return "Kit di riparazione";
	if ( k == "Material" ) return "Materiale";
	if ( k == "Normalize Secondary Stats (Restore on Level-Up)" ) return "Normalizza statistiche secondarie (ripristina al passaggio di livello)";
	if ( k == "Upgrade Stash Gear (Player Chest)" ) return "Potenzia equipaggiamento nel baule (Deposito)";
	if ( k == "Relic and Modded Gear Only (Exclude Witcher)" ) return "Solo reliquie e mod (escluso strigo)";
	if ( k == "Upgrade Trigger: On Opening Stash Chest" ) return "Potenziamento: all'apertura del baule";
	return "";
}

function ModLevelingGear_GetLoc_BR(k : string) : string
{
	if ( k == "Installed Version" ) return "Versão instalada";
	if ( k == "v1.0.4" ) return "v1.0.4";
	if ( k == "Mods" ) return "MODS";
	if ( k == "mods" ) return "MODS";
	if ( k == "Mods.LevelingGear" ) return "Leveling Gear";
	if ( k == "LevelingGear" ) return "Leveling Gear";
	if ( k == "mod_leveling_gear" ) return "Leveling Gear";
	if ( k == "Enable Leveling Gear" ) return "Ativar Leveling Gear";
	if ( k == "Gear Whitelist Scope" ) return "Escopo de equipamentos";
	if ( k == "Exclude Aerondight (Native Stacking)" ) return "Excluir Aerondight (progressão nativa)";
	if ( k == "Enable Crossbow Scaling" ) return "Ativar escalonamento de bestas";
	if ( k == "Auto-Scale Loot Drops" ) return "Ajustar saques automaticamente";
	if ( k == "Upgrade Trigger: At Craftsmen" ) return "Aprimoramento: Nos artesãos";
	if ( k == "Upgrade Trigger: At Craftsmen (Dialogue)" ) return "Aprimoramento: Nos artesãos (diálogo)";
	if ( k == "Craftsman Upgrade Mode" ) return "Modo de aprimoramento no artesão";
	if ( k == "Upgrade Bagged Inventory Gear" ) return "Aprimorar equipamentos do inventário";
	if ( k == "Upgrade Trigger: Via Field Maintenance Kit" ) return "Aprimoramento: Via kits de reparo";
	if ( k == "Allow Field Kit on Pristine (100%) Gear" ) return "Permitir kits em equipamentos 100% íntegros";
	if ( k == "Upgrade Trigger: On Level-Up (Auto)" ) return "Aprimoramento: Ao subir de nível (auto)";
	if ( k == "Upgrade Trigger: On Item Equip" ) return "Aprimoramento: Ao equipar item";
	if ( k == "Downscale High-Level Gear to Player Level" ) return "Reduzir nível de equipamentos altos";
	if ( k == "Downscale Cost Multiplier (0.0 = Free)" ) return "Multiplicador de custo de redução (0.0 = grátis)";
	if ( k == "Payment Currency" ) return "Forma de pagamento";
	if ( k == "Required Material for Upgrades" ) return "Material necessário";
	if ( k == "Base Crown Cost per Level Difference" ) return "Custo base em coroas por nível";
	if ( k == "Cost Multiplier: Common / Magic" ) return "Multiplicador: Comum / Mágico";
	if ( k == "Cost Multiplier: Relic / Rare" ) return "Multiplicador: Relíquia / Raro";
	if ( k == "Cost Multiplier: Witcher School" ) return "Multiplicador: Escola de Bruxo";
	if ( k == "Show On-Screen HUD Notification" ) return "Exibir notificação na tela (HUD)";
	if ( k == "Play Craftsman Anvil Sound Effect" ) return "Tocar som de bigorna";
	if ( k == "All Gear (Vanilla and Modded)" ) return "Todos os equipamentos (jogo e mods)";
	if ( k == "Witcher and Relic Gear Only" ) return "Apenas itens de bruxo e relíquias";
	if ( k == "Witcher School Gear Only" ) return "Apenas itens de escolas de bruxo";
	if ( k == "Manual (One-by-One in Repair Tab)" ) return "Manual (Um por um na aba de reparo)";
	if ( k == "Automatic (All Gear on Dialogue)" ) return "Automático (Tudo no diálogo)";
	if ( k == "Free (Zero Cost)" ) return "Grátis (sem custo)";
	if ( k == "Crowns Only" ) return "Apenas coroas";
	if ( k == "Materials Only" ) return "Apenas materiais";
	if ( k == "Crowns and Materials" ) return "Coroas e materiais";
	if ( k == "Tempering Oil / Alchemical" ) return "Óleo de têmpera / Alquimia";
	if ( k == "Weapon / Armor Repair Kit" ) return "Kit de reparo de armas / armaduras";
	if ( k == "Dimeritium Ingot" ) return "Lingote de dimerítio";
	if ( k == "Meteorite Ore" ) return "Minério de meteorito";
	if ( k == "Crowns" ) return "Coroas";
	if ( k == "Oil" ) return "Óleo";
	if ( k == "Repair Kit" ) return "Kit de reparo";
	if ( k == "Material" ) return "Material";
	if ( k == "Normalize Secondary Stats (Restore on Level-Up)" ) return "Normalizar atributos secundários (restaurar ao subir de nível)";
	if ( k == "Upgrade Stash Gear (Player Chest)" ) return "Melhorar equipamento no baú (Esconderijo)";
	if ( k == "Relic and Modded Gear Only (Exclude Witcher)" ) return "Apenas relíquias e itens de mods (sem bruxo)";
	if ( k == "Upgrade Trigger: On Opening Stash Chest" ) return "Melhoria: ao abrir o baú";
	return "";
}

function ModLevelingGear_GetLoc_ZHTW(k : string) : string
{
	if ( k == "Installed Version" ) return "已安裝版本";
	if ( k == "v1.0.16" || k == "v1.0.15" || k == "v1.0.14" || k == "v1.0.13" || k == "v1.0.13b" || k == "v1.0.12" || k == "v1.0.11" || k == "v1.0.5" || k == "v1.0.4" ) return "v1.0.16";
	if ( k == "Preset" ) return "預設";
	if ( k == "Khser's Choice" ) return "Khser 推薦";
	if ( k == "Story (Free)" ) return "劇情 (免費)";
	if ( k == "Hardcore" ) return "硬核";
	if ( k == "Purist" ) return "純粹模式";
	if ( k == "Mods" ) return "模組";
	if ( k == "mods" ) return "模組";
	if ( k == "Mods.LevelingGear" ) return "Leveling Gear";
	if ( k == "LevelingGear" ) return "Leveling Gear";
	if ( k == "mod_leveling_gear" ) return "Leveling Gear";
	if ( k == "Leveling Gear" ) return "Leveling Gear";
	if ( k == "Enable Leveling Gear" ) return "啟用裝備等級同步";
	if ( k == "Gear Whitelist Scope" ) return "裝備同步範圍";
	if ( k == "Exclude Aerondight (Native Stacking)" ) return "排除湖女之劍 (自帶成長機制)";
	if ( k == "Enable Crossbow Scaling" ) return "啟用十字弩等級縮放";
	if ( k == "Auto-Scale Loot Drops" ) return "自動縮放戰利品掉落";
	if ( k == "Upgrade Trigger: At Craftsmen" ) return "升級觸發: 工匠處";
	if ( k == "Upgrade Trigger: At Craftsmen (Dialogue)" ) return "升級觸發: 與工匠對話";
	if ( k == "Craftsman Upgrade Mode" ) return "工匠升級模式";
	if ( k == "Craftsman Durability Repair Action" ) return "工匠耐久修理動作";
	if ( k == "Durability Repair Only (No Leveling)" ) return "僅修復耐久 (不升級)";
	if ( k == "Repair + Level Tempering (Combined)" ) return "修復 + 等級淬鍊 (組合)";
	if ( k == "Temper Only When Pristine (100% Durability)" ) return "僅在完好 (100%耐久) 時淬鍊";
	if ( k == "Upgrade Bagged Inventory Gear" ) return "同時升級背包中的裝備";
	if ( k == "Upgrade Trigger: Via Field Maintenance Kit" ) return "升級觸發: 使用野外修理工具包";
	if ( k == "Allow Field Kit on Pristine (100%) Gear" ) return "允許在滿耐久度(100%)裝備上使用工具包";
	if ( k == "Upgrade Trigger: On Level-Up (Auto)" ) return "升級觸發: 升級時自動升級裝備";
	if ( k == "Upgrade Trigger: On Item Equip" ) return "升級觸發: 裝備物品時";
	if ( k == "Downscale High-Level Gear to Player Level" ) return "將高等級裝備降級至玩家等級";
	if ( k == "Downscale Cost Multiplier (0.0 = Free)" ) return "降級費用乘數 (0.0 = 免費)";
	if ( k == "Payment Currency" ) return "支付貨幣";
	if ( k == "Required Material for Upgrades" ) return "升級所需材料";
	if ( k == "Base Crown Cost per Level Difference" ) return "每級等級差基礎克朗花費";
	if ( k == "Cost Multiplier: Common / Magic" ) return "費用乘數: 普通 / 魔法";
	if ( k == "Cost Multiplier: Relic / Rare" ) return "費用乘數: 遺物 / 稀有";
	if ( k == "Cost Multiplier: Witcher School" ) return "費用乘數: 狩魔獵人學派裝備";
	if ( k == "Show On-Screen HUD Notification" ) return "顯示螢幕HUD提示";
	if ( k == "Play Craftsman Anvil Sound Effect" ) return "播放鐵匠鐵砧音效";
	if ( k == "All Gear (Vanilla and Modded)" ) return "所有裝備 (原版及模組)";
	if ( k == "Witcher and Relic Gear Only" ) return "僅限狩魔獵人及遺物裝備";
	if ( k == "Witcher School Gear Only" ) return "僅限狩魔獵人學派裝備";
	if ( k == "Manual (One-by-One in Repair Tab)" ) return "手動 (在修理分頁逐件升級)";
	if ( k == "Automatic (All Gear on Dialogue)" ) return "自動 (對話時全部升級)";
	if ( k == "Free (Zero Cost)" ) return "免費 (無消耗)";
	if ( k == "Crowns Only" ) return "僅克朗";
	if ( k == "Materials Only" ) return "僅材料";
	if ( k == "Crowns and Materials" ) return "克朗與材料";
	if ( k == "Tempering Oil / Alchemical" ) return "淬火油 / 煉金酒精";
	if ( k == "Weapon / Armor Repair Kit" ) return "武器 / 護甲修理工具包";
	if ( k == "Dimeritium Ingot" ) return "阻魔金錠";
	if ( k == "Meteorite Ore" ) return "隕鐵礦石";
	if ( k == "Crowns" ) return "克朗";
	if ( k == "Oil" ) return "劍油";
	if ( k == "Repair Kit" ) return "修理工具包";
	if ( k == "Material" ) return "材料";
	if ( k == "Normalize Secondary Stats (Restore on Level-Up)" ) return "次要屬性平衡歸一化 (升級時逐步恢復)";
	if ( k == "Upgrade Stash Gear (Player Chest)" ) return "升級儲物箱裝備 (玩家儲物箱)";
	if ( k == "Relic and Modded Gear Only (Exclude Witcher)" ) return "僅限遺物及模組裝備 (排除狩魔獵人套裝)";
	if ( k == "Upgrade Trigger: On Opening Stash Chest" ) return "升級觸發: 打開儲物箱時";
	return "";
}

function ModLevelingGear_GetLoc_ZHCN(k : string) : string
{
	if ( k == "Installed Version" ) return "已安装版本";
	if ( k == "v1.0.16" || k == "v1.0.15" || k == "v1.0.14" || k == "v1.0.13" || k == "v1.0.13b" || k == "v1.0.12" || k == "v1.0.11" || k == "v1.0.5" || k == "v1.0.4" ) return "v1.0.16";
	if ( k == "Preset" ) return "预设";
	if ( k == "Khser's Choice" ) return "Khser 推荐";
	if ( k == "Story (Free)" ) return "剧情 (免费)";
	if ( k == "Hardcore" ) return "硬核";
	if ( k == "Purist" ) return "纯粹模式";
	if ( k == "Mods" ) return "模组";
	if ( k == "mods" ) return "模组";
	if ( k == "Mods.LevelingGear" ) return "Leveling Gear";
	if ( k == "LevelingGear" ) return "Leveling Gear";
	if ( k == "mod_leveling_gear" ) return "Leveling Gear";
	if ( k == "Leveling Gear" ) return "Leveling Gear";
	if ( k == "Enable Leveling Gear" ) return "启用装备等级同步";
	if ( k == "Gear Whitelist Scope" ) return "装备同步范围";
	if ( k == "Exclude Aerondight (Native Stacking)" ) return "排除湖女之剑 (自带成长机制)";
	if ( k == "Enable Crossbow Scaling" ) return "启用十字弩等级缩放";
	if ( k == "Auto-Scale Loot Drops" ) return "自动缩放战利品掉落";
	if ( k == "Upgrade Trigger: At Craftsmen" ) return "升级触发: 工匠处";
	if ( k == "Upgrade Trigger: At Craftsmen (Dialogue)" ) return "升级触发: 与工匠对话";
	if ( k == "Craftsman Upgrade Mode" ) return "工匠升级模式";
	if ( k == "Craftsman Durability Repair Action" ) return "工匠耐久修理动作";
	if ( k == "Durability Repair Only (No Leveling)" ) return "仅修复耐久 (不升级)";
	if ( k == "Repair + Level Tempering (Combined)" ) return "修复 + 等级淬炼 (组合)";
	if ( k == "Temper Only When Pristine (100% Durability)" ) return "仅在完好 (100%耐久) 时淬炼";
	if ( k == "Upgrade Bagged Inventory Gear" ) return "同时升级背包中的装备";
	if ( k == "Upgrade Trigger: Via Field Maintenance Kit" ) return "升级触发: 使用野外修理工具包";
	if ( k == "Allow Field Kit on Pristine (100%) Gear" ) return "允许在满耐久度(100%)装备上使用工具包";
	if ( k == "Upgrade Trigger: On Level-Up (Auto)" ) return "升级触发: 升级时自动升级装备";
	if ( k == "Upgrade Trigger: On Item Equip" ) return "升级触发: 装备物品时";
	if ( k == "Downscale High-Level Gear to Player Level" ) return "将高等级装备降级至玩家等级";
	if ( k == "Downscale Cost Multiplier (0.0 = Free)" ) return "降级费用乘数 (0.0 = 免费)";
	if ( k == "Payment Currency" ) return "支付货币";
	if ( k == "Required Material for Upgrades" ) return "升级所需材料";
	if ( k == "Base Crown Cost per Level Difference" ) return "每级等级差基础克朗花费";
	if ( k == "Cost Multiplier: Common / Magic" ) return "费用乘数: 普通 / 魔法";
	if ( k == "Cost Multiplier: Relic / Rare" ) return "费用乘数: 遗物 / 稀有";
	if ( k == "Cost Multiplier: Witcher School" ) return "费用乘数: 猎魔人学派装备";
	if ( k == "Show On-Screen HUD Notification" ) return "显示屏幕HUD提示";
	if ( k == "Play Craftsman Anvil Sound Effect" ) return "播放铁匠铁砧音效";
	if ( k == "All Gear (Vanilla and Modded)" ) return "所有装备 (原版及模组)";
	if ( k == "Witcher and Relic Gear Only" ) return "仅限猎魔人及遗物装备";
	if ( k == "Witcher School Gear Only" ) return "仅限猎魔人学派装备";
	if ( k == "Manual (One-by-One in Repair Tab)" ) return "手动 (在修理标签页逐件升级)";
	if ( k == "Automatic (All Gear on Dialogue)" ) return "自动 (对话时全部升级)";
	if ( k == "Free (Zero Cost)" ) return "免费 (无消耗)";
	if ( k == "Crowns Only" ) return "仅克朗";
	if ( k == "Materials Only" ) return "仅材料";
	if ( k == "Crowns and Materials" ) return "克朗与材料";
	if ( k == "Tempering Oil / Alchemical" ) return "淬火油 / 炼金酒精";
	if ( k == "Weapon / Armor Repair Kit" ) return "武器 / 护甲修理工具包";
	if ( k == "Dimeritium Ingot" ) return "阻魔金锭";
	if ( k == "Meteorite Ore" ) return "陨铁矿石";
	if ( k == "Crowns" ) return "克朗";
	if ( k == "Oil" ) return "剑油";
	if ( k == "Repair Kit" ) return "修理工具包";
	if ( k == "Material" ) return "材料";
	if ( k == "Normalize Secondary Stats (Restore on Level-Up)" ) return "次要属性平衡归一化 (升级时逐步恢复)";
	if ( k == "Upgrade Stash Gear (Player Chest)" ) return "升级储物箱装备 (玩家储物箱)";
	if ( k == "Relic and Modded Gear Only (Exclude Witcher)" ) return "仅限遗物及模组装备 (排除猎魔人套装)";
	if ( k == "Upgrade Trigger: On Opening Stash Chest" ) return "升级触发: 打开储物箱时";
	return "";
}

function ModLevelingGear_GetLoc_JP(k : string) : string
{
	if ( k == "Installed Version" ) return "インストール済みバージョン";
	if ( k == "v1.0.4" ) return "v1.0.4";
	if ( k == "Mods" ) return "MOD";
	if ( k == "mods" ) return "MOD";
	if ( k == "Mods.LevelingGear" ) return "Leveling Gear";
	if ( k == "LevelingGear" ) return "Leveling Gear";
	if ( k == "mod_leveling_gear" ) return "Leveling Gear";
	if ( k == "Enable Leveling Gear" ) return "装備レベル同期を有効化";
	if ( k == "Gear Whitelist Scope" ) return "対象装備の範囲";
	if ( k == "Exclude Aerondight (Native Stacking)" ) return "エアロンダイトを除外 (固有の成長機能)";
	if ( k == "Enable Crossbow Scaling" ) return "クロスボウのスケーリングを有効化";
	if ( k == "Auto-Scale Loot Drops" ) return "ドロップ戦利品の自動調整";
	if ( k == "Upgrade Trigger: At Craftsmen" ) return "強化契機: 職人";
	if ( k == "Upgrade Trigger: At Craftsmen (Dialogue)" ) return "強化契機: 職人 (会話時)";
	if ( k == "Craftsman Upgrade Mode" ) return "職人強化モード";
	if ( k == "Upgrade Bagged Inventory Gear" ) return "所持品の装備も強化";
	if ( k == "Upgrade Trigger: Via Field Maintenance Kit" ) return "強化契機: 修理道具を使用";
	if ( k == "Allow Field Kit on Pristine (100%) Gear" ) return "耐久度100%の装備への道具使用を許可";
	if ( k == "Upgrade Trigger: On Level-Up (Auto)" ) return "強化契機: レベルアップ時 (自動)";
	if ( k == "Upgrade Trigger: On Item Equip" ) return "強化契機: 装備時";
	if ( k == "Downscale High-Level Gear to Player Level" ) return "高レベル装備をプレイヤーレベルに調整";
	if ( k == "Downscale Cost Multiplier (0.0 = Free)" ) return "レベル調整コスト倍率 (0.0 = 無料)";
	if ( k == "Payment Currency" ) return "支払い通貨";
	if ( k == "Required Material for Upgrades" ) return "強化に必要な素材";
	if ( k == "Base Crown Cost per Level Difference" ) return "レベル差ごとの基本クラウン費用";
	if ( k == "Cost Multiplier: Common / Magic" ) return "コスト倍率: 一般 / 魔法";
	if ( k == "Cost Multiplier: Relic / Rare" ) return "コスト倍率: レリック / レア";
	if ( k == "Cost Multiplier: Witcher School" ) return "コスト倍率: ウィッチャー流派装備";
	if ( k == "Show On-Screen HUD Notification" ) return "画面上HUD通知を表示";
	if ( k == "Play Craftsman Anvil Sound Effect" ) return "鍛冶屋の金床効果音を再生";
	if ( k == "All Gear (Vanilla and Modded)" ) return "すべての装備 (バニラおよびMOD)";
	if ( k == "Witcher and Relic Gear Only" ) return "ウィッチャーおよびレリック装備のみ";
	if ( k == "Witcher School Gear Only" ) return "ウィッチャー流派装備のみ";
	if ( k == "Manual (One-by-One in Repair Tab)" ) return "手動 (修理タブで1つずつ)";
	if ( k == "Automatic (All Gear on Dialogue)" ) return "自動 (会話時にすべて)";
	if ( k == "Free (Zero Cost)" ) return "無料 (コストなし)";
	if ( k == "Crowns Only" ) return "クラウンのみ";
	if ( k == "Materials Only" ) return "素材のみ";
	if ( k == "Crowns and Materials" ) return "クラウンと素材";
	if ( k == "Tempering Oil / Alchemical" ) return "焼き入れ油 / 錬金術用アルコール";
	if ( k == "Weapon / Armor Repair Kit" ) return "武器 / 防具修理道具";
	if ( k == "Dimeritium Ingot" ) return "ディメリティウムのインゴット";
	if ( k == "Meteorite Ore" ) return "隕鉄鉱石";
	if ( k == "Crowns" ) return "クラウン";
	if ( k == "Oil" ) return "オイル";
	if ( k == "Repair Kit" ) return "修理道具";
	if ( k == "Material" ) return "素材";
	if ( k == "Normalize Secondary Stats (Restore on Level-Up)" ) return "サブステータスの正規化 (レベルアップ時に徐々に復元)";
	if ( k == "Upgrade Stash Gear (Player Chest)" ) return "保管箱の装備を強化（収納箱）";
	if ( k == "Relic and Modded Gear Only (Exclude Witcher)" ) return "レリックとMOD装備のみ（ウィッチャー装備除く）";
	if ( k == "Upgrade Trigger: On Opening Stash Chest" ) return "強化トリガー：収納箱を開けた時";
	return "";
}

function ModLevelingGear_GetLoc_KR(k : string) : string
{
	if ( k == "Installed Version" ) return "설치된 버전";
	if ( k == "v1.0.4" ) return "v1.0.4";
	if ( k == "Mods" ) return "모드";
	if ( k == "mods" ) return "모드";
	if ( k == "Mods.LevelingGear" ) return "Leveling Gear";
	if ( k == "LevelingGear" ) return "Leveling Gear";
	if ( k == "mod_leveling_gear" ) return "Leveling Gear";
	if ( k == "Enable Leveling Gear" ) return "장비 레벨 동기화 활성화";
	if ( k == "Gear Whitelist Scope" ) return "대상 장비 범위";
	if ( k == "Exclude Aerondight (Native Stacking)" ) return "에어론다이트 제외 (고유 레벨업 기능)";
	if ( k == "Enable Crossbow Scaling" ) return "석궁 스케일링 활성화";
	if ( k == "Auto-Scale Loot Drops" ) return "전리품 드롭 자동 조절";
	if ( k == "Upgrade Trigger: At Craftsmen" ) return "강화 조건: 장인";
	if ( k == "Upgrade Trigger: At Craftsmen (Dialogue)" ) return "강화 조건: 장인 (대화 시)";
	if ( k == "Craftsman Upgrade Mode" ) return "장인 강화 모드";
	if ( k == "Upgrade Bagged Inventory Gear" ) return "소지품 내 장비도 함께 강화";
	if ( k == "Upgrade Trigger: Via Field Maintenance Kit" ) return "강화 조건: 야외 수리 도구 사용";
	if ( k == "Allow Field Kit on Pristine (100%) Gear" ) return "완전한 (100%) 내구도 장비에 수리 도구 사용 허용";
	if ( k == "Upgrade Trigger: On Level-Up (Auto)" ) return "강화 조건: 레벨업 시 (자동)";
	if ( k == "Upgrade Trigger: On Item Equip" ) return "강화 조건: 아이템 장착 시";
	if ( k == "Downscale High-Level Gear to Player Level" ) return "고레벨 장비를 플레이어 레벨로 하향 조정";
	if ( k == "Downscale Cost Multiplier (0.0 = Free)" ) return "하향 조정 비용 배율 (0.0 = 무료)";
	if ( k == "Payment Currency" ) return "결제 방식";
	if ( k == "Required Material for Upgrades" ) return "강화 필수 재료";
	if ( k == "Base Crown Cost per Level Difference" ) return "레벨 차이당 기본 크라운 비용";
	if ( k == "Cost Multiplier: Common / Magic" ) return "비용 배율: 일반 / 마법";
	if ( k == "Cost Multiplier: Relic / Rare" ) return "비용 배율: 유물 / 희귀";
	if ( k == "Cost Multiplier: Witcher School" ) return "비용 배율: 위쳐 교단 장비";
	if ( k == "Show On-Screen HUD Notification" ) return "화면 HUD 알림 표시";
	if ( k == "Play Craftsman Anvil Sound Effect" ) return "대장장이 모루 효과음 재생";
	if ( k == "All Gear (Vanilla and Modded)" ) return "모든 장비 (바닐라 및 모드)";
	if ( k == "Witcher and Relic Gear Only" ) return "위쳐 및 유물 장비만";
	if ( k == "Witcher School Gear Only" ) return "위쳐 교단 장비만";
	if ( k == "Manual (One-by-One in Repair Tab)" ) return "수동 (수리 탭에서 개별 강화)";
	if ( k == "Automatic (All Gear on Dialogue)" ) return "자동 (대화 시 일괄 강화)";
	if ( k == "Free (Zero Cost)" ) return "무료 (비용 없음)";
	if ( k == "Crowns Only" ) return "크라운만";
	if ( k == "Materials Only" ) return "재료만";
	if ( k == "Crowns and Materials" ) return "크라운 및 재료";
	if ( k == "Tempering Oil / Alchemical" ) return "담금질 기름 / 연금술 알코올";
	if ( k == "Weapon / Armor Repair Kit" ) return "무기 / 갑옷 수리 도구";
	if ( k == "Dimeritium Ingot" ) return "디메리티움 주괴";
	if ( k == "Meteorite Ore" ) return "운석 광석";
	if ( k == "Crowns" ) return "크라운";
	if ( k == "Oil" ) return "기름";
	if ( k == "Repair Kit" ) return "수리 도구";
	if ( k == "Material" ) return "재료";
	if ( k == "Normalize Secondary Stats (Restore on Level-Up)" ) return "보조 능력치 정규화 (레벨업 시 점진적 복구)";
	if ( k == "Upgrade Stash Gear (Player Chest)" ) return "보관함 장비 강화 (플레이어 상자)";
	if ( k == "Relic and Modded Gear Only (Exclude Witcher)" ) return "유물 및 모드 장비만 (위쳐 장비 제외)";
	if ( k == "Upgrade Trigger: On Opening Stash Chest" ) return "강화 트리거: 보관함을 열 때";
	return "";
}

function ModLevelingGear_GetLoc_CZ(k : string) : string
{
	if ( k == "Installed Version" ) return "Nainstalovaná verze";
	if ( k == "v1.0.4" ) return "v1.0.4";
	if ( k == "Mods" ) return "MODY";
	if ( k == "mods" ) return "MODY";
	if ( k == "Mods.LevelingGear" ) return "Leveling Gear";
	if ( k == "LevelingGear" ) return "Leveling Gear";
	if ( k == "mod_leveling_gear" ) return "Leveling Gear";
	if ( k == "Enable Leveling Gear" ) return "Povolit Leveling Gear";
	if ( k == "Gear Whitelist Scope" ) return "Rozsah vylepsene vybavy";
	if ( k == "Exclude Aerondight (Native Stacking)" ) return "Vyloucit Aerondight (vlastni skalovani)";
	if ( k == "Enable Crossbow Scaling" ) return "Povolit škálování kuší";
	if ( k == "Auto-Scale Loot Drops" ) return "Automaticky skalovat korist";
	if ( k == "Upgrade Trigger: At Craftsmen" ) return "Vylepseni: U remeslniku";
	if ( k == "Upgrade Trigger: At Craftsmen (Dialogue)" ) return "Vylepseni: U remeslniku (dialog)";
	if ( k == "Craftsman Upgrade Mode" ) return "Rezim vylepseni u remeslnika";
	if ( k == "Upgrade Bagged Inventory Gear" ) return "Vylepsovat take vybavu v inventari";
	if ( k == "Upgrade Trigger: Via Field Maintenance Kit" ) return "Vylepseni: Opravnymi sadami";
	if ( k == "Allow Field Kit on Pristine (100%) Gear" ) return "Povolit sady na neposkozene (100%) vybaveni";
	if ( k == "Upgrade Trigger: On Level-Up (Auto)" ) return "Vylepseni: Pri postupu na vyssi uroven";
	if ( k == "Upgrade Trigger: On Item Equip" ) return "Vylepseni: Pri nasazeni predmetu";
	if ( k == "Downscale High-Level Gear to Player Level" ) return "Snizit uroven vysokeho vybaveni";
	if ( k == "Downscale Cost Multiplier (0.0 = Free)" ) return "Nasobitel ceny snizeni (0.0 = zdarma)";
	if ( k == "Payment Currency" ) return "Mena platby";
	if ( k == "Required Material for Upgrades" ) return "Pozadovany material";
	if ( k == "Base Crown Cost per Level Difference" ) return "Zakladni cena v korunach za uroven";
	if ( k == "Cost Multiplier: Common / Magic" ) return "Nasobitel: Bezna / Magicka";
	if ( k == "Cost Multiplier: Relic / Rare" ) return "Nasobitel: Relikvie / Vzacna";
	if ( k == "Cost Multiplier: Witcher School" ) return "Nasobitel: Zaklinacska skola";
	if ( k == "Show On-Screen HUD Notification" ) return "Zobrazovat oznameni na obrazovce (HUD)";
	if ( k == "Play Craftsman Anvil Sound Effect" ) return "Prehrat zvuk kovadliny";
	if ( k == "All Gear (Vanilla and Modded)" ) return "Veskera vybava (puvodni i z modu)";
	if ( k == "Witcher and Relic Gear Only" ) return "Pouze zaklinacska vybava a relikvie";
	if ( k == "Witcher School Gear Only" ) return "Pouze vybava zaklinacskych skol";
	if ( k == "Manual (One-by-One in Repair Tab)" ) return "Rucne (po jednom v zalozce oprav)";
	if ( k == "Automatic (All Gear on Dialogue)" ) return "Automaticky (vse pri dialogu)";
	if ( k == "Free (Zero Cost)" ) return "Zdarma (zadne naklady)";
	if ( k == "Crowns Only" ) return "Pouze koruny";
	if ( k == "Materials Only" ) return "Pouze materialy";
	if ( k == "Crowns and Materials" ) return "Koruny a materialy";
	if ( k == "Tempering Oil / Alchemical" ) return "Kalici olej / alchymicky lih";
	if ( k == "Weapon / Armor Repair Kit" ) return "Opravna sada pro zbrane / zbroje";
	if ( k == "Dimeritium Ingot" ) return "Dimeritiovy ingot";
	if ( k == "Meteorite Ore" ) return "Meteoritova ruda";
	if ( k == "Crowns" ) return "Koruny";
	if ( k == "Oil" ) return "Olej";
	if ( k == "Repair Kit" ) return "Opravna sada";
	if ( k == "Material" ) return "Material";
	if ( k == "Normalize Secondary Stats (Restore on Level-Up)" ) return "Normalizovat sekundární statistiky (obnovit při postupu na úroveň)";
	if ( k == "Upgrade Stash Gear (Player Chest)" ) return "Vylepšovat vybavení v truhle (Úschovna)";
	if ( k == "Relic and Modded Gear Only (Exclude Witcher)" ) return "Pouze reliktní a modifikované vybavení (bez zaklínačského)";
	if ( k == "Upgrade Trigger: On Opening Stash Chest" ) return "Vylepšení: Při otevření truhly";
	return "";
}

function ModLevelingGear_GetLoc_HU(k : string) : string
{
	if ( k == "Installed Version" ) return "Telepített verzió";
	if ( k == "v1.0.4" ) return "v1.0.4";
	if ( k == "Mods" ) return "MODOK";
	if ( k == "mods" ) return "MODOK";
	if ( k == "Mods.LevelingGear" ) return "Leveling Gear";
	if ( k == "LevelingGear" ) return "Leveling Gear";
	if ( k == "mod_leveling_gear" ) return "Leveling Gear";
	if ( k == "Enable Leveling Gear" ) return "Leveling Gear engedelyezese";
	if ( k == "Gear Whitelist Scope" ) return "Felszereles hatokore";
	if ( k == "Exclude Aerondight (Native Stacking)" ) return "Aerondight kizarasa (sajat szintlepes)";
	if ( k == "Enable Crossbow Scaling" ) return "Számszeríj szintezés engedélyezése";
	if ( k == "Auto-Scale Loot Drops" ) return "Zsakmany automatikus szintigazitasa";
	if ( k == "Upgrade Trigger: At Craftsmen" ) return "Fejlesztes: Kezmuveseknel";
	if ( k == "Upgrade Trigger: At Craftsmen (Dialogue)" ) return "Fejlesztes: Kezmuveseknel (parbeszed)";
	if ( k == "Craftsman Upgrade Mode" ) return "Kezmuves fejlesztesi mod";
	if ( k == "Upgrade Bagged Inventory Gear" ) return "Hatiizsakban levo felszereles fejlesztese is";
	if ( k == "Upgrade Trigger: Via Field Maintenance Kit" ) return "Fejlesztes: Javitokeszlettel";
	if ( k == "Allow Field Kit on Pristine (100%) Gear" ) return "Javitokeszlet engedelyezese 100%-os allapotnal";
	if ( k == "Upgrade Trigger: On Level-Up (Auto)" ) return "Fejlesztes: Szintlepeskor (automatikus)";
	if ( k == "Upgrade Trigger: On Item Equip" ) return "Fejlesztes: Targy felvetelekor";
	if ( k == "Downscale High-Level Gear to Player Level" ) return "Magas szintu targyak szintre csokkentese";
	if ( k == "Downscale Cost Multiplier (0.0 = Free)" ) return "Szintcsokkentesi koltsegszorzo (0.0 = ingyenes)";
	if ( k == "Payment Currency" ) return "Fizetoeszkoz";
	if ( k == "Required Material for Upgrades" ) return "Szukseges alapanyag";
	if ( k == "Base Crown Cost per Level Difference" ) return "Alap korona koltseg szintkulonbsegenkent";
	if ( k == "Cost Multiplier: Common / Magic" ) return "Koltsegszorzo: Kozonseges / Magikus";
	if ( k == "Cost Multiplier: Relic / Rare" ) return "Koltsegszorzo: Ereklye / Ritka";
	if ( k == "Cost Multiplier: Witcher School" ) return "Koltsegszorzo: Vajak iskola";
	if ( k == "Show On-Screen HUD Notification" ) return "Kepernyo (HUD) ertesitesek megjelenitese";
	if ( k == "Play Craftsman Anvil Sound Effect" ) return "Ullo hangeffekt lejatszasa";
	if ( k == "All Gear (Vanilla and Modded)" ) return "Minden felszereles (alapjatek es modok)";
	if ( k == "Witcher and Relic Gear Only" ) return "Csak vajak es ereklye felszereles";
	if ( k == "Witcher School Gear Only" ) return "Csak vajak iskolai felszereles";
	if ( k == "Manual (One-by-One in Repair Tab)" ) return "Kezi (egyeslevel a javitas fulon)";
	if ( k == "Automatic (All Gear on Dialogue)" ) return "Automatikus (minden a parbeszed soran)";
	if ( k == "Free (Zero Cost)" ) return "Ingyenes (koltsegmentes)";
	if ( k == "Crowns Only" ) return "Csak korona";
	if ( k == "Materials Only" ) return "Csak alapanyag";
	if ( k == "Crowns and Materials" ) return "Korona es alapanyag";
	if ( k == "Tempering Oil / Alchemical" ) return "Edzoolaj / alkimiai alkohol";
	if ( k == "Weapon / Armor Repair Kit" ) return "Fegyver / panceljavito keszlet";
	if ( k == "Dimeritium Ingot" ) return "Dimeritium rud";
	if ( k == "Meteorite Ore" ) return "Meteorit erc";
	if ( k == "Crowns" ) return "Korona";
	if ( k == "Oil" ) return "Olaj";
	if ( k == "Repair Kit" ) return "Javitokeszlet";
	if ( k == "Material" ) return "Alapanyag";
	if ( k == "Normalize Secondary Stats (Restore on Level-Up)" ) return "Másodlagos statisztikák normalizálása (szintlépéskor visszaáll)";
	if ( k == "Upgrade Stash Gear (Player Chest)" ) return "Ládában lévő felszerelés fejlesztése (Játékos ládája)";
	if ( k == "Relic and Modded Gear Only (Exclude Witcher)" ) return "Csak ereklye és mod felszerelés (vaják kizárva)";
	if ( k == "Upgrade Trigger: On Opening Stash Chest" ) return "Fejlesztés: Láda kinyitásakor";
	return "";
}

function ModLevelingGear_GetLoc_AR(k : string) : string
{
	if ( k == "Installed Version" ) return "الإصدار المثبت";
	if ( k == "v1.0.4" ) return "v1.0.4";
	if ( k == "Mods" ) return "التعديلات";
	if ( k == "mods" ) return "التعديلات";
	if ( k == "Mods.LevelingGear" ) return "Leveling Gear";
	if ( k == "LevelingGear" ) return "Leveling Gear";
	if ( k == "mod_leveling_gear" ) return "Leveling Gear";
	if ( k == "Enable Leveling Gear" ) return "تفعيل Leveling Gear";
	if ( k == "Gear Whitelist Scope" ) return "نطاق ترقية العتاد";
	if ( k == "Exclude Aerondight (Native Stacking)" ) return "استثناء سيف إيروندايت (تطوير أصلي)";
	if ( k == "Enable Crossbow Scaling" ) return "تفعيل توسيع نطاق القوس والنشاب";
	if ( k == "Auto-Scale Loot Drops" ) return "تعديل مستوى الغنائم تلقائيا";
	if ( k == "Upgrade Trigger: At Craftsmen" ) return "الترقية: عند الحرفيين";
	if ( k == "Upgrade Trigger: At Craftsmen (Dialogue)" ) return "الترقية: عند الحرفيين (محادثة)";
	if ( k == "Craftsman Upgrade Mode" ) return "وضع الترقية عند الحرفي";
	if ( k == "Upgrade Bagged Inventory Gear" ) return "ترقية عتاد الحقيبة أيضا";
	if ( k == "Upgrade Trigger: Via Field Maintenance Kit" ) return "الترقية: بأدوات الصيانة الميدانية";
	if ( k == "Allow Field Kit on Pristine (100%) Gear" ) return "السماح بالأدوات للعتاد السليم (100%)";
	if ( k == "Upgrade Trigger: On Level-Up (Auto)" ) return "الترقية: عند رفع المستوى (تلقائي)";
	if ( k == "Upgrade Trigger: On Item Equip" ) return "الترقية: عند تجهيز العتاد";
	if ( k == "Downscale High-Level Gear to Player Level" ) return "تخفيض عتاد المستوى العالي لمستوى اللاعب";
	if ( k == "Downscale Cost Multiplier (0.0 = Free)" ) return "مضاعف تكلفة التخفيض (0.0 = مجاني)";
	if ( k == "Payment Currency" ) return "عملة الدفع";
	if ( k == "Required Material for Upgrades" ) return "المادة المطلوبة للترقية";
	if ( k == "Base Crown Cost per Level Difference" ) return "التكلفة الأساسية بالتيجان لكل فرق مستوى";
	if ( k == "Cost Multiplier: Common / Magic" ) return "مضاعف التكلفة: شائع / سحري";
	if ( k == "Cost Multiplier: Relic / Rare" ) return "مضاعف التكلفة: أثري / نادر";
	if ( k == "Cost Multiplier: Witcher School" ) return "مضاعف التكلفة: مدارس الويتشر";
	if ( k == "Show On-Screen HUD Notification" ) return "إظهار الإشعارات على الشاشة";
	if ( k == "Play Craftsman Anvil Sound Effect" ) return "تشغيل صوت سندان الحداد";
	if ( k == "All Gear (Vanilla and Modded)" ) return "كل العتاد (الأصلي والمعدل)";
	if ( k == "Witcher and Relic Gear Only" ) return "عتاد الويتشر والآثار فقط";
	if ( k == "Witcher School Gear Only" ) return "عتاد مدارس الويتشر فقط";
	if ( k == "Manual (One-by-One in Repair Tab)" ) return "يدوي (قطعة قطعة في تبويب الإصلاح)";
	if ( k == "Automatic (All Gear on Dialogue)" ) return "تلقائي (الكل عند المحادثة)";
	if ( k == "Free (Zero Cost)" ) return "مجاني (دون تكلفة)";
	if ( k == "Crowns Only" ) return "تيجان فقط";
	if ( k == "Materials Only" ) return "مواد فقط";
	if ( k == "Crowns and Materials" ) return "تيجان ومواد";
	if ( k == "Tempering Oil / Alchemical" ) return "زيت التصليد / كحول كيميائي";
	if ( k == "Weapon / Armor Repair Kit" ) return "عدة إصلاح الأسلحة / الدروع";
	if ( k == "Dimeritium Ingot" ) return "سبيكة الديميريتيوم";
	if ( k == "Meteorite Ore" ) return "خام النيزك";
	if ( k == "Crowns" ) return "تيجان";
	if ( k == "Oil" ) return "زيت";
	if ( k == "Repair Kit" ) return "عدة إصلاح";
	if ( k == "Material" ) return "مادة";
	if ( k == "Normalize Secondary Stats (Restore on Level-Up)" ) return "موازنة الإحصائيات الثانوية (استعادة مع زيادة المستوى)";
	if ( k == "Upgrade Stash Gear (Player Chest)" ) return "ترقية عتاد الصندوق (صندوق اللاعب)";
	if ( k == "Relic and Modded Gear Only (Exclude Witcher)" ) return "عتاد الآثار والمودات فقط (استثناء الويتشر)";
	if ( k == "Upgrade Trigger: On Opening Stash Chest" ) return "ترقية: عند فتح الصندوق";
	return "";
}

function ModLevelingGear_GetLoc_UA(k : string) : string
{
	if ( k == "Preset" ) return "Набір налаштувань";
	if ( k == "Khser's Choice" ) return "Вибір Khser";
	if ( k == "Story (Free)" ) return "Сюжет (безкоштовно)";
	if ( k == "Hardcore" ) return "Хардкор";
	if ( k == "Purist" ) return "Пурист";
	if ( k == "Mods" ) return "Моди";
	if ( k == "mods" ) return "Моди";
	if ( k == "Mods.LevelingGear" ) return "Спорядження за рівнем";
	if ( k == "LevelingGear" ) return "Спорядження за рівнем";
	if ( k == "mod_leveling_gear" ) return "Спорядження за рівнем";
	if ( k == "Leveling Gear" ) return "Спорядження за рівнем";
	if ( k == "Installed Version" ) return "Встановлена версія";
	if ( k == "v1.0.16" ) return "v1.0.16";
	if ( k == "v1.0.15" ) return "v1.0.15";
	if ( k == "v1.0.14" ) return "v1.0.14";
	if ( k == "v1.0.13" ) return "v1.0.13";
	if ( k == "v1.0.13b" ) return "v1.0.13b";
	if ( k == "v1.0.12" ) return "v1.0.12";
	if ( k == "v1.0.11" ) return "v1.0.11";
	if ( k == "v1.0.5" ) return "v1.0.5";
	if ( k == "v1.0.4" ) return "v1.0.4";
	if ( k == "Enable Leveling Gear" ) return "Увімкнути спорядження за рівнем";
	if ( k == "Gear Whitelist Scope" ) return "Спорядження для покращення";
	if ( k == "Exclude Aerondight (Native Stacking)" ) return "Виключити Аерондіт (вбудоване підсилення)";
	if ( k == "Enable Crossbow Scaling" ) return "Підлаштовувати арбалети під рівень";
	if ( k == "Auto-Scale Loot Drops" ) return "Автоматично підлаштовувати здобич під рівень";
	if ( k == "Upgrade Trigger: At Craftsmen" ) return "Покращення: у ремісників";
	if ( k == "Upgrade Trigger: At Craftsmen (Dialogue)" ) return "Покращення: у ремісників (діалог)";
	if ( k == "Craftsman Upgrade Mode" ) return "Режим покращення у ремісників";
	if ( k == "Craftsman Durability Repair Action" ) return "Ремонт міцності у ремісника";
	if ( k == "Durability Repair Only (No Leveling)" ) return "Лише ремонт міцності (без підвищення рівня)";
	if ( k == "Repair + Level Tempering (Combined)" ) return "Ремонт + підвищення рівня (разом)";
	if ( k == "Temper Only When Pristine (100% Durability)" ) return "Підвищувати рівень лише за 100% міцності";
	if ( k == "Upgrade Bagged Inventory Gear" ) return "Покращувати спорядження в інвентарі";
	if ( k == "Upgrade Trigger: Via Field Maintenance Kit" ) return "Покращення: за допомогою польового набору";
	if ( k == "Allow Field Kit on Pristine (100%) Gear" ) return "Дозволити польовий набір для спорядження зі 100% міцністю";
	if ( k == "Upgrade Trigger: On Level-Up (Auto)" ) return "Покращення: при підвищенні рівня (авто)";
	if ( k == "Upgrade Trigger: On Item Equip" ) return "Покращення: при екіпіруванні";
	if ( k == "Downscale High-Level Gear to Player Level" ) return "Знижувати рівень спорядження до рівня гравця";
	if ( k == "Downscale Cost Multiplier (0.0 = Free)" ) return "Множник вартості зниження рівня (0.0 = безкоштовно)";
	if ( k == "Payment Currency" ) return "Валюта оплати";
	if ( k == "Required Material for Upgrades" ) return "Необхідний матеріал для покращення";
	if ( k == "Base Crown Cost per Level Difference" ) return "Базова вартість у кронах за різницю в рівні";
	if ( k == "Cost Multiplier: Common / Magic" ) return "Множник вартості: звичайне / магічне";
	if ( k == "Cost Multiplier: Relic / Rare" ) return "Множник вартості: реліктове / рідкісне";
	if ( k == "Cost Multiplier: Witcher School" ) return "Множник вартості: спорядження відьмачих шкіл";
	if ( k == "Show On-Screen HUD Notification" ) return "Показувати HUD-сповіщення на екрані";
	if ( k == "Play Craftsman Anvil Sound Effect" ) return "Відтворювати звук ковадла ремісника";
	if ( k == "All Gear (Vanilla and Modded)" ) return "Усе спорядження (оригінальне та з модів)";
	if ( k == "Witcher and Relic Gear Only" ) return "Лише відьмаче та реліктове спорядження";
	if ( k == "Witcher School Gear Only" ) return "Лише спорядження відьмачих шкіл";
	if ( k == "Manual (One-by-One in Repair Tab)" ) return "Вручну (по одному у вкладці ремонту)";
	if ( k == "Automatic (All Gear on Dialogue)" ) return "Автоматично (усе спорядження під час діалогу)";
	if ( k == "Free (Zero Cost)" ) return "Безкоштовно (без витрат)";
	if ( k == "Crowns Only" ) return "Лише крони";
	if ( k == "Materials Only" ) return "Лише матеріали";
	if ( k == "Crowns and Materials" ) return "Крони та матеріали";
	if ( k == "Tempering Oil / Alchemical" ) return "Олія для покращення / алхімічний матеріал";
	if ( k == "Weapon / Armor Repair Kit" ) return "Набір для ремонту зброї / обладунків";
	if ( k == "Dimeritium Ingot" ) return "Злиток двимериту";
	if ( k == "Meteorite Ore" ) return "Метеоритна руда";
	if ( k == "Crowns" ) return "Крони";
	if ( k == "Oil" ) return "Олія";
	if ( k == "Repair Kit" ) return "Набір для ремонту";
	if ( k == "Material" ) return "Матеріал";
	if ( k == "Normalize Secondary Stats (Restore on Level-Up)" ) return "Нормалізувати додаткові характеристики (відновлювати при підвищенні рівня)";
	if ( k == "Upgrade Stash Gear (Player Chest)" ) return "Покращувати спорядження в скрині (Схованка)";
	if ( k == "Relic and Modded Gear Only (Exclude Witcher)" ) return "Тільки реліктові та модифікації (без відьмацького)";
	if ( k == "Upgrade Trigger: On Opening Stash Chest" ) return "Покращення: при відкритті скрині";
	return "";
}

function ModLevelingGear_GetLoc_ZH(k : string) : string
{
	return ModLevelingGear_GetLoc_ZHCN(k);
}

function ModLevelingGear_GetLocalizedString(key : string) : string
{
	var audioLang, textLang : string;
	var lang : string;
	var k : string;
	var res : string;

	k = ModLevelingGear_NormalizeKey(key);
	if ( k == "v1.0.23" || k == "v1.0.22" || k == "v1.0.21" || k == "v1.0.20" || k == "v1.0.19" || k == "v1.0.18" || k == "v1.0.17" || k == "v1.0.16" || k == "v1.0.15" || k == "v1.0.14" || k == "v1.0.13" || k == "v1.0.13b" || k == "v1.0.12" || k == "v1.0.11" || k == "v1.0.10b" || k == "v1.0.7b" || k == "v1.0.7" || k == "v1.0.6" || k == "v1.0.5" || k == "v1.0.4" )
	{
		return "v1.0.23";
	}
	theGame.GetGameLanguageName(audioLang, textLang);
	lang = StrUpper(textLang);

	if ( lang == "TR" || StrBeginsWith(lang, "TUR") || StrBeginsWith(lang, "TR") ) res = ModLevelingGear_GetLoc_TR(k);
	else if ( lang == "RU" || StrBeginsWith(lang, "RUS") || StrBeginsWith(lang, "RU") ) res = ModLevelingGear_GetLoc_RU(k);
	else if ( lang == "PL" || StrBeginsWith(lang, "POL") || StrBeginsWith(lang, "PL") ) res = ModLevelingGear_GetLoc_PL(k);
	else if ( lang == "DE" || StrBeginsWith(lang, "GER") || StrBeginsWith(lang, "DE") ) res = ModLevelingGear_GetLoc_DE(k);
	else if ( lang == "FR" || StrBeginsWith(lang, "FRE") || StrBeginsWith(lang, "FR") ) res = ModLevelingGear_GetLoc_FR(k);
	else if ( lang == "ES" || StrBeginsWith(lang, "SPA") || StrBeginsWith(lang, "ES") ) res = ModLevelingGear_GetLoc_ES(k);
	else if ( lang == "ESMX" || StrBeginsWith(lang, "ES-MX") || StrBeginsWith(lang, "ES_MX") ) res = ModLevelingGear_GetLoc_ESMX(k);
	else if ( lang == "IT" || StrBeginsWith(lang, "ITA") || StrBeginsWith(lang, "IT") ) res = ModLevelingGear_GetLoc_IT(k);
	else if ( lang == "BR" || lang == "PT" || StrBeginsWith(lang, "POR") || StrBeginsWith(lang, "PT") || StrBeginsWith(lang, "BR") ) res = ModLevelingGear_GetLoc_BR(k);
	else if ( lang == "TW" || lang == "ZHT" || lang == "CHT" || lang == "ZHTW" || StrBeginsWith(lang, "ZH-TW") || StrBeginsWith(lang, "ZH_TW") || StrBeginsWith(lang, "ZH-HK") || StrBeginsWith(lang, "ZH_HK") || StrContains(lang, "TCHIN") || StrContains(lang, "HANT") ) res = ModLevelingGear_GetLoc_ZHTW(k);
	else if ( lang == "ZH" || lang == "CN" || StrBeginsWith(lang, "CN") || lang == "ZHS" || lang == "CHS" || lang == "ZHCN" || StrBeginsWith(lang, "ZH-CN") || StrBeginsWith(lang, "ZH_CN") || StrContains(lang, "CHIN") || StrContains(lang, "SCHIN") || StrContains(lang, "HANS") ) res = ModLevelingGear_GetLoc_ZHCN(k);
	else if ( lang == "JP" || StrBeginsWith(lang, "JAP") || StrBeginsWith(lang, "JA") || StrBeginsWith(lang, "JP") ) res = ModLevelingGear_GetLoc_JP(k);
	else if ( lang == "KR" || StrBeginsWith(lang, "KOR") || StrBeginsWith(lang, "KO") || StrBeginsWith(lang, "KR") ) res = ModLevelingGear_GetLoc_KR(k);
	else if ( lang == "CZ" || StrBeginsWith(lang, "CZE") || StrBeginsWith(lang, "CS") || StrBeginsWith(lang, "CZ") ) res = ModLevelingGear_GetLoc_CZ(k);
	else if ( lang == "HU" || StrBeginsWith(lang, "HUN") || StrBeginsWith(lang, "HU") ) res = ModLevelingGear_GetLoc_HU(k);
	else if ( lang == "AR" || StrBeginsWith(lang, "ARA") || StrBeginsWith(lang, "AR") ) res = ModLevelingGear_GetLoc_AR(k);
	else if ( lang == "UA" || lang == "UK" || StrBeginsWith(lang, "UKR") || StrBeginsWith(lang, "UA") || StrBeginsWith(lang, "UK") ) res = ModLevelingGear_GetLoc_UA(k);

	// Chinese dialect cross-fallbacks
	if ( (lang == "TW" || lang == "ZHT" || lang == "CHT" || lang == "ZHTW" || StrBeginsWith(lang, "ZH-TW") || StrBeginsWith(lang, "ZH_TW") || StrBeginsWith(lang, "ZH-HK") || StrBeginsWith(lang, "ZH_HK") || StrContains(lang, "TCHIN") || StrContains(lang, "HANT")) && res == "" )
	{
		res = ModLevelingGear_GetLoc_ZHCN(k);
	}
	else if ( (lang == "ZH" || lang == "CN" || StrBeginsWith(lang, "CN") || lang == "ZHS" || lang == "CHS" || lang == "ZHCN" || StrBeginsWith(lang, "ZH-CN") || StrBeginsWith(lang, "ZH_CN") || StrContains(lang, "CHIN") || StrContains(lang, "SCHIN") || StrContains(lang, "HANS")) && res == "" )
	{
		res = ModLevelingGear_GetLoc_ZHTW(k);
	}

	// English fallback
	if ( res == "" )
	{
		res = ModLevelingGear_GetLoc_EN(k);
	}

	return res;
}

function ModLevelingGear_GetLoc(k : string) : string
{
	return ModLevelingGear_GetLocalizedString(k);
}

