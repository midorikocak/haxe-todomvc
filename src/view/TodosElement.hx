package view;
/**
* TodosElement
* 
* @author Midori Kocak github.com/mtkocak
* @package view
**/
import js.html.EventListener;
import js.html.Element;
class TodosElement
{
    public var todosElement:Element = js.Browser.document.createElement('ul');
    /**
    * Class Constructor
    * @return void
    **/
    public function new()
    {
        this.todosElement.className = "todo-list";
    }

    public function add(todoElement:TodoElement):Void{
        this.todosElement.appendChild(todoElement.listElement);
    }

    public function clear():Void{
        this.todosElement.innerHTML = "";
    }
}
