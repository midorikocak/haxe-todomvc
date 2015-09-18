package model;
/**
* Todo
* 
* @author Midori Kocak github.com/mtkocak
* @package model
**/
class Todo
{
    public var id:Int;
    var title(default,set_title):String;
    var isCompleted(default,set_isCompleted):Bool;
    /**
    * Class Constructor
    * @return void
    **/
    public function new()
    {
        title = "";
        isCompleted = false;
    }

    public function get_title():String{
        return this.title;
    }

    public function set_title(title:String){
        this.title = title;
        return title;
    }

    public function set_isCompleted(isCompleted:Bool){
        this.isCompleted = isCompleted;
        return isCompleted;
    }

    public function get_isCompleted():Bool{
        return this.isCompleted;
    }
}
