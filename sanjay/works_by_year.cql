call apoc.load.json("file:/works_data.json")

call apoc.load.json("file:/works_data.json") yield value
merge (work:Work {name:value.display_name}) ON CREATE SET work.id = value.id, work.doi = value.doi, work.pub_date = value.publication_date
FOREACH (a in value.authorships | merge (author:Author {name: a.author.display_name}))

call apoc.load.json("file:/works_data.json")
YIELD value
MERGE (p:Work {name: value.publication_year})
WITH p, value
UNWIND value.display_name AS child
MERGE (c:Work {name: child})
MERGE (c)-[:CHILD_OF]->(p);

MATCH p=()-[r:PUBLISHED_IN]->() RETURN p LIMIT 300
