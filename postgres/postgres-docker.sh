# in postgres, username is postgres not root
docker run --name my_postgres \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=admin \
  -e POSTGRES_DB=mydb \
  -p 5432:5432 \
  -d postgres

sudo apt update
sudo apt install postgresql-client

# Set Password
psql -h localhost -p 5432 -U postgres -d mydb
# OR
docker exec -it my_postgres psql -U postgres -d mydb
