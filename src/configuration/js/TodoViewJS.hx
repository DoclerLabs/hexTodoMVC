package configuration.js;

import js.html.Element;
import todomvc.view.ITodoView;

/**
 * ...
 * @author Francis Bourre
 */
class TodoViewJS implements ITodoView
{
	var _todoList 			: Element;
	var _todoItemCounter 	: Element;
	var _clearCompleted 	: Element;
	var _main 				: Element;
	var _footer 			: Element;
	var _toggleAll 			: Element;
	var _newTodo 			: Element;
	
	public function new( 	todoList,
							todoItemCounter,
							clearCompleted,
							main,
							footer,
							toggleAll,
							newTodo ) 
	{
		/*this._todoList 			= todoList;
		this._todoItemCounter 	= todoItemCounter;
		this._clearCompleted 	= clearCompleted;
		this._main 				= main;
		this._footer 			= footer;
		this._toggleAll 		= toggleAll;
		this._newTodo 			= newTodo;*/
	}
	
	public function clearCompletedButton( completedCount : Int, visible : Bool ) 
	{
		//this._clearCompleted.innerHTML = this.template.clearCompletedButton( completedCount );
		this._clearCompleted.style.display = visible ? 'block' : 'none';
	}
}