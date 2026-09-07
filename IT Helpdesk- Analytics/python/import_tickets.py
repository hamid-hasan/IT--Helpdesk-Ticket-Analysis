import pandas as pd
import mysql.connector

# 1. CSV file read karo
df = pd.read_csv("Data/tickets.csv")

print("CSV rows:", len(df))

# 2. MySQL connection
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="1503",
    database="it_helpdesk"
)

cursor = conn.cursor()

# 3. Existing tickets delete karo
cursor.execute("DELETE FROM tickets")

# 4. Insert query
query = """
INSERT INTO tickets
(
    ticket_id,
    employee_id,
    category,
    priority,
    status,
    engineer_id,
    created_at,
    assigned_at,
    resolved_at,
    resolution_notes
)
VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
"""

# 5. CSV data MySQL mein insert karo
for _, row in df.iterrows():

    # NaN ko MySQL NULL mein convert karo
    values = tuple(
        None if pd.isna(x) else x
        for x in row
    )

    cursor.execute(query, values)

# 6. Changes save karo
conn.commit()

print("Successfully imported:", len(df), "rows")

# 7. Connection close karo
cursor.close()
conn.close()