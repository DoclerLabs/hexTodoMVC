package configuration.js;

import hex.di.IInjectorContainer;
import js.Browser;
import js.html.Element;
import js.html.InputElement;
import js.html.LIElement;
import js.jquery.JQuery;
import todomvc.control.ITodoController;
import todomvc.view.ITodoView;

/**
 * ...
 * @author Francis Bourre
 */
class TodoViewJS implements ITodoView implements IInjectorContainer
{
	var _controller 		: ITodoController;
	var qs 					: String -> Element = Browser.document.querySelector;
	
	var _template 			: Template;
	var _todoList 			: InputElement;
	var _todoItemCounter 	: Element;
	var _clearCompleted 	: Element;
	var _main 				: Element;
	var _footer 			: Element;
	var _toggleAll 			: InputElement;
	var _newTodo 			: InputElement;
	
	public function new( 	todoList,
							todoItemCounter,
							clearCompleted,
							main,
							footer,
							toggleAll,
							newTodo ) 
	{
		this._template 			= new Template();
		this._todoList 			= cast todoList;
		this._todoItemCounter 	= cast todoItemCounter;
		this._clearCompleted 	= cast clearCompleted;
		this._main 				= cast main;
		this._footer 			= cast footer;
		this._toggleAll 		= cast toggleAll;
		this._newTodo 			= cast newTodo;
		
		
	}
	
	public function setController( controller : ITodoController ) : Void
	{
		this._controller = controller;
		new JQuery( function():Void {this._initController(); } );
	}
	
	function _initController() : Void
	{
		new JQuery( this._newTodo ).on( 'change', function( e ) { this._controller.addItem( this._newTodo.value ); } );
		new JQuery( this._clearCompleted ).on( 'click', function( e ) { this._controller.removeCompletedItems(); } );
		new JQuery( this._toggleAll ).on( 'click', function( e ) { this._controller.toggleAll( this._toggleAll.checked ); } );
		
		new JQuery( this._todoList ).delegate( 'li label', 'dblclick', function( e ) { this._controller.editItem( this._itemID( cast e.target ) ); } );
		new JQuery( this._todoList ).delegate( '.destroy', 'click', function( e ) { this._controller.removeItem( this._itemID( cast e.target ) ); } );
		new JQuery( this._todoList ).delegate( '.toggle', 'click', function( e ) { this._controller.toggleComplete( this._itemID( cast e.target ), ( cast e.target ).checked ); } );
	}
		
	public function showEntries( entries ) : Void 
	{
		this._todoList.innerHTML = this._template.show( entries );
	}
	
	public function removeItem( item ) : Void 
	{
		this._removeItem( item );
	}
	
	public function updateElementCount( activeTodos ) : Void 
	{
		this._todoItemCounter.innerHTML = this._template.itemCounter( activeTodos );
	}
	
	public function clearCompletedButton( parameter ) : Void 
	{
		this._clearCompletedButton( parameter.completed, parameter.visible );
	}
	
	public function contentBlockVisibility( parameter ) : Void 
	{
		this._main.style.display = this._footer.style.display = parameter.visible ? 'block' : 'none';
	}
	
	public function toggleAll( parameter ) : Void 
	{
		this._toggleAll.checked = parameter.checked;
	}
	
	public function setFilter( parameter ) : Void
	{
		this._setFilter( parameter );
	}
	
	public function clearNewTodo() : Void
	{
		this._newTodo.value = '';
	}
	
	public function elementComplete( parameter ) : Void 
	{
		this._elementComplete( parameter.id, parameter.completed );
	}
	
	public function editItem( item ) : Void
	{
		this._editItem( item.id, item.title );
	}
	
	public function editItemDone( item ) : Void
	{
		this._editItemDone( item.id, item.title );
	}
	
	function _removeItem( id : String ) : Void
	{
		var elem = qs( '[data-id="' + id + '"]' );

		if ( elem != null ) 
		{
			this._todoList.removeChild( elem );
		}
	}
	
	//
	function _itemID( element ) : Int
	{
		var li : LIElement = cast new JQuery( element ).parent( 'li' );
		return Std.parseInt( li.dataset.id );
	}

	function _clearCompletedButton( completedTodos : Int, visible : Bool ) : Void
	{
		this._clearCompleted.innerHTML = this._template.clearCompletedButton( completedTodos );
		this._clearCompleted.style.display = visible ? 'block' : 'none';
	}
	
	function _setFilter( currentPage ) : Void
	{
		qs( '.filters .selected' ).className = '';
		qs( '.filters [href="#/' + currentPage + '"]' ).className = 'selected';
	}

	function _elementComplete( id, completed ) : Void
	{
		var listItem = qs( '[data-id="' + id + '"]' );

		if ( listItem != null ) 
		{
			listItem.className = completed ? 'completed' : '';

			// In case it was toggled from an event and not by clicking the checkbox
			//qs( 'input', listItem ).checked = completed;
			var input : InputElement = cast listItem.querySelector( 'input' );
			input.checked = completed;
		}
	}

	function _editItem( id, title ) : Void
	{
		var listItem = qs('[data-id="' + id + '"]');

		if ( listItem != null ) 
		{
			listItem.className = listItem.className + ' editing';

			var input : InputElement = cast Browser.document.createElement( 'input' );
			input.className = 'edit';

			listItem.appendChild( input );
			input.focus();
			input.value = title;
		}
	}

	function _editItemDone( id, title ) : Void
	{
		var listItem = qs( '[data-id="' + id + '"]' );

		if ( listItem != null ) 
		{
			//var input : InputElement = qs( 'input.edit', listItem );
			var input : InputElement = cast listItem.querySelector( 'input.edit' );
			listItem.removeChild( input );
			//listItem.className = listItem.className.replace('editing', '');
			listItem.className = listItem.className.split( 'editing' ).join( '' );

			var list = listItem.querySelectorAll( 'label' );
			for ( label in list )
			{
				( cast label ).textContent = title;
			}

			/*qsa('label', listItem).forEach(function (label) {
				label.textContent = title;
			});*/
		}
	}
	
	function _bindItemEditDone() : Void
	{
		new JQuery( this._todoList ).delegate( 'li .edit', 'blur', 
		function ( e ) 
		{
			var li : LIElement = ( cast e.target );
			if ( li.dataset.iscanceled != null ) 
			{
				this._controller.editItemSave( this._itemID( li ), "" + li.value );
			}
		});

		new JQuery( this._todoList ).delegate( 'li .edit', 'keypress', 
		function ( e ) 
		{
			if ( e.keyCode == 13 ) 
			{
				var li : LIElement = ( cast e.target );
				// Remove the cursor from the input when you hit enter just like if it
				// were a real form
				li.blur();
			}
		});
	}

	function _bindItemEditCancel() : Void
	{
		new JQuery( this._todoList ).delegate( 'li .edit', 'keyup', 
		function ( e ) 
		{
			if ( e.keyCode == 27 ) 
			{
				var li : LIElement = ( cast e.target );
				li.dataset.iscanceled = "true";
				li.blur();

				this._controller.editItemCancel( this._itemID( li ) );
			}
		});
	}
}