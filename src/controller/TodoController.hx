package controller;
/**
* TodoController
* 
* @author Midori Kocak github.com/mtkocak
* @package controller
**/
import view.TodoElement;
import view.TodoView;
import model.Todo;
class TodoController
{
    var model(default,set_model):Todo;
    var view(default,set_view):TodoView;

    /**
    * Class Constructor
    * @return void
    **/
    public function new()
    {
    }

    public function set_model(model:Todo):Todo{
        this.model = model;
        return model;
    }

    public function set_view(view:TodoView){
        this.view = view;
        return view;
    }

    public function setIsCompleted(isCompleted:Bool):Void{
        this.model.set_isCompleted(isCompleted);
    }

    public function getIsCompleted(){
        return this.model.get_isCompleted();
    }

    public function getTitle(){
        return this.model.get_title();
    }

    public function setTitle(title:String):Void{
        this.model.set_title(title);
    }

    public function updateView():Void{
        this.view.updateTodo(this.model.get_title(),this.model.get_isCompleted());
    }
}
