package uk.co.gavd.diagnostics
{
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

    /**
	 * Adapted from GuiltFilter's code on
	 * http://www.actionscript.org/forums/showthread.php3?t=171724
	 */
    public class ClassUtils
    {
		public static function getClass(obj:Object):Class {
			return Class(getDefinitionByName(getQualifiedClassName(obj)));
		}
    }
}