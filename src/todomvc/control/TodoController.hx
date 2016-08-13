package todomvc.control;

import todomvc.model.ITodoModel;
import todomvc.model.TodoItem;

using StringTools;

/**
 * ...
 * @author Francis Bourre
 */
class TodoController implements ITodoController
{
	@Inject
	public var model : ITodoModel;
	
	public function new() 
	{
		
	}
	
	public function addTodo( title : String ) : Void
	{
		var newTodo = title.trim();
		
		if ( newTodo.length > 0  ) 
		{
			this.model.addTodo( new TodoItem( newTodo, false ) );
			//this.$scope.newTodo = '';
		}
	}
	
	public function editTodo( todoItem : TodoItem ) : Void
	{
		//this.$scope.editedTodo = todoItem;

		// Clone the original todo in case editing is cancelled.
		//this.$scope.originalTodo = angular.extend({}, todoItem);
	}
	
	public function revertEdits( todoItem : TodoItem ) : Void
	{
		//this.todos[this.todos.indexOf(todoItem)] = this.$scope.originalTodo;
		//this.$scope.reverted = true;
	}
	
	public function doneEditing( todoItem : TodoItem )  : Void
	{
		/*this.$scope.editedTodo = null;
		this.$scope.originalTodo = null;
		
		if ( this.$scope.reverted ) 
		{
			// Todo edits were reverted, don't save.
			this.$scope.reverted = null;
			return;
		}*/
		
		todoItem.title = todoItem.title.trim();
		
		if ( todoItem.title.length < 1 ) 
		{
			this.removeTodo( todoItem );
		}
	}
	
	public function removeTodo( todoItem: TodoItem ) : Void
	{
		this.model.removeTodo( todoItem );
	}
	
	public function clearDoneTodos() : Void
	{
		//this.$scope.todos = this.todos = this.todos.filter(todoItem => !todoItem.completed);
	}
	
	public function markAll( completed : Bool ) : Void
	{
		//this.todos.forEach(todoItem => { todoItem.completed = completed; });
	}
}