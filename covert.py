import pandas as pd
import csv
import cx_Oracle
from dotenv import load_dotenv
import os

load_dotenv()  # Load the .env file





# dclaring connection string
dsn = cx_Oracle.makedsn("localhost", 1522, "XE")  
username = os.getenv('DB_USERNAME')
password = os.getenv('DB_PASSWORD')

connection = cx_Oracle.connect(user=username, password=password, dsn=dsn)
cursor = connection.cursor()

input_data = pd.read_csv(r"C:\SQL_Path\homework3\seed.txt", header=None)
headers = ["SID", "CID", "Seed", "Value"]
csv_rows = []
sid = 1

# Process each line in the input txt file
for index, row in input_data.iterrows():
    category_name = row[0].strip()
    print(f"Processing category: '{category_name}'")
    cursor.execute("SELECT CID FROM category WHERE NAME = :name", name=category_name)
    result = cursor.fetchone()

    if result:
        cid = result[0]
    else:
        print(f"Category name '{category_name}' not found in the database.")
        continue 

    for attribute in row[1:]:
        if pd.notna(attribute): 
            csv_rows.append([sid, cid, attribute.strip(), 1])
            sid += 1
cursor.close()
connection.close()

#Creating and writing to csv file
with open('seedWords.csv', 'w', newline='') as csv_file:
    writer = csv.writer(csv_file)
        
    # Write each row
    writer.writerows(csv_rows)

print("Conversion complete. Check the seedWords.csv file.")
