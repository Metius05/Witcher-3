//Minimap zoom module

// Magic mapType: MMZ_Exterior = 0; MMZ_Interior = 1; MMZ_Boat = 2; MMZ_Horse = 3;

function MINIMAP_EXTERIOR_ZOOM() : float
{
	return 1.0f;
}

function MINIMAP_INTERIOR_ZOOM() : float
{
	return 2.0f;
}

function MINIMAP_BOAT_ZOOM() : float
{
	return 0.5f;
}

////////////////////////////////////////////////////////////////////////////////

function MMZ_GetStepMinimapSize() : float
{
	var inGameConfigWrapper : CInGameConfigWrapper;
	var minimap_step : float;

	inGameConfigWrapper = theGame.GetInGameConfigWrapper();
	minimap_step = StringToFloat(inGameConfigWrapper.GetVarValue('MinimapZoom', 'minimap_step'));
	if(minimap_step < 0.01f)
	{
		inGameConfigWrapper.SetVarValue('MinimapZoom', 'minimap_step', 5.0f);
		return 5.0f;
	}
	else 
		return minimap_step;
}


function MMZ_Inc()
{
	var size : float;
	var hud : CR4ScriptedHud;
	var inGameConfigWrapper : CInGameConfigWrapper;

	inGameConfigWrapper = theGame.GetInGameConfigWrapper();
	hud = (CR4ScriptedHud)theGame.GetHud();

	if ( hud )
	{
		switch(MMZ_GetMinimapType())
		{
			case 0:
				size = MMZ_ModifyAndCheckBounds(MMZ_GetExteriorMinimapSize(), 0.0f - MMZ_GetStepMinimapSize());
				inGameConfigWrapper.SetVarValue('MinimapZoom', 'exterior_minimap_size', size);
				hud.SetMinimapZoom( MINIMAP_EXTERIOR_ZOOM() * 100.0f / size );
				break;

			case 1:
				size = MMZ_ModifyAndCheckBounds(MMZ_GetInteriorMinimapSize(), 0.0f - MMZ_GetStepMinimapSize());
				inGameConfigWrapper.SetVarValue('MinimapZoom', 'interior_minimap_size', size);
				hud.SetMinimapZoom( MINIMAP_INTERIOR_ZOOM() * 100.0f / size );
				break;

			case 2:
				size = MMZ_ModifyAndCheckBounds(MMZ_GetBoatMinimapSize(), 0.0f - MMZ_GetStepMinimapSize());
				inGameConfigWrapper.SetVarValue('MinimapZoom', 'boat_minimap_size', size);
				hud.SetMinimapZoom( MINIMAP_BOAT_ZOOM() * 100.0f / size );
				break;

			case 3:
				size = MMZ_ModifyAndCheckBounds(MMZ_GetHorseMinimapSize(), 0.0f - MMZ_GetStepMinimapSize());
				inGameConfigWrapper.SetVarValue('MinimapZoom', 'horse_minimap_size', size);
				hud.SetMinimapZoom( MINIMAP_EXTERIOR_ZOOM() * 100.0f / size );
				break;
		}
	}
}


function MMZ_Dec()
{
	var mapType : int;
	var size : float;
	var hud : CR4ScriptedHud;
	var inGameConfigWrapper : CInGameConfigWrapper;

	inGameConfigWrapper = theGame.GetInGameConfigWrapper();
	hud = (CR4ScriptedHud)theGame.GetHud();

	if ( hud )
	{
		switch(MMZ_GetMinimapType())
		{
			case 0:
				size = MMZ_ModifyAndCheckBounds(MMZ_GetExteriorMinimapSize(), MMZ_GetStepMinimapSize());
				inGameConfigWrapper.SetVarValue('MinimapZoom', 'exterior_minimap_size', size);
				hud.SetMinimapZoom( MINIMAP_EXTERIOR_ZOOM() * 100.0f / size );
				break;

			case 1:
				size = MMZ_ModifyAndCheckBounds(MMZ_GetInteriorMinimapSize(), MMZ_GetStepMinimapSize());
				inGameConfigWrapper.SetVarValue('MinimapZoom', 'interior_minimap_size', size);
				hud.SetMinimapZoom( MINIMAP_INTERIOR_ZOOM() * 100.0f / size );
				break;

			case 2:
				size = MMZ_ModifyAndCheckBounds(MMZ_GetBoatMinimapSize(), MMZ_GetStepMinimapSize());
				inGameConfigWrapper.SetVarValue('MinimapZoom', 'boat_minimap_size', size);
				hud.SetMinimapZoom( MINIMAP_BOAT_ZOOM() * 100.0f / size );
				break;

			case 3:
				size = MMZ_ModifyAndCheckBounds(MMZ_GetHorseMinimapSize(), MMZ_GetStepMinimapSize());
				inGameConfigWrapper.SetVarValue('MinimapZoom', 'horse_minimap_size', size);
				hud.SetMinimapZoom( MINIMAP_EXTERIOR_ZOOM() * 100.0f / size );
				break;
		}
	}
}


