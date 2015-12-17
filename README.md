## InfiniteScroll

### Dependency

```ruby
gem 'jquery-rails'
gem 'kaminari'
```

### Usage
```ruby
rails g scaffold todo title:string
```
#### Model
```ruby
class Todo < ActiveRecord::Base
  paginates_per 20
end
```
#### Controller
```ruby
class TodosController < ApplicationController
...
def index
  @todos = Todo.page(params[:page])
end
...
```
### Views
#### index.html.erb
```ruby
<p id="notice"><%= notice %></p>

<h1>Listing Todos</h1>

<table>
  <thead>
    <tr>
      <th>Title</th>
      <th colspan="3"></th>
    </tr>
  </thead>

  <tbody class="todos">
    <%= render @todos %>
  </tbody>
</table>

<br>

<%= link_to 'New Todo', new_todo_path %>
<div class='paginator'>
  <%= paginate @todos, remote: true %>
</div>
```

#### _todo.html.erb
```ruby
<tr>
  <td><%= todo.title %></td>
  <td><%= link_to 'Show', todo %></td>
  <td><%= link_to 'Edit', edit_todo_path(todo) %></td>
  <td><%= link_to 'Destroy', todo, method: :delete, data: { confirm: 'Are you sure?' } %></td>
</tr>
```
#### index.js.erb
```ruby
$('tbody.todos').append("<%= escape_javascript(render @todos) %>");
$('.paginator').html("<%= escape_javascript(paginate @todos, remote: true)%>")
```
#### todos.coffee
```coffeescript
$(document).ready ->
  # hide all paginators, or user will click on it accidentally
  $('.paginator').hide()
  maxPosition = 10   # set initial max position
  $(window).scroll ->
    # take maxPosition as current bottomline to prevent from triggered during scrolling back
    maxPosition = $(window).scrollTop() + window.innerHeight if $(window).scrollTop() + window.innerHeight > maxPosition
    # the next link of kaminari you want to click, change it if you use kaminari themes
    paginator = $('.next a').eq(0)
    if $(window).scrollTop() + window.innerHeight + 50 > paginator.position().top and paginator.data('infiniteScroll') isnt 'clicked'
      paginator.click()
      # mark clicked link as 'clicked'
      paginator.data('infiniteScroll', 'clicked')
```
