package net.sf.l2j.gameserver.handler.admincommandhandlers;

import java.util.StringTokenizer;
import java.util.concurrent.TimeUnit;

import net.sf.l2j.Config;
import net.sf.l2j.gameserver.handler.IAdminCommandHandler;
import net.sf.l2j.gameserver.model.World;
import net.sf.l2j.gameserver.model.actor.Player;
import net.sf.l2j.gameserver.model.holder.IntIntHolder;
import net.sf.l2j.gameserver.taskmanager.AioTaskManager;

/**
 * @author Williams
 *
 */
public class AdminAio implements IAdminCommandHandler
{
	private static String[] _adminCommands =
	{
		"admin_setaio",
		"admin_removeaio"
	};
	
	@Override
	public boolean useAdminCommand(String command, Player activeChar)
	{
		StringTokenizer st = new StringTokenizer(command);
		st.nextToken();
		String player = "";
		int duration = 0;
		Player target = null;
		
		// One parameter, player name
		if (st.hasMoreTokens())
		{
			player = st.nextToken();
			target = World.getInstance().getPlayer(player);
			
			// Second parameter, duration
			if (st.hasMoreTokens())
			{
				try
				{
					duration = Integer.parseInt(st.nextToken());
				}
				catch (NumberFormatException nfe)
				{
					activeChar.sendMessage("Invalid number format used: " + nfe);
					return false;
				}
			}
		}
		else
		{
			// If there is no name, select target
			if (activeChar.getTarget() != null && activeChar.getTarget() instanceof Player)
				target = (Player) activeChar.getTarget();
		}
		
		if (command.startsWith("admin_setaio"))
		{
			if (target == null && player.equals(""))
			{
				activeChar.sendMessage("Usage: //setaio <char_name> [duration_days]");
				return false;
			}
			
			if (target != null)
				doAio(target, duration);
		}
		else if (command.startsWith("admin_removeaio"))
		{
			if (target == null && player.equals(""))
			{
				activeChar.sendMessage("Usage: //removeaio <char_name>");
				return false;
			}
			
			if (target != null)
			{
				if (target.isAio())
			{
					target.setAio(false);
					activeChar.sendMessage(target.getName() + "Your Aio has been removed.");
				}
				else
					activeChar.sendMessage(target.getName() + " It's not Aio.");
			}
		}
		return true;
	}
	
	public static void doAio(Player target, int time)
	{
		target.setAio(true);
		AioTaskManager.getInstance().add(target);
		
		long remainingTime = target.getMemos().getLong("aioTime", 0);
		if (remainingTime > 0)
		{
			target.getMemos().set("aioTime", remainingTime + TimeUnit.DAYS.toMillis(time));
			target.sendMessage(target.getName() + " Your Aio has been extended by " + time + " dias(s).");
		}
		else
		{
			target.getMemos().set("aioTime", System.currentTimeMillis() + TimeUnit.DAYS.toMillis(time));
			target.sendMessage(target.getName() + " Now you are Aio, your duration is " + time + " dia(s).");
			
			for (IntIntHolder item : Config.LIST_AIO_ITEMS)
			{
				if (item.getId() > 0)
				{
					target.addItem("Add", item.getId(), item.getValue(), target, true);
					target.getInventory().equipItemAndRecord(target.getInventory().getItemByItemId(item.getId()));
				}
			}
		}
	}
	
	@Override
	public String[] getAdminCommandList()
	{
		return _adminCommands;
	}
}