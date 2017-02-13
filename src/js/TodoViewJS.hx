package js;

import common.Filter;
import common.TodoItem;
import hex.error.IllegalStateException;
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
@:keepSub
class TodoViewJS implements ITodoView
{
	@Inject
	public var _controller 	: ITodoController;
	var _qs 				: String -> Element = Browser.document.querySelector;
	
	var _template 			: Template;
	var _todoList 			: InputElement;
	var _todoItemCounter 	: Element;
	var _clearCompleted 	: Element;
	var _main 				: Element;
	var _footer 			: Element;
	var _toggleAll 			: InputElement;
	var _newTodo 			: InputElement;
	
	public function new( main ) 
	{
		this._main 				= cast main;
		this._template 			= new Template();

		var document 			= js.Browser.document;
		this._todoList			= cast document.querySelector( '.todo-list' );
		this._todoItemCounter 	= cast document.querySelector( '.todo-count' );
		this._clearCompleted 	= cast document.querySelector( '.clear-completed' );
		this._footer 			= cast document.querySelector( '.footer' );
		this._toggleAll 		= cast document.querySelector( '.toggle-all' );
		this._newTodo 			= cast document.querySelector( '.new-todo' );
		
		this.onChangeFooterVisibility( false );
	}
	
	@PostConstruct @Debug public function _do() : Void
	{
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
	@Debug public function selectAllFilterButton() : Void
	{
		this._setFilter( '' );
	}
	
	@Debug public function selectActiveFilterButton() : Void
	{
		this._setFilter( 'active' );
	}
	
	@Debug public function selectCompletedFilterButton() : Void
	{
		this._setFilter( 'completed' );
	}
	
	@Debug public function onShowEntries( entries : Array<TodoItem> ) : Void 
	{
		this._todoList.innerHTML = this._template.items.execute( { items: entries } );
	}
	
	@Debug public function onRemoveItem(  id : String ) : Void 
	{
		var elem = this._qs( '[data-id="' + id + '"]' );

		if ( elem != null ) 
		{
			this._todoList.removeChild( elem );
		}
	}
	
	@Debug public function onUpdateItemCount( activeItems : Int ) : Void 
	{
		this._todoItemCounter.innerHTML = this._template.activeItems.execute( { activeItems: activeItems } );
	}
	
	@Debug public function onClearCompletedButton( completedCount : Int, visible : Bool ) : Void 
	{
		this._clearCompleted.innerHTML = this._template.completedCount.execute( { completedCount: completedCount } );
		this._clearCompleted.style.display = visible ? 'block' : 'none';
	}
	
	public function onChangeFooterVisibility( isVisible : Bool ) : Void 
	{
		this._main.style.display = this._footer.style.display = isVisible ? 'block' : 'none';
	}
	
	@Debug public function onToggleAll( isChecked : Bool ) : Void 
	{
		this._toggleAll.checked = isChecked;
	}
	
	@Debug public function onClearNewTodo() : Void
	{
		this._newTodo.value = '';
	}
	
	@Debug public function onSetItemCompleted( id : String, isCompleted : Bool ) : Void 
	{
		var item = this._qs( '[data-id="' + id + '"]' );

		if ( item != null ) 
		{
			item.className = isCompleted ? 'completed' : '';
			var input : InputElement = cast item.querySelector( 'input' );
			input.checked = isCompleted;
		}
	}
	
	@Debug public function onEditItem( id : String, title : String ) : Void
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
	
	@Debug public function onEditItemDone( id : String, title : String ) : Void
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
	
	@Debug public function changeFilter( currentFilter : Filter ) : Void
	{
		switch( currentFilter )
		{
			case Filter.ALL:
				this.selectAllFilterButton();
				this._controller.showAll().onComplete( this.onShowEntries.bind() );
				
			case Filter.ACTIVE:
				this.selectActiveFilterButton();
				this._controller.showActive().onComplete( this.onShowEntries.bind() );
				
			case Filter.COMPLETED:
				this.selectCompletedFilterButton();
				this._controller.showCompleted().onComplete( this.onShowEntries.bind() );
				
			case _:
				throw new IllegalStateException( "changeFilter call with illegal filter parameter: '" + currentFilter + "'" );
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