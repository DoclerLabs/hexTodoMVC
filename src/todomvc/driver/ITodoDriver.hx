package todomvc.driver;

import common.IFilterConnection;
import common.ITodoConnection;
import hex.di.IInjectorContainer;
import hex.mdvc.driver.IForwarder;
import hex.mdvc.driver.IInputOwner;
import todomvc.view.ITodoView;

/**
 * @author Francis Bourre
 */
interface ITodoDriver extends IFilterConnection extends ITodoConnection extends IInputOwner extends IForwarder extends IInjectorContainer
{
	var view : ITodoView;
}