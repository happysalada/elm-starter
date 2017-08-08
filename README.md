# elm-starter
starter project for elm, includes
- elm styles elements
- firebase functions
- service workers
## Quick start
- `yarn install` (you need yarn)
- `elm-package install`
- `yarn dev` will fire up a server with live reloading for development
- `yarn build` will build the project for release in production (with minification, service workers, hash marks on scripts, google analytics...)
- `yarn deploy:hosting` will deploy to firebase hosting (you need the firebase cli)
## elm style elements
### what is it?
Elm style elements is a library for safe styling with elm. The purpose it wants to achieve is no more styling bugs for more information check out the [docs](http://package.elm-lang.org/packages/mdgriffith/style-elements/3.3.0/Style-Scale)
### Why this might be interesting to you
I had struggled to find examples for responsive design. Hopefully this repo should help in that regard. Check out View.elm to see how it is integrated
## firebase functions
### what is it?
firebase functions are a pretty cool tool from google to achieve serverless architecture. The idea is that firebase functions can replace your backend. These are just javascript functions that you can deploy on the cloud easily where you put your backend logic.
### prerequisite
you will need to install the firebase cli here is the [docs](https://firebase.google.com/docs/cli/) on how to do it
### Why this might be interetsing to you
Since the elm firebase library is not working with elm 0.18, if you want to use firebase in the meanwhile, check out how the interop is done.
## firebase hosting
### what is it?
you can host your frontend code on firebase hosting servers. This is particularly convenient for elm, since you can deploy frontend code with one command.
### prerequisite
you need to have a firebase project created and the firebase cli [docs](https://firebase.google.com/docs/cli/)
### how to use it
`yarn deploy:hosting`
## service workers
##

TODO
[ ] responsive design with style elements
[ ] firebase port for interoperation
[ ] firebase functions
