#Import all needed libraries
import requests
from bs4 import BeautifulSoup
from urllib.parse import urljoin
import csv

#Set the base URL to create Absolute Tutorials
#Set the URL to search from
base = 'https://www.census.gov'
url = 'https://www.census.gov/programs-surveys/popest.html'

#Initiate the Request to get the URL and save as data
r = requests.get(url)
data = r.text

#Initiate BeautifulSoup to parse out the href links
soup = BeautifulSoup(data, 'lxml')
links = soup.find_all('a', {"href": True})
#Extract only the URLs and remove the preceeding /
links = [link.get('href').rstrip('\/') for link in links]

#Join the base URL to create an Absolute URI to the needed links
#Use set comprehension to ddup the list of links
link_set = {urljoin(base, link) for link in links}

#Write the set of links to a CSV
f = csv.writer(open('CurrentEstimateLinks.csv','w', newline=''))
for link in link_set:
    f.writerows([[link]])
