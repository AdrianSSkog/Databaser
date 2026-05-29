import random

firstnames = ["Carl", "Philip", "Johan", "Ulf", "Bengt", "Kurt", "Harald", "Britta", "Anna", "Sofia", "Felicia", "Carolina", "Hilda"]
Lastnames = ["Svensson", "Karlsson", "Svan", "Andersson", "Måndotter", "Renault", "Aubert", "Bernard", "Dufour", "Garcia", "Dufva", "Svärd", "Afzelius"]
random.shuffle(Lastnames)

domains = ["@gmail.com", "@hotmail.com", "@yahoo.com", "@outlook.com"]

phonenumbers = [f"07{random.randint(0, 99999999):08d}" for _ in range(13)]

Cities = [("Sweden", "Göteborg"), 
          ("Sweden", "Stockholm"), 
          ("Sweden", "Eskilstuna"), 
          ("Sweden", "Solna"), 
          ("France", "Paris"), 
          ("Sweden", "Borås"), 
          ("Sweden", "Kungsbacka")]

Costumers = []

for firstname, lastname, number in zip(firstnames, Lastnames, phonenumbers):
    domain = random.choice(domains)
    country, city = random.choice(Cities)
    costumer = (firstname, lastname, f"{firstname.lower()}.{lastname.lower()}{domain}", number, city, country)
    Costumers.append(costumer)

for c in Costumers:
    print(c)