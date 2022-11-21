-- loading json data (can be changed to use url format directly from Openalex)
call apoc.load.json("file:/works_data1.json") yield value

-- creating work and author nodes
call apoc.load.json("file:/works_data1.json") yield value
merge (work:Work {name:value.display_name}) ON CREATE SET work.id = value.id, work.doi = value.doi, work.pub_date = value.publication_date, work.genre = value.type, work.pub_year = value.publication_year, work.mag = value.ids.mag, work.authors = size(value.authorships), work.referenced = size(value.referenced_works)
FOREACH (a in value.authorships | merge (author:Author {name: a.author.display_name}) ON CREATE SET author.orcid = a.author.orcid, author.id = a.author.id)  

-- not working code but close to getting a relation between author and works
call apoc.load.json("file:/works_data1.json")
YIELD value
MERGE (p:Author {name: p.name}) 
WITH p, value
WHERE p.name <> null
UNWIND value.display_name AS child
MERGE (c:Work {name: child})
MERGE (c)-[:CHILD_OF]->(p);

-- delete all nodes
MATCH (n) Delete n
