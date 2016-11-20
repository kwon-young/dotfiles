
import os
import six.moves.urllib as urllib
import requests
from lxml import html
from screeninfo import get_monitors, Monitor

class ReqContent:
    def __init__(self, url):
        self._url = url
        self._req = None
        self._filename = "/tmp/" + os.path.basename(self.url) + ".html"
    
    @property
    def url(self):
        return self._url
    
    def get(self):
        if os.path.isfile(self._filename):
            with open(self._filename, "r") as f:
                return html.fromstring(f.read())
        else:
            self._req = requests.get(self.url)
            with open(self._filename, "w") as f:
                f.write(str(self._req.content))
            return html.fromstring(self._req.content)

class DownloadImage:
    def __init__(self, htmlElement):
        self._downloadUrl = htmlElement.get("href")
        self._downloadName = htmlElement.get("download")
        self._res = htmlElement.text_content()
    
    def __str__(self):
        str = "DownloadImage object:\n"
        str += "\t" + self._downloadUrl + "\n"
        str += "\t" + self._downloadName + "\n"
        str += "\t" + self._res + "\n"
        return str

def str2monitor(str_res):
    width, height = [int(x) for x in str_res.split('x')]
    return Monitor(0, 0, width, height)

def dist_res(res1, res2):
    r1 = res1.width/float(res1.height)
    r2 = res2.width/float(res2.height)
    dist_ratio = r1 - r2
    dist_x = (res1.width - res2.width) / float(res1.width)
    dist_y = (res1.height - res2.height) / float(res1.height)
    dist_absdist = abs(dist_x) + abs(dist_y)
    return dist_ratio, dist_absdist, dist_x, dist_y

def get_resIndex(goalRes, list_res):
    print(goalRes)
    for res in list_res:
        print("\t", res)
        print(dist_res(goalRes, res))

