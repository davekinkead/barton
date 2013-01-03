# Barton

### Programmable, Political Access

Barton is an API for Australian electorates and politicians.

## Access

Barton provides a RESTful HTTP interface to political data.  Dive right in at

	http://barton.experimentsindemocracy.org/api/

Barton is read only so you'll only neet GET.

## Requests

The API is build around resources and filters whose canconical form is:

	/resource/[id]?[filters]

Barton currently provides access to _electorate_ and _people_ resources.

To return a single electorate, try

	/electorates/id

Or to return multiple politicians

	/people?filter=values 

A variety of filters are available including _tag_, _geo_, and _address_.

Tag filters are comma separated keywords for resource attributes. For example, you can request all state electorates in Queensland with:

	/electorates?tags=state,queensland

You can reach even deeper with wildcards and attribute limits (tag filters are conjuntive - they try to match all tags).  Want to find all federal MPs from Queensland whose name starts with the letter 'K'? No problems:

	/people?tags=federal,queensland,name:K*


**COMING SOON** 

Address and Geo filters!

## Responses

Barton is designed with HATEOS in mind (well, pragmaticly at least).

## Contributing