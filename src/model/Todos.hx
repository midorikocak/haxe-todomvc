package model;
/**
* Images
* 
* @author Midori Kocak github.com/mtkocak
* @package model
**/
import js.html.Storage;
class Todos
{
    var list(default,set_list):List<Todo>;
    public var counter:Int = 0;
    /**
    * Class Constructor
    * @return void
    **/
    public function new()
    {
        list = new List<Todo>();
    }

    public function get_list():List<Todo>{
        return list;
    }

    public function set_list(list:List<Todo>){
        this.list = list;
        return list;
    }

    public function add(todo:Todo):Void{
        this.list.add(todo);
        counter++;
    }

    public function delete(id:Int):Void{
        var todo = this.getTodo(id);
        this.list.remove(todo);
    }

    public function edit(id:Int, text:String):Void{
        var todo:Todo = this.getTodo(id);
        todo.set_title(text);
    }

    public function setCompleted(id:Int,isCompleted:Bool):Void{
        var todo = this.getTodo(id);
        todo.set_isCompleted(isCompleted);
    }

    public function getCompleted(id:Int):Bool{
        var todo = this.getTodo(id);
        return todo.get_isCompleted();
    }

    public function getTodo(id:Int):Dynamic{
        for(todo in list){
            if(todo.id == id){
                return todo;
            }
        }
        return null;
    }

}
