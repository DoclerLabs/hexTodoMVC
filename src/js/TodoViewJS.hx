package js;

import common.Filter;
import common.TodoItem;
import hex.log.ILogger;
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
class TodoViewJS implements ITodoView
{
	@Inject
	public var logger 		: ILogger;
	
	var _controller 		: ITodoController;
	var _qs 				: String -> Element = Browser.document.querySelector;
	
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
		
		this.changeFooterVisibility( false );
	}
	
	@Debug public function setController( controller : ITodoController ) : Void
	{
		this._controller = controller;
		new JQuery( function() : Void { this._initJQuery(); } );
	}
	
	@Debug function _initJQuery() : Void
	{
		new JQuery( Browser.window ).on( 'hashchange', _onHashChange );
		new JQuery( this._newTodo ).on( 'change', this._onNewTodo );
		new JQuery( this._clearCompleted ).on( 'click', this._onClearCompleted );
		new JQuery( this._toggleAll ).on( 'click', this._onToggleAll );
		new JQuery( this._todoList ).delegate( 'li label', 'dblclick', this._onEditItem );
		new JQuery( this._todoList ).delegate( '.destroy', 'click', this._onRemoveItem );
		new JQuery( this._todoList ).delegate( '.toggle', 'click', this._onToggleComplete );
		new JQuery( this._todoList ).delegate( 'li .edit', 'keypress', this._onItemKeyPress );
		new JQuery( this._todoList ).delegate( 'li .edit', 'keyup', this._onCancelItemEdition );
		new JQuery( Browser.window ).on( 'hashchange', _onHashChange );
	}
	
	/**
	 * UIs callbacks
	 */
	@Debug function _onHashChange( e : js.jquery.Event ) : Void
	{
		var location : String = ( cast e.target ).location.hash;
		var route = location.split( '/' )[ 1 ];
		
		var filter = switch( route )
		{
			case "active": Filter.ACTIVE;
			case "completed": Filter.COMPLETED;
			case _: Filter.ALL;
		}
		this._controller.setFilter( filter ); 
	}
	
	@Debug function _onNewTodo( e : js.jquery.Event ) : Void
	{
		this._controller.addItem( ( cast e.target ).value ); 
	}
	
	@Debug function _onClearCompleted( e : js.jquery.Event ) : Void
	{
		this._controller.removeCompletedItems();
	}
	
	@Debug function _onToggleAll( e : js.jquery.Event ) : Void
	{
		this._controller.toggleAll( ( cast e.target ).checked );
	}
	
	@Debug function _onEditItem( e : js.jquery.Event ) : Void
	{
		this._controller.editItem( this._itemID( cast e.target ) );
	}
	
	@Debug function _onRemoveItem( e : js.jquery.Event ) : Void
	{
		this._controller.removeItem( this._itemID( cast e.target ) );
	}
	
	@Debug function _onToggleComplete( e : js.jquery.Event ) : Void
	{
		this._controller.toggleComplete( this._itemID( cast e.target ), ( cast e.target ).checked );
	}

	@Debug function _onItemKeyPress( e : js.jquery.Event ) : Void
	{
		if ( e.keyCode == 13 ) 
		{
			var li : LIElement = ( cast e.target );
			li.blur();
			this._controller.editItemSave( new JQuery( li ).parent().attr( 'data-id' ), "" + li.value );
		}
	}

	@Debug function _onCancelItemEdition( e : js.jquery.Event ) : Void
	{
		if ( e.keyCode == 27 ) 
		{
			var li : LIElement = ( cast e.target );
			li.blur();
			this._controller.editItemCancel( new JQuery( li ).parent().attr( 'data-id' ) );
		}
	}
	
	/**
	 * ITodoView implementation
	 */
	public function selectAllFilterButton() : Void
	{
		this._setFilter( '' );
	}
	
	public function selectActiveFilterButton() : Void
	{
		this._setFilter( 'active' );
	}
	
	public function selectCompletedFilterButton() : Void
	{
		this._setFilter( 'completed' );
	}
	
	public function showEntries( entries : Array<TodoItem> ) : Void 
	{
		this._todoList.innerHTML = this._template.items.execute( { items: entries } );
	}
	
	public function removeItem(  id : String ) : Void 
	{
		var elem = this._qs( '[data-id="' + id + '"]' );

		if ( elem != null ) 
		{
			this._todoList.removeChild( elem );
		}
	}
	
	public function updateItemCount( activeItems : Int ) : Void 
	{
		this._todoItemCounter.innerHTML = this._template.activeItems.execute( { activeItems: activeItems } );
	}
	
	public function clearCompletedButton( completedCount : Int, visible : Bool ) : Void 
	{
		this._clearCompleted.innerHTML = this._template.completedCount.execute( { completedCount: completedCount } );
		this._clearCompleted.style.display = visible ? 'block' : 'none';
	}
	
	public function changeFooterVisibility( isVisible : Bool ) : Void 
	{
		this._main.style.display = this._footer.style.display = isVisible ? 'block' : 'none';
	}
	
	public function toggleAll( isChecked : Bool ) : Void 
	{
		this._toggleAll.checked = isChecked;
	}
	
	public function clearNewTodo() : Void
	{
		this._newTodo.value = '';
	}
	
	public function setItemCompleted( id : String, isCompleted : Bool ) : Void 
	{
		var item = this._qs( '[data-id="' + id + '"]' );

		if ( item != null ) 
		{
			item.className = isCompleted ? 'completed' : '';
			var input : InputElement = cast item.querySelector( 'input' );
			input.checked = isCompleted;
		}
	}
	
	public function editItem( id : String, title : String ) : Void
	{
		var item = this._qs('[data-id="' + id + '"]');

		if ( item != null ) 
		{
			item.className = item.className + ' editing';
			var input : InputElement = cast Browser.document.createElement( 'input' );
			input.className = 'edit';
			item.appendChild( input );
			input.focus();
			input.value = title;
		}
	}
	
	public function editItemDone( id : String, title : String ) : Void
	{
		var item = this._qs( '[data-id="' + id + '"]' );

		if ( item != null ) 
		{
			var input : InputElement = cast item.querySelector( 'input.edit' );
			item.removeChild( input );
			item.className = item.className.split( 'editing' ).join( '' );

			var list = item.querySelectorAll( 'label' );
			for ( label in list )
			{
				( cast label ).textContent = title;
			}
		}
	}
	
	//private
	function _setFilter( currentFilter : String ) : Void
	{
		this._qs( '.filters .selected' ).className = '';
		this._qs( '.filters [href="#/' + currentFilter + '"]' ).className = 'selected';
	}
	
	function _itemID( element ) : String
	{
		return new JQuery( element ).parent().parent().attr( 'data-id' );
	}
}