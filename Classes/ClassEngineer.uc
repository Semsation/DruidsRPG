class ClassEngineer extends RPGClass
	config(UT2004RPG)
	abstract;

static simulated function ModifyPawn(Pawn Other, int AbilityLevel)
{
	local RPGStatsInv StatsInv;
	local int y;
	local int RegenLevel;
	local int RegenIndex;

	RegenIndex = -1;
	class'ClassWeaponsMaster'.static.ModifyPawn(other, AbilityLevel); //give them the health regen.
	
	StatsInv = RPGStatsInv(Other.FindInventoryType(class'RPGStatsInv'));
 	if (StatsInv != None && StatsInv.DataObject != None && StatsInv.DataObject.Level <= default.MediumLevel)
 	{
 		for (y = 0; y < StatsInv.Data.Abilities.length; y++)
 		{
 			if (ClassIsChildOf(StatsInv.Data.Abilities[y], class'DruidArmorRegen'))
 			{
 				RegenLevel = StatsInv.Data.AbilityLevels[y];
 				RegenIndex = y;
 			}
 		}

		if(StatsInv.DataObject.Level <= default.LowLevel)
		{
			if(RegenIndex >= 0)
				StatsInv.Data.Abilities[RegenIndex].static.ModifyPawn(Other, RegenLevel + 2);
			else
				class'DruidArmorRegen'.static.ModifyPawn(Other, RegenLevel + 2);
		}
		else if(StatsInv.DataObject.Level <= default.MediumLevel)
		{
			if(RegenIndex >= 0)
				StatsInv.Data.Abilities[RegenIndex].static.ModifyPawn(Other, RegenLevel + 1);
			else
				class'DruidArmorRegen'.static.ModifyPawn(Other, RegenLevel + 1);
		}
 	}
}

defaultproperties
{
	AbilityName="Class: Engineer"
	Description="This class is the prerequisite for all engineer related abilities.|You can not be more than one class at any time."
	BotChance=1
}