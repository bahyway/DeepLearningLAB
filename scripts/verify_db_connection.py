import psycopg2

try:
    # Connect to PostgreSQL
    connection = psycopg2.connect(
        user="user",
        password="password",
        host="db",
        port="5432",
        database="deeplearning_db",
    )
    cursor = connection.cursor()

    # Execute a test query
    cursor.execute("SELECT version();")
    record = cursor.fetchone()
    print("You are connected to - ", record, "\n")

    cursor.close()
    connection.close()
except (Exception, psycopg2.Error) as error:
    print("Error while connecting to PostgreSQL", error)
