package todomvc.model;

import common.Filter;
import common.IFilterConnection;
import hex.mdvc.model.IOutput;
import hex.mdvc.model.IOutputOwner;

/**
 * ...
 * @author Francis Bourre
 */
interface IFilterModel extends IOutputOwner
{
	var output( default, never ) : IOutput<IFilterConnection>;
	
	function setFilter( filter : Filter ) : Void;
	
	function getFilter() : Filter;
}