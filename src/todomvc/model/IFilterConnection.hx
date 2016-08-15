package todomvc.model;

/**
 * @author Francis Bourre
 */
interface IFilterConnection 
{
	function changeFilter( currentFilter : String ) : Void;
}