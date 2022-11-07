//this code saves the api query to "url" variable
//you can use this variable to request data directly from openalex
:param url: "https://api.openalex.org/works?mailto=cdaknhara3@gatech.edu&page=1&per-page=200&filter=is_paratext:false,is_retracted:false,authorships.institutions.id:https://openalex.org/I130701444"

//works code. data model in progress
call apoc.load.json($url)
yield value
foreach(i in value.results | merge(r: ResearchProduct {id: i.doi, title: i.display_name, datePublished: date(i.publication_date), related: i.related_works} ))

//concept graph code. work in progress
call apoc.load.json($url)
yield value
foreach(i in value.results | merge(t: Topic {id: i.id, name: i.display_name, description: i.description, wikidata: i.wikidata}))
foreach(i in value.results | foreach(a in i.ancestors | merge(t: Topic {id: a.id, name: a.display_name, level: a.level})))
foreach(i in value.results | foreach(a in i.related_concepts | merge(t: Topic {id: a.id, name: a.display_name, level: a.level})))