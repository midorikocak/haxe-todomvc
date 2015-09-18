package controller;
/**
* ImagesController
* 
* @author Midori Kocak github.com/mtkocak
* @package controller
**/
import js.html.Element;
import view.TodoElement;
import model.Todo;
import view.TodosView;
import model.Todos;
class TodosController
{
    var model:Todos;
    var view:TodosView;
    /**
    * Class Constructor
    * @return void
    **/
    public function new(model:Todos,view:TodosView)
    {
        this.model = model;
        this.view = view;
    }

    public function getTodos():List<Todo>{
        return this.model.get_list();
    }

    public function add(title:String,isCompleted:Bool):Void{
        var todo:Todo = new Todo();
        todo.id = this.model.counter;
        todo.set_title(title);
        todo.set_isCompleted(isCompleted);
        this.model.add(todo);
    }

    public function filterActive(){
        var list:List<Todo> = this.model.get_list();
        var active:List<Todo> = list.filter(function(todo:Todo){
            return !todo.get_isCompleted();
        });
        this.updateView(active);
    }

    public function countActive():Int{
        var list:List<Todo> = this.model.get_list();
        var active:List<Todo> = list.filter(function(todo:Todo){
            return !todo.get_isCompleted();
        });
        return active.length;
    }

    public function filterCompleted(){
        var list:List<Todo> = this.model.get_list();
        var completed:List<Todo> = list.filter(function(todo:Todo){
            return todo.get_isCompleted();
        });
        this.updateView(completed);
    }

    public function completeTodo(todo:Todo){
        todo.set_isCompleted(true);
    }

    public function clearCompleted(){
        var list:List<Todo> = this.model.get_list();
        for (todo in list){
            if (todo.get_isCompleted()==true){
                this.model.delete(todo.id);
            }
        }
        this.updateView(list);
    }

    public function getCount():Int{
        return this.model.get_list().length;
    }

    public function delete(id:Int){
        this.model.delete(id);
    }

    public function setCompleted(id:Int,isCompleted:Bool){
        this.model.setCompleted(id,isCompleted);
    }

    public function getCompleted(id:Int):Bool{
       return this.model.getCompleted(id);
    }

    public function setTodos(list:List<Todo>):Void{
        this.model.set_list(list);
    }

    public function updateView(?list:List<Todo>):Void{
        this.view.clear();
        if(list==null){
            var list:List<Todo> = this.model.get_list();
            for(todo in list){
                this.view.add(todo.get_title(), todo.get_isCompleted(),todo.id);
            }
        }else{
            for(todo in list){
                this.view.add(todo.get_title(), todo.get_isCompleted(),todo.id);
            }
        }
        this.view.changeCounter(this.countActive());
    }
}
