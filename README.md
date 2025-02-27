### **Instance Variables in Ruby on Rails (RoR)**  

In Ruby on Rails, **instance variables** (prefixed with `@`) are used in controllers to store data and make it available to the corresponding **views**.

---

### **Example: Using Instance Variables in a Controller**  
```ruby
class PostsController < ApplicationController
  def index
    @posts = Post.all  # Instance variable storing all posts
  end
end
```
- `@posts` is an **instance variable**.
- It's accessible in the `index.html.erb` view.

---

### **Accessing Instance Variables in Views**  
```erb
<!-- app/views/posts/index.html.erb -->
<h1>All Posts</h1>

<% @posts.each do |post| %>
  <p><%= post.title %></p>
<% end %>
```
- The `@posts` variable from the controller is **automatically available** in the view.

---

### **Instance Variables vs. Local Variables**
| Type | Scope | Example |
|------|-------|---------|
| **Instance Variable** (`@variable`) | Available across the controller action and the view | `@user = User.find(1)` |
| **Local Variable** (`variable`) | Only available inside the method where it is defined | `user = User.find(1)` (not accessible in the view) |

---

### **Instance Variables in Multiple Actions**
```ruby
class UsersController < ApplicationController
  def show
    @user = User.find(params[:id]) # Available in show.html.erb
  end

  def edit
    @user = User.find(params[:id]) # Available in edit.html.erb
  end
end
```

---

### **Using Instance Variables in Partial Views**
If you're rendering a partial:
```erb
<%= render "user", user: @user %>
```
In `_user.html.erb`:
```erb
<p>Name: <%= user.name %></p>
```

If using an instance variable (`@user`), you **don’t need to pass it explicitly**.

---

### **Common Mistakes**
❌ **Using instance variables without setting them in the controller**  
```ruby
# WRONG: This will cause an error in the view if @user is nil
<%= @user.name %>
```
✔ **Fix: Check if it's present before using it**
```erb
<%= @user.name if @user.present? %>
```

---

### **Summary**
✅ **Instance variables (`@variable`) are used to pass data from controllers to views.**  
✅ **They persist for a single request-response cycle.**  
✅ **Use them in controllers to store objects that need to be accessed in views.**  

Let me know if you need more details! 🚀