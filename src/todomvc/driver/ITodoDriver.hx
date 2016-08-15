package todomvc.driver;

import hex.mdvc.driver.IInputOwner;
import todomvc.view.ITodoView;

/**
 * @author Francis Bourre
 */
interface ITodoDriver extends IInputOwner
{
	var view : ITodoView;
}