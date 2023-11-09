function LevelUpEquipped()
{
	var witcher : W3PlayerWitcher;
	var inventory : CInventoryComponent;
	var item : SItemUniqueId;
	var playerLevel, itemLevel, levelDiff, i, k : int;
	var slots : array<EEquipmentSlots>;
	
	witcher = GetWitcherPlayer();
	
	if( !witcher )
		return;
	
	inventory = witcher.inv;
	playerLevel = witcher.GetLevel();
	
	slots.PushBack(EES_SteelSword);
	slots.PushBack(EES_SilverSword);
	slots.PushBack(EES_Armor);
	slots.PushBack(EES_Gloves);
	slots.PushBack(EES_Pants);
	slots.PushBack(EES_Boots);
	
	for( k = 0; k < slots.Size(); k += 1 )
	{
		if( inventory.GetItemEquippedOnSlot(slots[k], item) )
		{
			itemLevel = inventory.GetItemLevel(item);
			levelDiff = playerLevel - itemLevel;
			for( i = 0; i < levelDiff; i += 1 )
			{
				LevelUpItem(item, inventory);
			}
		}
	}
}

function LevelUpItem(item : SItemUniqueId, inventory : CInventoryComponent)
{
	var dmgBoost : float;
	if( inventory.ItemHasTag( item, 'PlayerSteelWeapon' ) ) 
	{
		inventory.AddItemCraftedAbility(item, 'autogen_fixed_steel_dmg', true ); 
	}
	else if( inventory.ItemHasTag( item, 'PlayerSilverWeapon' ) ) 
	{
		inventory.AddItemCraftedAbility(item, 'autogen_fixed_silver_dmg', true ); 
	}
	else if( inventory.GetItemCategory( item ) == 'armor' )
	{
		inventory.AddItemCraftedAbility(item, 'autogen_fixed_armor_armor', true );		
	}
	else if( inventory.GetItemCategory( item ) == 'boots' || inventory.GetItemCategory( item ) == 'pants' )
	{
		inventory.AddItemCraftedAbility(item, 'autogen_fixed_pants_armor', true ); 
	}
	else if( inventory.GetItemCategory( item ) == 'gloves' )
	{
		inventory.AddItemCraftedAbility(item, 'autogen_fixed_gloves_armor', true );
	}
	if( inventory.ItemHasTag( item, 'Aerondight' ) )
	{
		dmgBoost = inventory.GetItemModifierFloat( item, 'PermDamageBoost' );
		if( dmgBoost > 10 )
			inventory.SetItemModifierFloat( item, 'PermDamageBoost', dmgBoost - 10 );
	}
}
