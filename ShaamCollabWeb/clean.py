import json

with open("works_data.json", 'r') as file: 
    files = json.load(file)
    clean = files[0]['id']
    authorships = files[0]['authorships']
    for each in authorships:
        print(each['author']['display_name'])
