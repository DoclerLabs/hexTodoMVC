package todomvc.model;

import common.Filter;
import common.IFilterConnection;
import hex.di.IInjectorContainer;
import hex.log.IsLoggable;
import hex.event.ITrigger;
import hex.event.ITriggerOwner;

/**
 * ...
 * @author Francis Bourre
 */
@:keepSub
interface IFilterModel extends ITriggerOwner extends IInjectorContainer extends IsLoggable
{
	var output( default, never ) : ITrigger<IFilterConnection>;
	
	function setFilter( filter : Filter ) : Void;
}