wallpaper_links = {}
wallpaper_links['2005'] = ["http://desktopography.net/portfolios/", \
                           ["a-lovely-tree",
                            "nen",
                            "pond",
                            "down-by-the-sea",
                            "flying-high",
                            "flying-high-2",
                            "dream",
                            "hushed",
                            "dndln",
                            "altitude",
                            "warm-nature",
                            "entry",
                            "breaking-the-foundation",
                            "take-me-elsewhere",
                            "treehugger",
                            "freshwater",
                            "classic",
                            "wheathump",
                            "anagraph",
                            "new-world",
                            "n55e23",
                            "mars",
                            "sonnet",
                            "desktopography-5-2",
                            "spartan",
                            "the-last-bond",
                            "nine",
                            "ks",
                            "land-of-kingdoms",
                            "morningnight",
                            "abstract-nature",
                            "dtpgry10",
                            "the-path",
                            "birth-of-zhu-rong",
                            "lava",
                            "marcin-stryczek",
                            "the-turtle",
                            "ari",
                            "the-way-to-god",
                            "lifestream",
                            "ride",
                            "spirit",
                            "my-city",
                            "raging-water",
                            "nightfall",
                            "circles",
                            "jungle-rush",
                            "last-rays",
                            "nature-harmony",
                            "beyond-the-atmosphere",
                            "fenrir",
                            "aura",
                            "canyon",
                            "lost-kingdom",
                            "memorial",
                            "lagoon",
                            "moonrise",
                            "natural-freedom",
                            "the-power-of-tomorrow",
                            "parallax",
                            "revenge-of-the-flowers",
                            "hot",
                            "mariana",
                            "sailing",
                            "oceania",
                            "spirits",
                            "magic-in-the-forest",
                            "astraios",
                            "golden-mountain",
                            "elder",
                            "distant-dream",
                            "wonder",
                            "nocturnal",
                            "endless-summer",
                            "magical-predictions",
                            "flare-destiny",
                            "venice",
                            "rift-of-life",
                            "entrance-to-usipsut",
                            "dont-blink-iii",
                            "the-guardian-awakens",
                            "elysium",
                            "waterfall-valley",
                            "to-the-east",
                            "forest-heights",
                            "march-of-the-druids",
                            "jonah",
                            "universus",
                            "the-monolith",
                            "cataclysm",
                            "journey",
                            "extrasolar",
                            "icy-winds",
                            "pillars-of-truth",
                            "aegon",
                            "gol-nafita",
                            "home",
                            "intumesce",
                            "jaianto",
                            "jenkins",
                            "king-owl",
                            "keepers",
                            "desktopography_canyon",
                            "make-a-wish",
                            "maintenence",
                            "man-on-the-moon",
                            "mckennas-eden",
                            "fossilized",
                            "eve",
                            "mother-earth",
                            "mist-islands",
                            "nebula-up-close",
                            "flight-risk",
                            "forest-guardian",
                            "exile",
                            "one-happy-mushroom",
                            "pirate-island",
                            "power-of-nature",
                            "poison-lake",
                            "finding-utopia",
                            "fire-tiger",
                            "snowstorm-over-serenea",
                            "story-about-guardians-of-nature",
                            "desktopography-valley",
                            "sunjay",
                            "the-deliverance",
                            "the-monolith-ii",
                            "titans",
                            "rememberence",
                            "deception",
                            "through-the-mist",
                            "trail-to-the-wicked",
                            "try-harder",
                            "two-million-tomorrows",
                            "curiosity",
                            "children-of-heaven",
                            "curiosity-2",
                            "wasteland",
                            "burning-embers",
                            "tuesday-on-pluto",
                            "beyond",
                            "worlds",
                            "beautiful-flower",
                            "ancient-future",
                            "advent",
                            "finally-serene",
                            "where-the-fck-have-i-crashed",
                            "reset",
                            "abandoned",
                            "voyager",
                            "vine-regalia",
                            "universal-gathering",
                            "united",
                            "the-way-home",
                            "the-valley-of-paths",
                            "the-subsidence",
                            "the-ring-of-worlds",
                            "the-fall",
                            "sweet-home",
                            "star-keeper",
                            "spirit-bird",
                            "rebirth",
                            "overcome",
                            "last-goodbye-to-old-demons",
                            "human-era",
                            "dying-star",
                            "dfgd",
                            "cite-futur",
                            "beauty-world",
                            "at-the-beginning",
                            "road-to-shambhala",
                            "gods-hourglass",
                            "10-years",
                            "looking-for-something-bigger",
                            "rise-of-the-planet",
                            "opus-galaxis",
                            "natural-soul",
                            "infinite",
                            "amarachi",
                            "sunrise-in-the-valley",
                            "breathe-again",
                            "black-water",
                            "sacred",
                            "midway-point",
                            "the-outrock",
                            "menhir-station",
                            "under-control",
                            "nether-grasp",
                            "the-world-is-in-your-hands",
                            "la-lueur",
                            "the-break-of-randomness",
                            "sanctuary",
                            "digital-trip",
                            "winter-castle",
                            "castle-of-the-sun",
                            "life-into-the-valley",
                            "judgement",
                            "jakub-skop",
                            "drought",
                            "exodus",
                            "fields",
                            "hunting-season",
                            "lost-beyond",
                            "entresueno",
                            ]]

dI_list = []
for key, value in wallpaper_links.items():
    for name in value[1]:
        url = urllib.parse.urljoin(value[0], name)
        content = ReqContent(url).get()
        htmlElements = content.find_class("wallpaper-button")
        dI_list.append([])
        for htmlElement in htmlElements:
            dI_list[-1].append(DownloadImage(htmlElement))

img_dir = "/home/kwon-young/Pictures/wallpapers"
monitor_res = get_monitors()[0]
for dI_img in dI_list:
    monitor_list = [str2monitor(x._res) for x in dI_img]
    goalIndex = [i for i, x in enumerate(monitor_list) if x.width == monitor_res.width and x.height == monitor_res.height]
    if len(goalIndex) == 0:
        print("Warning ! res not found for " + dI_img[0]._downloadName)
    goalIndex = goalIndex[0]
    with open(os.path.join(img_dir, dI_img[goalIndex]._downloadName), "wb") as f:
        response = requests.get(dI_img[goalIndex]._downloadUrl)
        f.write(response.content)
