# README

## About ##

A Rails application/API for a fictional merchanidising store that sells trousers, hoodies and mugs.


## API ##

The API is comprised of REST endpoints and is designed to handle requests/responses in JSON format.

Clients should send requests with body/payload in JSON only.

Any request body must refer to items in the store by the same ID numbers provided by the API.


#### List items ####
Lists all items in the store:
```
GET   /items
```
#### Update item ####
Updates an item in the store:
```
PUT   /items/:id

{
    "item": {
        "code": "HOODIE",
        "name": "Amazing Hoodie",
        "price": "18.0"
    }
}
```
#### Total price ####
Calculates the total price, including any applicable discounts, from a purchase list.
```
POST   /items/total

{
    "list": [
        {
            "item_id": "2",
            "quantity": "56"
        },
        {
            "item_id": "3",
            "quantity": "7"
        },
        {
            "item_id": "1",
            "quantity": "19"
        }
    ]
}
```

## Development ##

Use `git clone` to get a local copy of the repository.

You'll need MySQL installed locally or running in a docker container.

Run `bundle install`.

Run `db:create db:migrate db:seed` once to setup the database with seed data, then in the future run `rake db:drop db:create db:migrate db:seed` if you want to return the seed data to its original state.

Rub `rails s` or `bundle exec rails s` to run the application. You can view the data at `http://localhost:3000/items` in your web browswer.

Run `rails c` or `bundle exec rails c` to run the Rails console and interact with components and data.

Run `rspec` or `bundle exec rspec` to run the automated test suite.

Run `rubocop` or `bundle exec rubocop` to run the linter.

You can use these example `cURL` commands to manually test the API:
```
curl -X GET http://localhost:3000/items -H 'Content-Type: application/json'

curl -X PUT http://localhost:3000/items/1 -d '{"item": {"code": "TROUSERS", "name": "Amazing Trousers", "price": "30.0"}}' -H 'Content-Type: application/json'

curl -X POST http://localhost:3000/items/total -d '{"list": [{"item_id": "1", "quantity": "10"}]}' -H 'Content-Type: application/json'
```
