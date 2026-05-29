from sqlalchemy import create_engine, text
import pandas as pd

engine = create_engine("mssql+pyodbc://@ADRIANS\\SQLEXPRESS/BookStore"
                       "?trusted_connection=yes"
                       "&TrustServerCertificate=yes"
                       "&driver=ODBC+Driver+18+for+SQL+Server")


query = """
SELECT 
    b.Title,
    CONCAT(a.FirstName, ' ', a.LastName) AS Author,
    b.Genre,
    b.Price,
    b.[Language],
    s.Name AS Store,
    sb.InStock
FROM Books b 
JOIN StockBalance sb ON b.ISBN = sb.ISBN
JOIN BookAuthors ba ON b.ISBN = ba.ISBN 
JOIN Authors a ON ba.Author_Id = a.Author_ID
JOIN Stores s ON sb.Store_ID = s.Store_ID
WHERE LOWER(b.Title) LIKE :search 
OR LOWER(CONCAT(a.FirstName, ' ', a.LastName)) LIKE :search;
"""

search = input("Search for booktitle or author: ").lower()

with engine.connect() as conn:
    result = conn.execute(text(query), {"search": f"%{search}%"})

    result_df = pd.DataFrame(result.fetchall(), columns=result.keys())

result_df = result_df.groupby(
    ["Title", "Genre", "Price", "Language", "Store", "InStock"]
    ).agg({"Author": lambda x: ", ".join(x)}).reset_index().sort_values(
        by=["Title", "Store"]
    )
result_df = result_df[["Title", "Author", "Genre", "Language", "Price", "Store", "InStock"]]

if result_df.empty:
    print("No matching books found")
else:
    print(result_df)