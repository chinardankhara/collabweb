:param url: "https://api.openalex.org/works?mailto=pduong7@gatech.edu&page=1&per-page=200&filter=is_paratext:false,is_retracted:false,authorships.institutions.id:https://openalex.org/I130701444"

call apoc.load.json($url) yield value

//work in progress, have not successfully find a way to skip the null display name
//MERGE (work:Work {name: value.display_name})
//ON CREATE SET work.id = value.id
//ON MATCH SET work.id = value.id

//Work in progress - Seems to be successfully skip null display name but cant connect node
FOREACH (x IN CASE WHEN value.display_name IS NULL THEN [] ELSE [1] END |
  MERGE (:Work {name: SPLIT(value.display_name, '/')}));
  //MERGE (work:Work {name: value.display_name})

ON CREATE SET work.id = value.id    
