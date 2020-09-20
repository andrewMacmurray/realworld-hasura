FROM hasura/graphql-engine:v1.3.2.cli-migrations-v2

ENV HASURA_GRAPHQL_CLI_ENVIRONMENT default

COPY . .

CMD graphql-engine --database-url $DATABASE_URL serve --server-port $PORT