# Barton

## Programmable, Political Access

Barton is an API for Australian electorates and politicains.

## Access

Barton provides RESTful interface to electorate and politician resources.  Dive in with

	http://barton.experimentsindemocracy.org/api/

Barton is read only so you'll only neet GET.

## Requests

The API is build around resources and filters, and takes the form of:

	/resource/[id]?[filters]

To return a single electorate

	/electorates/id

To return multiple politicians

	/members?filter=values 

Tag filters are comma separated keywords for resource attributes. For example, you can request all state electorates in Queensland with

	/electorates?tags=state,queensland

You can reach even deeper with wildcards and attribute limits (tag filters are conjuntive ie. they try to match all tags).  Want all local politicians from Queensland whose name starts with 'C'? No problems

	/members?tags=local,queensland,name:c*

**COMING SOON** 

Address and Geo filters!

## Responses

Barton is designed with HATEOS in mind (well, pragmaticly at least).

## Contributing