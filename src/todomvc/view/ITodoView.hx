package todomvc.view;

import common.IFilterConnection;
import common.ITodoConnection;
import hex.di.IInjectorContainer;
import hex.log.IsLoggable;

/**
 * @author Francis Bourre
 */
@:keepSub
interface ITodoView 
	extends IFilterConnection extends ITodoConnection
	extends IsLoggable extends IInjectorContainer
{}