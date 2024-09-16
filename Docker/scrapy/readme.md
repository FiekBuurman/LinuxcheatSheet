apt update
apt install -y docker.io
systemctl enable docker
systemctl start docker

Start a Docker container for Scrapy:

```docker run -it --name scrapy-container -v /home/buurmans/scrapy:/app -w /app python:3.9-slim bash```

Install Scrapy: Inside the running container:
pip install scrapy
scrapy startproject fuel_prices
cd fuel_prices

Create a Spider: Create a spider file (e.g., fuel_spider.py) inside the spiders directory with the following content:
This spider will scrape the prices and save them in a fuel_prices.json file.

Run the Scrapy spider: Inside the container:
scrapy crawl fuel_prices
