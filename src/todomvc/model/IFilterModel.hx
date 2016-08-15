package todomvc.model;

import hex.mdvc.model.IOutput;
import hex.mdvc.model.IOutputOwner;

/**
 * ...
 * @author Francis Bourre
 */
interface IFilterModel extends IOutputOwner
{
	var output( default, never ) : IOutput<IFilterConnection>;
	
	function setFilter( filter : String = "All" ) : Void;
	
	function getFilter() : String;
}