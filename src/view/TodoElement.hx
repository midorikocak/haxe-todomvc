package view;
/**
* TodoElement
* 
* @author Midori Kocak github.com/mtkocak
* @package view
**/
import js.html.LabelElement;
import js.html.ButtonElement;
import js.html.InputElement;
import js.html.Element;
class TodoElement
{
    var title:String;
    var isCompleted:Bool;
    public var listElement:Element = js.Browser.document.createElement('li');
    var divElement:Element =  js.Browser.document.createElement('div');
    public var checkBoxElement:InputElement = js.Browser.document.createInputElement();
    public var labelElement:LabelElement = js.Browser.document.createLabelElement();
    public var buttonElement:ButtonElement = js.Browser.document.createButtonElement();
    public var inputElement:InputElement = js.Browser.document.createInputElement();
    /**
    * Class Constructor
    * @return void
    **/
    public function new(?title:String,?isCompleted:Bool = false,id:Int)
    {
        this.title = title;
        this.isCompleted = isCompleted;

        divElement.className = "view";

        checkBoxElement.type = 'checkbox';
        checkBoxElement.className = 'toggle';

        divElement.appendChild(checkBoxElement);

        labelElement.textContent = title;

        divElement.appendChild(labelElement);

        buttonElement.className = 'destroy';

        divElement.appendChild(buttonElement);

        listElement.appendChild(divElement);
        listElement.setAttribute('data-id',cast id);

        inputElement.className = 'edit';

        listElement.appendChild(inputElement);
    }

    public function update(title:String,isCompleted:Bool){
        labelElement.textContent = title;
        if(isCompleted==true){
            listElement.className = 'completed';
            checkBoxElement.checked = true;
        }
    }
}
