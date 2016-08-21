package todomvc.service;

import common.TodoItem;

/**
 * @author Francis Bourre
 */
@:keepSub
interface ITodoService 
{
	function load (): Array<TodoItem>;
    function save( todos : Array<TodoItem> ) : Void;
}