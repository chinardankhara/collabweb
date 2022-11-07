// import data
call apoc.load.json("file:/works_data.json") yield value
MERGE (work:Work {title:value.title}) ON CREATE SET work.id = value.id, work.related_works = value.related_works

// create unique relation if a exists in b's related_works list
// displays nodes with relations
MATCH (a:Work), (b:Work) WHERE a.id IN b.related_works AND a.id <> b.id
MERGE (a)-[r: RELATED_TO]->(b)
RETURN a,b 

// display all nodes
MATCH (n) RETURN n LIMIT 200