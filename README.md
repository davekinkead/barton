# Barton

### Programmable, Political Access

Barton is an API for Australian electorates and politicians.

## Access

Barton provides a RESTful HTTP interface to political data.  Dive right in at:

	http://barton.experimentsindemocracy.org/api/

Barton is read only so you'll only need GET.

## Requests

The API is build around resources and filters whose canonical form is:

	/resource/[id]?[filters]

Barton currently provides access to _electorate_ and _people_ resources.

To return a single electorate, try:

	/electorates/id

Or to return multiple politicians:

	/people?filter=values 

A variety of filters are available including _tag_, _geo_, and _address_.

_Tag_ filters are comma separated keywords for resource attributes. For example, you can request all state electorates in Queensland with:

	/electorates?tags=state,queensland

You can reach even deeper with wildcards and attribute limits (tag filters are conjunctive - they try to match all tags).  Want to find all local government areas from Queensland that have councillors called 'Steve'? No problems:

	/electorates?tags=lga,queensland,members.name:steve*


**COMING SOON** 

Address and Geo filters!

## Responses

Barton is designed with HATEOS in mind (well, pragmatically at least).

## Contributing