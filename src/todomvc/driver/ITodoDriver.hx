package todomvc.driver;

import hex.mdvc.driver.IInput;
import hex.mdvc.driver.IInputOwner;
import todomvc.view.ITodoView;

/**
 * @author Francis Bourre
 */
interface ITodoDriver extends ITodoView extends IInputOwner
{
	var input : IInput<ITodoView>;
}