import random

ISBN_List = ['9789132153716', '9780140449334', '9780451526342', '9780451524935', '9780062316097', 
             '9781911709881', '9780140445688', '9780140447576', '9789177425763', '9780670691997', 
             '9789100477677', '9781982110567', '9780307743664']

StoreId = list(range(1, 4))

saldo = [[(ID, ISBN, random.randint(0, 10)) for ISBN in ISBN_List] for ID in StoreId]

saldo = saldo[0] + saldo[1] + saldo[2]

for row in saldo:
    print(row)