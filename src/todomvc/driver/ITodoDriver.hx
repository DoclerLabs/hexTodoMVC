package todomvc.driver;

import hex.mdvc.driver.IInput;
import hex.mdvc.driver.IInputOwner;
import todomvc.model.ITodoConnection;

/**
 * @author Francis Bourre
 */
interface ITodoDriver extends ITodoConnection extends IInputOwner
{
	var input : IInput<ITodoConnection>;
}