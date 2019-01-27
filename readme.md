# RAILS API

## Learning Objectives
- Practice migrating and seeding a database
- Learn how to set up routes both individually, and with `resources`
- Create controller actions to handle requests and return json
- Use ActiveRecord models within our controller actions
- Use strong params to `require` and `permit` certain data
- Understand how controller callbacks can help keep our code DRY

### Routing

The format of a route is as follows:
```ruby
get '/route/path/:some_param', to: 'controller#action'
```
- The method is first. This can be any of our http methods (`get`, `post`, `put`, `delete`)
- Then comes a string with the path of the route we are making. Any parameters are specified with a `:` before them
- Next we say where the route should point to by having the name of the controller, a `#` then the name of the method within the controller that should be called 

If you are creating full RESTful routes, you can use the shortcut: `resources :resource_name` for example doing:
```ruby
resources :pets
```
will create the following routes:

| Prefix | Verb | URI Pattern | Controller#Action |
---------|------|-------------|-------------------|
|pets|GET|/pets(.:format)|pets#index|
| |POST|/pets(.:format)|pets#create|
|pet|GET|/pets/:id(.:format)|pets#show|
||PATCH|/pets/:id(.:format)|pets#update|
||PUT|/pets/:id(.:format)|pets#update|
||DELETE|/pets/:id(.:format)|pets#destroy|


> TIP: Running `rails routes` in your console will list all of the routes in your application.

### Controllers

In our controllers we handle the information coming from our request and send out a response. Here we can also interact with our models to retrieve data. We can also then send a response by using the `render` method. For apis we want to render json to do so we use: `render json: { your: "data here"  }`. An example of this together would be:

```ruby
def index 
  @pets = Pet.all
  render json: { pets: @pets }
end
```

#### Params

To access information being sent with our request, we can use our `params`. These params have the values for:
- The params specified in our routes
- Any query params sent with the request
- The body data from our request.

We can pretty much use them for everything. If we want to access a specific param, we can do so using bracket notation: `params[:id]`. 

When we are using params to either create or update records in our db, we want to make sure we sanitize and restrict what data is being used. To do so we can use something called [**Strong Params**](https://guides.rubyonrails.org/action_controller_overview.html#strong-parameters). This tool allows us to require and permit certain parameters in requests. 

```ruby
params.require(:pet)
```

The above code will make sure that we have a param called `pet` in our request and return the value of it. If there is no pet param, it will throw a `ActionController::ParameterMissing` error. 

```ruby
params.permit(:name, :owner, :species)
```

This code will filter out any params that are not permitted. This way, we can make sure we only use the parameters we want. It is common to see these used together:

```ruby 
def pet_params
  params.require(:pet).permit(:name, :owner, :species)
end
```

Which would ensure that there is a pet param with only the attributes name, owner, and species. This can then be used to either create or update our pet without worrying about what the user put in:

```ruby
Pet.new(pet_params)
```

#### Controller Callbacks

Often in our controllers patterns arise where we are writing repetitive code. For example, for `:show`, `:update`, and `:destroy` we will always need to find a specific entity by id. To keep our code dry, we can create a method that will preform these actions before we even get to the controller action. We add the method to our controller like any other method:

```ruby
def assign_pet 
  @pet = Pet.find(params[id])
end
```

we can then specify to use this method before certain actions at the top of our controller:

```ruby
before_action :assign_pet, only: [:show, :update, :destroy]
```




