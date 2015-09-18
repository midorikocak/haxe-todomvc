package view;
/**
* AppView
* 
* @author Midori Kocak github.com/mtkocak
* @package view
**/
import js.html.Element;
class AppView
{
    public var appElement:AppElement;
    /**
    * Class Constructor
    * @return void
    **/
    public function new()
    {
        appElement = new AppElement();
    }

    public function addToSection(todosView:TodosView){
        var todosElement:Element = todosView.todosElement.todosElement;
        appElement.sectionElement.appendChild(todosElement);
    }

}
