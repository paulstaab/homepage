default: serve

serve:
	echo visit: http://127.0.0.1:4000/hp/
	docker run --rm --privileged -v $(shell pwd):/src -it -p 127.0.0.1:4000:4000 grahamc/jekyll serve -b /hp -H 0.0.0.0

build:
	docker run --rm --privileged -v $(shell pwd):/src -it -p 127.0.0.1:4000:4000 grahamc/jekyll build


