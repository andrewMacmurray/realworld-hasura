# Realworld Hasura

![CI](https://github.com/andrewMacmurray/realworld-hasura/workflows/CI/badge.svg) ![INFRA](https://github.com/andrewMacmurray/realworld-hasura/workflows/Infrastructure/badge.svg) ![CD](https://github.com/andrewMacmurray/realworld-hasura/workflows/CD/badge.svg)

## What?

A Realworld inspired blogging platform using `Hasura` + `Kotlin` + `Elm`

'Inspired' as it doesn't follow the frontend or backend spec for the official `Realworld` example apps (https://github.com/gothinkster/realworld) but tries to replicate the features as closely as possible.

<img width="1265" alt="Screenshot 2020-10-17 at 19 00 02" src="https://user-images.githubusercontent.com/14013616/96349987-0092ba00-10ab-11eb-8355-c50ddd28e94c.png">

### Performance Caveats

- The backend is running on free infrastructure (free heroku postgres db, hasura cloud free and a free heroku dyno), it will very likely topple over if put under load!

### Some notable differences to reference Realworld

- Uses a Graphql Backend (Hasura https://hasura.io/)
- Frontend uses Elm UI for layout (https://package.elm-lang.org/packages/mdgriffith/elm-ui/latest/)
- Mobile responsive
- Modified Layout and design

## Why?

Why not? 🤷‍♀️🐲 I wanted to try out Hasura on a 'real' project and combine it with a number of nice patterns and techniques I've been using in Elm on a work project.

## How?

The project is a monorepo split into `frontend`, `backend` and `infrastructure` (separate READMEs in each directory)

### Frontend

- A single page Elm app (deployed on `surge.sh` https://surge.sh/)

### Backend

- Configuration and migrations for `Hasura` (deployed on `hasura cloud` https://hasura.io/cloud/)
- A `Kotlin` http api that handles authentication and custom application logic, communicates with Hasura as an actions server https://hasura.io/docs/1.0/graphql/core/actions/index.html (deployed on `heroku`)

### Infrastructure

- Terraform configuration for provisioning the actions server, database and secrets https://www.terraform.io/

### Github Actions (CI/CD/Infra)

- Automated tests run on each pull request
- A terraform plan is posted to each pull request
- A full build and deploy of each service happens on merge to `main`