function MMZ_ModifyAndCheckBounds(value: float, param: float) : float
{
	value += param;
	if (value > 400.0f) 
		value = 400.0f;
	else if (value < 50.0f) 
		value = 50.0f;
	return value;
}

function MMZ_GetMinimapType() : int
{
	var inGameConfigWrapper : CInGameConfigWrapper;
	inGameConfigWrapper = theGame.GetInGameConfigWrapper();

	if (thePlayer.IsInInterior())
		return 1;
	else if (thePlayer.IsUsingHorse())
		return 3;
	else if (thePlayer.IsSailing())
		return 2;
	else
		return 0;
}

 
function MMZ_GetExteriorMinimapSize() : float 
{
	var inGameConfigWrapper : CInGameConfigWrapper;
	var exterior_minimap_size : float;
	
	inGameConfigWrapper = theGame.GetInGameConfigWrapper();
	exterior_minimap_size = StringToFloat(inGameConfigWrapper.GetVarValue('MinimapZoom', 'exterior_minimap_size'));
	if(exterior_minimap_size < 0.01f)
	{
		inGameConfigWrapper.SetVarValue('MinimapZoom', 'exterior_minimap_size', 150.0f);
		return 150.0f;
	}
	else 
		return exterior_minimap_size;
}


function MMZ_GetExteriorMinimapZoom() : float 
{
	return MINIMAP_EXTERIOR_ZOOM() * 100.0f / MMZ_GetExteriorMinimapSize();
}


function MMZ_GetHorseMinimapSize() : float 
{
	var inGameConfigWrapper : CInGameConfigWrapper;
	var horse_minimap_size : float;

	inGameConfigWrapper = theGame.GetInGameConfigWrapper();
	horse_minimap_size = StringToFloat(inGameConfigWrapper.GetVarValue('MinimapZoom', 'horse_minimap_size'));
	if(horse_minimap_size < 0.01f)
	{
		inGameConfigWrapper.SetVarValue('MinimapZoom', 'horse_minimap_size', 225.0f);
		return 225.0f;
	}
	else 
		return horse_minimap_size;
}


function MMZ_GetHorseMinimapZoom() : float 
{
	return MINIMAP_EXTERIOR_ZOOM() * 100.0f / MMZ_GetHorseMinimapSize();
}


function MMZ_GetInteriorMinimapSize() : float 
{
	var inGameConfigWrapper : CInGameConfigWrapper;
	var interior_minimap_size : float;

	inGameConfigWrapper = theGame.GetInGameConfigWrapper();
	interior_minimap_size = StringToFloat(inGameConfigWrapper.GetVarValue('MinimapZoom', 'interior_minimap_size'));
	if(interior_minimap_size < 0.01f)
	{
		inGameConfigWrapper.SetVarValue('MinimapZoom', 'interior_minimap_size', 125.0f);
		return 125.0f;
	}
	else 
		return interior_minimap_size;
}


function MMZ_GetInteriorMinimapZoom() : float 
{
	return MINIMAP_INTERIOR_ZOOM() * 100.0f / MMZ_GetInteriorMinimapSize();
}


function MMZ_GetBoatMinimapSize() : float 
{
	var inGameConfigWrapper : CInGameConfigWrapper;
	var boat_minimap_size : float;

	inGameConfigWrapper = theGame.GetInGameConfigWrapper();
	boat_minimap_size = StringToFloat(inGameConfigWrapper.GetVarValue('MinimapZoom', 'boat_minimap_size'));
	if(boat_minimap_size < 0.01f)
	{
		inGameConfigWrapper.SetVarValue('MinimapZoom', 'boat_minimap_size', 125.0f);
		return 125.0f;
	}
	else 
		return boat_minimap_size;
}


function MMZ_GetBoatMinimapZoom() : float 
{
	return MINIMAP_BOAT_ZOOM() * 100.0f / MMZ_GetBoatMinimapSize();
}

