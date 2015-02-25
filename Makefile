all: build
.PHONY: build show

build:
	docker run --rm -v "${PWD}:/src" grahamc/jekyll build

serve:
	docker run -d -v "${PWD}:/src" -p 4000:4000 grahamc/jekyll serve -H 0.0.0.0 --baseurl /hp

show:
	firefox http://127.0.0.1:4000/hp/

