run:
	docker run -d -p 443:443 --name src-nginx inception

build:
	docker-compose up -d

# localで作業するために適当なファイルをvolumeにしている
volume:
	mkdir /home/hyunosuk/ /home/hyunosuk/data/