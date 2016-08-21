package todomvc.model;

import common.Filter;
import common.IFilterConnection;
import hex.di.IInjectorContainer;
import hex.mdvc.log.IsLoggable;
import hex.mdvc.model.IOutput;
import hex.mdvc.model.IOutputOwner;

/**
 * ...
 * @author Francis Bourre
 */
@:keepSub
interface IFilterModel extends IOutputOwner extends IInjectorContainer extends IsLoggable
{
	var output( default, never ) : IOutput<IFilterConnection>;
	
	function setFilter( filter : Filter ) : Void;
}