package;

/**
 * ...
 * @author Francis Bourre
 */
class TodoMVC
{
	static public function main() : Void
	{
		#if debug
			var proxy : hex.log.layout.LogProxyLayout = new hex.log.layout.LogProxyLayout();
			#if js
			proxy.addListener( new hex.log.layout.JavaScriptConsoleLayout() );
			#elseif flash
			proxy.addListener( new hex.log.layout.TraceLayout() );
			#end
		#end
		
		hex.compiletime.xml.BasicXmlCompiler.compile( "configuration/context.xml", null, [ "browser" => true, "flashplayer" => false ] );
	}
}