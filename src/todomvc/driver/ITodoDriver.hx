package todomvc.driver;

import common.ITodoConnection;
import hex.mdvc.driver.IForwarder;
import hex.mdvc.driver.IInputOwner;
import common.IFilterConnection;
import todomvc.view.ITodoView;

/**
 * @author Francis Bourre
 */
interface ITodoDriver extends IFilterConnection extends ITodoConnection extends IInputOwner extends IForwarder
{
	var view : ITodoView;
}