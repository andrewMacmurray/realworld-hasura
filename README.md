# Realworld Hasura

![CI](https://github.com/andrewMacmurray/realworld-hasura/workflows/CI/badge.svg) ![CD](https://github.com/andrewMacmurray/realworld-hasura/workflows/CD/badge.svg)

## What?

A Realworld inspired blogging platform using `Hasura` + `Purescript` + `Elm`

'Inspired' as it doesn't follow the frontend or backend spec for the official `Realworld` example apps (https://github.com/gothinkster/realworld) but tries to replicate the features as closely as possible.

<img width="1265" alt="Screenshot 2020-10-17 at 19 00 02" src="https://user-images.githubusercontent.com/14013616/96349987-0092ba00-10ab-11eb-8355-c50ddd28e94c.png">

### Some notable differences to reference Realworld

- Uses a Graphql Backend (Hasura https://hasura.io/)
- Frontend uses Elm UI for layout (https://package.elm-lang.org/packages/mdgriffith/elm-ui/latest/)
- Mobile responsive
- Modified Layout and design

## How?

The project is a monorepo split into `frontend`, `backend` (separate READMEs in each directory)

### Frontend

- A single page Elm app (deployed on `vercel` https://vercel.com)

### Backend

- A Hasura instance is deployed on Heroku
- A [YugabyteDB Managed](https://www.yugabyte.com/managed/) instance
- A `Purescript` serverless http api that handles authentication and custom application logic, communicates with Hasura as an actions server https://hasura.io/docs/1.0/graphql/core/actions/index.html (deployed on `vercel`)

### Github Actions (CI/CD/Infra)

- Automated tests run on each pull request
- A full build and deploy of each service happens on merge to `main`

## Run it Locally

Make sure you have `docker` and `node` installed

Install dependencies:

```sh
npm install
```

Start Hasura and Postgres:

```sh
npm run hasura
```

Run the migrations

```sh
npm run migrate
```

Start the frontend

```sh
npm run dev
```

Start the actions server

```sh
npm run actions
```
