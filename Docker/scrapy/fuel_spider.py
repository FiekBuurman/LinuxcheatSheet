import scrapy
from datetime import datetime

class FuelSpider(scrapy.Spider):
    name = "fuel_prices"
    start_urls = [
        {
            "name": "Fuel Price TinQ Delfgauw",
            "url": "https://www.brandstof-zoeker.nl/station/tinq-delfgauw-delftsestraat-9992/",
            "css_selector": "#page > div:nth-child(3) > div > div:nth-child(2) > dl > dt:nth-child(3) > span.badge.bg-primary.rounded-pill.float-end"
        },
        {
            "name": "Fuel Price Tango Delft",
            "url": "https://www.brandstof-zoeker.nl/station/tango-delft-9430/",
            "css_selector": "#page > div:nth-child(3) > div > div:nth-child(2) > dl > dt:nth-child(3) > span.badge.bg-primary.rounded-pill.float-end"
        },
        {
            "name": "Fuel Price Supertank Delft",
            "url": "https://www.brandstof-zoeker.nl/station/supertank-delft-488/",
            "css_selector": "#page > div:nth-child(3) > div > div:nth-child(2) > dl > dt:nth-child(3) > span.badge.bg-primary.rounded-pill.float-end"
        },
        {
            "name": "Fuel Price Argos Delft",
            "url": "https://www.brandstof-zoeker.nl/station/argos-delft-2710/",
            "css_selector": "#page > div:nth-child(3) > div > div:nth-child(2) > dl > dt:nth-child(3) > span.badge.bg-primary.rounded-pill.float-end"
        },
        {
            "name": "Fuel Price Makro Delft",
            "url": "https://www.brandstof-zoeker.nl/station/makro-delft-2861/",
            "css_selector": "#page > div:nth-child(3) > div > div:nth-child(2) > dl > dt:nth-child(3) > span.badge.bg-primary.rounded-pill.float-end"
        }
    ]

    custom_settings = {
        'FEED_FORMAT': 'json',
        'FEED_URI': 'fuel_prices.json'
    }

    def start_requests(self):
        for station in self.start_urls:
            yield scrapy.Request(url=station["url"], callback=self.parse, meta={'station_name': station["name"], 'css_selector': station["css_selector"]})

    def parse(self, response):
        station_name = response.meta['station_name']
        css_selector = response.meta['css_selector']
        
        # Extract the price text
        price_text = response.css(css_selector + "::text").get()
        sup_text = response.css(css_selector + " sup::text").get()
        
        # Combine the main price text and the sup text
        if price_text and sup_text:
            price = price_text.replace('€\xa0', '') + sup_text  # Combine and remove the € and nbsp characters
        else:
            price = None
        
        # Add the current datetime
        updated_at = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        
        yield {
            'name': station_name,
            'price': price,
            'updated': updated_at  # Add timestamp to the output
        }
