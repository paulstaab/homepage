default: serve

serve:
	docker run --rm -it \
        -v $(shell pwd):/srv/jekyll  \
				-p 127.0.0.1:4000:4000 \
        jekyll/builder:latest /bin/bash -c "chmod 777 /srv/jekyll && jekyll serve -b /hp -H 0.0.0.0 --future"

build:
	docker run --rm \
        -v $(shell pwd):/srv/jekyll  \
        jekyll/builder:latest /bin/bash -c "chmod 777 /srv/jekyll && jekyll build --future"
        
