## Setup Server

```
cp ./lib/sprinkle/config.rb.example to ./lib/sprinkle/config.rb
```

run
```
sprinkle -c -v -s lib/sprinkle/config.rb
```
## Setup App

```
cap deploy:setup
```

## Deploy App

```
cap deploy
```