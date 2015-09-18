(function () { "use strict";
var List = function() {
	this.length = 0;
};
List.prototype = {
	add: function(item) {
		var x = [item];
		if(this.h == null) this.h = x; else this.q[1] = x;
		this.q = x;
		this.length++;
	}
	,remove: function(v) {
		var prev = null;
		var l = this.h;
		while(l != null) {
			if(l[0] == v) {
				if(prev == null) this.h = l[1]; else prev[1] = l[1];
				if(this.q == l) this.q = prev;
				this.length--;
				return true;
			}
			prev = l;
			l = l[1];
		}
		return false;
	}
	,iterator: function() {
		return { h : this.h, hasNext : function() {
			return this.h != null;
		}, next : function() {
			if(this.h == null) return null;
			var x = this.h[0];
			this.h = this.h[1];
			return x;
		}};
	}
	,filter: function(f) {
		var l2 = new List();
		var l = this.h;
		while(l != null) {
			var v = l[0];
			l = l[1];
			if(f(v)) l2.add(v);
		}
		return l2;
	}
};
var Main = function() {
};
Main.main = function() {
	var appView = new view.AppView();
	var todos = Main.getTodos();
	var todosView = new view.TodosView();
	appView.addToSection(todosView);
	var todosController = new controller.TodosController(todos,todosView);
	todosView.set_viewController(todosController);
	appView.appElement.toggleElement.onclick = function(e) {
		appView.appElement.hideSectionElement();
	};
	todosController.updateView();
};
Main.getTodos = function() {
	var todos = new model.Todos();
	return todos;
};
Main.getTodo = function() {
	var todo = new model.Todo();
	return todo;
};
var controller = {};
controller.TodoController = function() {
};
controller.TodoController.prototype = {
	set_model: function(model) {
		this.model = model;
		return model;
	}
	,set_view: function(view) {
		this.view = view;
		return view;
	}
	,setIsCompleted: function(isCompleted) {
		this.model.set_isCompleted(isCompleted);
	}
	,getIsCompleted: function() {
		return this.model.get_isCompleted();
	}
	,getTitle: function() {
		return this.model.get_title();
	}
	,setTitle: function(title) {
		this.model.set_title(title);
	}
	,updateView: function() {
		this.view.updateTodo(this.model.get_title(),this.model.get_isCompleted());
	}
};
controller.TodosController = function(model,view) {
	this.model = model;
	this.view = view;
};
controller.TodosController.prototype = {
	getTodos: function() {
		return this.model.get_list();
	}
	,add: function(title,isCompleted) {
		var todo = new model.Todo();
		todo.id = this.model.counter;
		todo.set_title(title);
		todo.set_isCompleted(isCompleted);
		this.model.add(todo);
	}
	,filterActive: function() {
		var list = this.model.get_list();
		var active = list.filter(function(todo) {
			return !todo.get_isCompleted();
		});
		this.updateView(active);
	}
	,countActive: function() {
		var list = this.model.get_list();
		var active = list.filter(function(todo) {
			return !todo.get_isCompleted();
		});
		return active.length;
	}
	,filterCompleted: function() {
		var list = this.model.get_list();
		var completed = list.filter(function(todo) {
			return todo.get_isCompleted();
		});
		this.updateView(completed);
	}
	,completeTodo: function(todo) {
		todo.set_isCompleted(true);
	}
	,clearCompleted: function() {
		var list = this.model.get_list();
		var $it0 = list.iterator();
		while( $it0.hasNext() ) {
			var todo = $it0.next();
			if(todo.get_isCompleted() == true) this.model["delete"](todo.id);
		}
		this.updateView(list);
	}
	,getCount: function() {
		return this.model.get_list().length;
	}
	,'delete': function(id) {
		this.model["delete"](id);
	}
	,edit: function(id,text) {
		this.model.edit(id,text);
	}
	,setCompleted: function(id,isCompleted) {
		this.model.setCompleted(id,isCompleted);
	}
	,getCompleted: function(id) {
		return this.model.getCompleted(id);
	}
	,setTodos: function(list) {
		this.model.set_list(list);
	}
	,updateView: function(list) {
		this.view.clear();
		if(list == null) {
			var list1 = this.model.get_list();
			var $it0 = list1.iterator();
			while( $it0.hasNext() ) {
				var todo = $it0.next();
				this.view.add(todo.get_title(),todo.get_isCompleted(),todo.id);
			}
		} else {
			var $it1 = list.iterator();
			while( $it1.hasNext() ) {
				var todo1 = $it1.next();
				this.view.add(todo1.get_title(),todo1.get_isCompleted(),todo1.id);
			}
		}
		this.view.changeCounter(this.countActive());
	}
};
var model = {};
model.Todo = function() {
	this.set_title("");
	this.set_isCompleted(false);
};
model.Todo.prototype = {
	get_title: function() {
		return this.title;
	}
	,set_title: function(title) {
		this.title = title;
		return title;
	}
	,set_isCompleted: function(isCompleted) {
		this.isCompleted = isCompleted;
		return isCompleted;
	}
	,get_isCompleted: function() {
		return this.isCompleted;
	}
};
model.Todos = function() {
	this.counter = 0;
	this.set_list(new List());
};
model.Todos.prototype = {
	get_list: function() {
		return this.list;
	}
	,set_list: function(list) {
		this.list = list;
		return list;
	}
	,add: function(todo) {
		this.list.add(todo);
		this.counter++;
	}
	,'delete': function(id) {
		var todo = this.getTodo(id);
		this.list.remove(todo);
	}
	,edit: function(id,text) {
		var todo = this.getTodo(id);
		todo.set_title(text);
	}
	,setCompleted: function(id,isCompleted) {
		var todo = this.getTodo(id);
		todo.set_isCompleted(isCompleted);
	}
	,getCompleted: function(id) {
		var todo = this.getTodo(id);
		return todo.get_isCompleted();
	}
	,getTodo: function(id) {
		var $it0 = this.list.iterator();
		while( $it0.hasNext() ) {
			var todo = $it0.next();
			if(todo.id == id) return todo;
		}
		return null;
	}
};
var view = {};
view.AppElement = function() {
	this.bodyElement = window.document.body;
	this.inputElement = this.bodyElement.getElementsByClassName("new-todo")[0];
	this.toggleElement = this.bodyElement.getElementsByClassName("toggle-all")[0];
	this.sectionElement = this.bodyElement.getElementsByClassName("main")[0];
	this.footerElement = this.bodyElement.getElementsByClassName("footer")[0];
};
view.AppElement.prototype = {
	hideSectionElement: function() {
		this.sectionElement.style.display = "none";
	}
	,showSectionElement: function() {
		this.sectionElement.style.display = "initial";
	}
};
view.AppView = function() {
	this.appElement = new view.AppElement();
};
view.AppView.prototype = {
	addToSection: function(todosView) {
		var todosElement = todosView.todosElement.todosElement;
		this.appElement.sectionElement.appendChild(todosElement);
	}
};
view.TodoElement = function(title,isCompleted,id) {
	if(isCompleted == null) isCompleted = false;
	this.inputElement = (function($this) {
		var $r;
		var _this = window.document;
		$r = _this.createElement("input");
		return $r;
	}(this));
	this.buttonElement = (function($this) {
		var $r;
		var _this = window.document;
		$r = _this.createElement("button");
		return $r;
	}(this));
	this.labelElement = (function($this) {
		var $r;
		var _this = window.document;
		$r = _this.createElement("label");
		return $r;
	}(this));
	this.checkBoxElement = (function($this) {
		var $r;
		var _this = window.document;
		$r = _this.createElement("input");
		return $r;
	}(this));
	this.divElement = window.document.createElement("div");
	this.listElement = window.document.createElement("li");
	this.title = title;
	this.isCompleted = isCompleted;
	this.divElement.className = "view";
	this.checkBoxElement.type = "checkbox";
	this.checkBoxElement.className = "toggle";
	this.divElement.appendChild(this.checkBoxElement);
	this.labelElement.textContent = title;
	this.divElement.appendChild(this.labelElement);
	this.buttonElement.className = "destroy";
	this.divElement.appendChild(this.buttonElement);
	this.listElement.appendChild(this.divElement);
	this.listElement.setAttribute("data-id",id);
	this.inputElement.className = "edit";
	this.listElement.appendChild(this.inputElement);
};
view.TodoElement.prototype = {
	update: function(title,isCompleted) {
		this.labelElement.textContent = title;
		if(isCompleted == true) {
			this.listElement.className = "completed";
			this.checkBoxElement.checked = true;
		}
	}
};
view.TodoView = function(id) {
	this.todoElement = new view.TodoElement(null,null,id);
};
view.TodoView.prototype = {
	updateTodo: function(title,isCompleted) {
		this.todoElement.update(title,isCompleted);
	}
	,deleteTodo: function() {
		this.todoElement.listElement.parentElement.removeChild(this.todoElement.listElement);
	}
};
view.TodosElement = function() {
	this.todosElement = window.document.createElement("ul");
	this.todosElement.className = "todo-list";
};
view.TodosElement.prototype = {
	add: function(todoElement) {
		this.todosElement.appendChild(todoElement.listElement);
	}
	,clear: function() {
		this.todosElement.innerHTML = "";
	}
};
view.TodosView = function() {
	this.todosElement = new view.TodosElement();
	var _g = this;
	this.selected = window.document.body.getElementsByClassName("selected")[0];
	this.selected.onclick = function(e) {
		_g.viewController.updateView();
	};
	this.counterElement = window.document.body.getElementsByClassName("todo-count")[0];
	this.active = window.document.body.getElementsByClassName("active")[0];
	this.active.onclick = function(e1) {
		_g.filterActive();
	};
	this.completed = window.document.body.getElementsByClassName("completed")[0];
	this.completed.onclick = function(e2) {
		_g.filterCompleted();
	};
	this.clearCompletedButton = window.document.body.getElementsByClassName(" clear-completed")[0];
	this.clearCompletedButton.onclick = function(e3) {
		_g.clearCompleted();
	};
	this.inputElement = window.document.body.getElementsByClassName("new-todo")[0];
	this.inputElement.onkeypress = function(event) {
		if(_g.inputElement.value != "" && (event.which == 13 || event.keyCode == 13)) {
			_g.viewController.add(_g.inputElement.value,false);
			_g.viewController.updateView();
			_g.inputElement.value = "";
			return false;
		}
		return true;
	};
};
view.TodosView.prototype = {
	set_viewController: function(controller) {
		this.viewController = controller;
		return controller;
	}
	,add: function(title,isCompleted,id) {
		if(isCompleted == null) isCompleted = false;
		if(title == null) title = "";
		var _g = this;
		var todoView = new view.TodoView(id);
		todoView.todoElement.buttonElement.onclick = function(e) {
			_g["delete"](id);
		};
		todoView.todoElement.labelElement.ondblclick = function(e1) {
			todoView.todoElement.labelElement.contentEditable = "true";
		};
		todoView.todoElement.labelElement.oninput = function(e2) {
			_g.viewController.edit(id,todoView.todoElement.labelElement.textContent);
		};
		todoView.todoElement.checkBoxElement.onclick = function(e3) {
			_g.viewController.setCompleted(id,!_g.viewController.getCompleted(id));
			_g.viewController.updateView();
		};
		todoView.updateTodo(title,isCompleted);
		this.todosElement.add(todoView.todoElement);
	}
	,clearCompleted: function() {
		this.viewController.clearCompleted();
	}
	,filterCompleted: function() {
		this.viewController.filterCompleted();
	}
	,filterActive: function() {
		this.viewController.filterActive();
	}
	,'delete': function(id) {
		this.viewController["delete"](id);
		this.viewController.updateView();
	}
	,changeCounter: function(counter) {
		this.counterElement.firstChild.textContent = counter;
	}
	,edit: function() {
	}
	,clear: function() {
		this.todosElement.clear();
	}
};
Main.main();
})();
