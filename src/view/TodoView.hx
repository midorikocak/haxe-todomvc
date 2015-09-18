package view;
/**
* TodoView
* 
* @author Midori Kocak github.com/mtkocak
* @package view
**/
class TodoView
{
    public var todoElement:TodoElement;
    /**
    * Class Constructor
    * @return void
    **/
    public function new(id:Int)
    {
        this.todoElement = new TodoElement(id);
    }

    public function updateTodo(title:String,isCompleted:Bool){
        this.todoElement.update(title,isCompleted);
    }

    public function deleteTodo():Void{
        this.todoElement.listElement.parentElement.removeChild(this.todoElement.listElement);
    }
}
