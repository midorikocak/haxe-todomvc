package view;
/**
* ImagesView
*
* @author Midori Kocak github.com/mtkocak
* @package view
**/
import js.html.ButtonElement;
import js.html.InputElement;
import js.html.Node;
import js.html.Element;
import js.html.EventListener;
import js.html.HTMLCollection;
import controller.TodosController;
class TodosView
{
    public var todosElement:TodosElement = new TodosElement();
    public var inputElement:InputElement;
    public var active:Element;
    public var completed:Element;
    public var clearCompletedButton:ButtonElement;
    public var selected:Element;
    public var viewController(default, set_viewController):TodosController;
    public var counterElement:Element;
    /**
    * Class Constructor
    * @return void
    **/

    public function new()
    {
        selected = cast js.Browser.document.body.getElementsByClassName('selected')[0];
        selected.onclick = function(e:EventListener){
            viewController.updateView();
        };

        counterElement = cast js.Browser.document.body.getElementsByClassName('todo-count')[0];


        active = cast js.Browser.document.body.getElementsByClassName('active')[0];
        active.onclick = function(e:EventListener){
            filterActive();
        };
        completed = cast js.Browser.document.body.getElementsByClassName('completed')[0];
        completed.onclick = function(e:EventListener){
            filterCompleted();
        };

        clearCompletedButton = cast js.Browser.document.body.getElementsByClassName(' clear-completed')[0];
        clearCompletedButton.onclick = function(e:EventListener){
            clearCompleted();
        }
        inputElement = cast js.Browser.document.body.getElementsByClassName('new-todo')[0];
        inputElement.onkeypress = function (event:Dynamic) {
            if ((inputElement.value!="")&& (event.which == 13 || event.keyCode == 13)) {
                viewController.add(inputElement.value,false);
                viewController.updateView();
                inputElement.value = "";
                return false;
            }
            return true;
        };
    }

    public function set_viewController(controller:TodosController)
    {
        this.viewController = controller;
        return controller;
    }

    public function add(?title:String = "", ?isCompleted:Bool = false, id:Int):Void
    {
        var todoView:TodoView = new TodoView(id);
        todoView.todoElement.buttonElement.onclick = function(e:EventListener)
        {
            delete(id);
        };

        todoView.todoElement.labelElement.ondblclick = function(e:EventListener){
            todoView.todoElement.labelElement.contentEditable = "true";
        };

        todoView.todoElement.labelElement.oninput = function(e:EventListener){
            viewController.edit(id,todoView.todoElement.labelElement.textContent);
        };

        todoView.todoElement.checkBoxElement.onclick = function(e:EventListener){
            viewController.setCompleted(id, !viewController.getCompleted(id));
            viewController.updateView();
        }
        todoView.updateTodo(title, isCompleted);
        todosElement.add(todoView.todoElement);
    }

    public function clearCompleted():Void{
        viewController.clearCompleted();
    }

    public function filterCompleted():Void{
        viewController.filterCompleted();
    }

    public function filterActive():Void{
        viewController.filterActive();
    }

    public function delete(id:Int)
    {
        viewController.delete(id);
        viewController.updateView();
    }

    public function changeCounter(counter:Int){
        this.counterElement.firstChild.textContent = cast counter;
    }

    public function edit(){

    }

    public function clear()
    {
        todosElement.clear();
    }

}
