require 'opal-react'

class TodoItemComponent
  
  include React::Component
    
  required_param :todo
  
  def render
    div do
      blam!
      "Title: #{todo.title}".br; "Description #{todo.description}".br; "User #{todo.user.name}"
    end
  end
  
end
