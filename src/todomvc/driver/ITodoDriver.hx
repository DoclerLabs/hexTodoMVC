package todomvc.driver;

import hex.mdvc.driver.IInputOwner;
import common.IFilterConnection;
import todomvc.view.ITodoView;

/**
 * @author Francis Bourre
 */
interface ITodoDriver extends IFilterConnection extends IInputOwner
{
	var view : ITodoView;
}