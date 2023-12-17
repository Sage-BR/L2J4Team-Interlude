package net.sf.l2j.gameserver.handler.usercommandhandlers;

import java.math.BigDecimal;

import net.sf.l2j.Config;
import net.sf.l2j.gameserver.handler.IUserCommandHandler;
import net.sf.l2j.gameserver.model.actor.Player;

/**
 * @author Williams
 *
 */
public class ChangeTime implements IUserCommandHandler
{
	private static final int[] COMMAND_IDS =
	{
		120,121
	};
	
	@Override
	public void useUserCommand(int id, Player activeChar)
	{
		int _calcule = (int) arredondaValor(1, activeChar.getOnlineTime() / 3600);

		if (id == 120)
		{
			if ((_calcule >= 1) && (activeChar.getPvpKills() >= Config.MIN_PVP))
			{
				activeChar.addItem("Coins", Config.ID_REWARD, _calcule, activeChar, true);
				activeChar.setOnlineTime(0);
			}
			else
			{
				if (activeChar.getPvpKills() < Config.MIN_PVP)
					activeChar.sendMessage("You Need "+ Config.MIN_PVP +" PvP to proceed with the exchange. You just have to " + activeChar.getPvpKills() + " PvP'S");
				
				if (_calcule < 1)
					activeChar.sendMessage("You don't have 1 hour online right now.");
			}
		}
		else if(id == 121)
		{
			if (_calcule >= 1) 
				activeChar.sendMessage("You currently have "+ _calcule +" online hours.");
			else  if (_calcule < 1)
				activeChar.sendMessage("You currently have " + activeChar.getOnlineTime() / 60 + " Online Minutes.");
		}
		
		return;
	}


	@SuppressWarnings("deprecation")
	public double arredondaValor(int casasDecimais, double valor)
	{
		return new BigDecimal(valor).setScale(casasDecimais, 3).doubleValue();
	}
	
	@Override
	public int[] getUserCommandList()
	{
		return COMMAND_IDS;
	}
}