from diophila import OpenAlex
import json

conn = OpenAlex('cdankhara3@gatech.edu')

work_filters = {'authorships.institutions.id':'https://openalex.org/I130701444', 'is_paratext': False, 'is_retracted': False}
page_list = list(range(1, 11))
papers = list(conn.get_list_of_works(filters = work_filters, pages = page_list, per_page = 200))

papers = [i['results'] for i in papers]
retlist = [j for i in papers for j in i]
    
with open('works_data.json', 'w') as f:
  f.write(json.dumps(retlist))