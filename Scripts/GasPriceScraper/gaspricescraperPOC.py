from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options

# URLs to scrape
urls = [
    "https://www.brandstof-zoeker.nl/station/tinq-delfgauw-delftsestraat-9992/",
    "https://www.brandstof-zoeker.nl/station/tango-delft-9430/",
    "https://www.brandstof-zoeker.nl/station/supertank-delft-488/",
    "https://www.brandstof-zoeker.nl/station/argos-delft-2710/",
    "https://www.brandstof-zoeker.nl/station/makro-delft-2861/"
]

# CSS selector for the value
value_selector = "#page > div:nth-child(3) > div > div:nth-child(2) > dl > dt:nth-child(3) > span"

# Set up headless browser options
options = Options()
options.headless = True
service = Service(executable_path='/usr/bin/chromedriver')

# Initialize WebDriver
driver = webdriver.Chrome(service=service, options=options)

# Function to scrape data from a URL
def scrape_station_data(url):
    driver.get(url)
    try:
        # Extract the station name from the URL (last part after the last "/")
        station_name = url.rstrip('/').split('/')[-1]

        # Extract the value using the CSS selector
        value_element = driver.find_element(By.CSS_SELECTOR, value_selector)
        value = value_element.text.strip()

        print(f"Station: {station_name}, Value: {value}")
    except Exception as e:
        print(f"Failed to scrape {url}. Error: {str(e)}")

# Iterate over the URLs and scrape data
for url in urls:
    scrape_station_data(url)

# Quit the driver
driver.quit()
