package;

/**
 * ...
 * @author Francis Bourre
 */
class Main
{
	static public function main() : Void
	{
		#if debug
			var proxy : hex.log.layout.LogProxyLayout = new hex.log.layout.LogProxyLayout();
			#if js
			var controller = new hex.log.layout.LogLayoutHTMLView( proxy );
			proxy.addListener( new hex.log.layout.SimpleBrowserLayout( controller.consoleWrapperTaget ) );
			proxy.addListener( new hex.log.layout.JavaScriptConsoleLayout() );
			#elseif flash
			proxy.addListener( new hex.log.layout.TraceLayout() );
			#end
		#end
		trace( "yup" );
		hex.compiler.parser.xml.XmlCompiler.readXmlFile( "configuration/context.xml", null, [ "browser" => true, "flashplayer" => false ] );
	}
}