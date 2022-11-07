call apoc.load.json($url) yield value
foreach(i in value.results | merge(r: ResearchPapers {id: i.doi, title: i.display_name, datePublished: date(i.publication_date), related: i.related_works} ))
foreach(a in value.authorships | merge(author: Author {name: a.author.display_name}) ON CREATE SET author.orcid = a.author.orcid, author.id = a.author.id)
