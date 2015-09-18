package view;
/**
* AppElement
* 
* @author Midori Kocak github.com/mtkocak
* @package view
**/
import js.html.EventListener;
import js.html.Event;
import js.html.Element;
class AppElement
{
    public var bodyElement:Element = js.Browser.document.body;
    public var inputElement:Element;
    public var toggleElement:Element;

    public var sectionElement:Element;
    public var footerElement:Element;
    /**
    * Class Constructor
    * @return void
    **/
    public function new()
    {
       inputElement = cast bodyElement.getElementsByClassName('new-todo')[0];
       toggleElement = cast bodyElement.getElementsByClassName('toggle-all')[0];

       sectionElement = cast bodyElement.getElementsByClassName('main')[0];
       footerElement = cast bodyElement.getElementsByClassName('footer')[0];
    }


    public function hideSectionElement(){
        sectionElement.style.display = "none";
    }

    public function showSectionElement(){
        sectionElement.style.display = "initial";
    }
}
