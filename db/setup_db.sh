#!/bin/bash

# Start SQL Server in the background
echo "Starting SQL Server..."
/opt/mssql/bin/sqlservr &

# Wait for SQL Server to be ready
echo "Waiting for SQL Server to start..."
until /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -C -Q "SELECT 1" &> /dev/null; do
    echo "SQL Server is starting up..."
    sleep 2
done

echo "SQL Server is up - executing init script..."
# Run the initialization script
/opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -C -i /docker-entrypoint-initdb.d/init.sql

echo "Database initialization completed."

# Keep the container running by waiting for the SQL Server process
wait
